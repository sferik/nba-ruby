require "date"
require "json"
require_relative "client"
require_relative "collection"
require_relative "game"
require_relative "team"
require_relative "teams"

module NBA
  # Provides methods to retrieve NBA scoreboard data
  module Scoreboard
    # Retrieves games for a specific date
    #
    # @api public
    # @example
    #   games = NBA::Scoreboard.games(date: Date.today)
    #   games.each { |game| puts "#{game.away_team.name} @ #{game.home_team.name}" }
    # @param date [Date] the date to retrieve games for (defaults to today)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of games
    def self.games(date: Date.today, client: CLIENT)
      path = "scoreboardv2?GameDate=#{date}&LeagueID=00&DayOffset=0"
      response = client.get(path)
      parse_scoreboard_response(response)
    end

    # Parses the scoreboard API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of games
    def self.parse_scoreboard_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      game_header = find_result_set(data, "GameHeader")
      line_score = find_result_set(data, "LineScore")
      return Collection.new unless game_header && line_score

      games = build_games(game_header, line_score)
      Collection.new(games)
    end
    private_class_method :parse_scoreboard_response

    # Finds a result set by name
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String] the result set name to find
    # @return [Hash, nil] the result set or nil
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets")
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(name) }
    end
    private_class_method :find_result_set

    # Builds games from result sets
    #
    # @api private
    # @param game_header [Hash] the GameHeader result set
    # @param line_score [Hash] the LineScore result set
    # @return [Array<Game>] the built games
    def self.build_games(game_header, line_score)
      header_data = parse_result_set(game_header)
      score_data = parse_result_set(line_score)

      header_data.map do |game_info|
        game_id = game_info.fetch("GAME_ID")
        team_scores = score_data.select { |s| s.fetch("GAME_ID").eql?(game_id) }
        build_game(game_info, team_scores)
      end
    end
    private_class_method :build_games

    # Parses a result set into an array of hashes
    #
    # @api private
    # @param result_set [Hash] the result set
    # @return [Array<Hash>] array of data hashes
    def self.parse_result_set(result_set)
      headers = result_set.fetch("headers")
      rows = result_set.fetch("rowSet")
      return [] unless headers && rows

      rows.map { |row| headers.zip(row).to_h }
    end
    private_class_method :parse_result_set

    # Builds a game from header and score data
    #
    # @api private
    # @param game_info [Hash] the game header info
    # @param team_scores [Array<Hash>] the team score data
    # @return [Game] the built game
    def self.build_game(game_info, team_scores)
      Game.new(**game_attributes(game_info, team_scores))
    end
    private_class_method :build_game

    # Extracts game attributes from game info and scores
    #
    # @api private
    # @param info [Hash] the game header info
    # @param scores [Array<Hash>] the team score data
    # @return [Hash] the game attributes
    def self.game_attributes(info, scores)
      {
        id: info.fetch("GAME_ID"), date: info.fetch("GAME_DATE_EST"),
        status: game_status(info.fetch("GAME_STATUS_ID")),
        home_team: find_team(info.fetch("HOME_TEAM_ID")),
        away_team: find_team(info.fetch("VISITOR_TEAM_ID")),
        home_score: find_score(scores, info.fetch("HOME_TEAM_ID")),
        away_score: find_score(scores, info.fetch("VISITOR_TEAM_ID")),
        arena: info.fetch("ARENA_NAME")
      }
    end
    private_class_method :game_attributes

    # Finds the score for a team
    #
    # @api private
    # @param scores [Array<Hash>] the team score data
    # @param team_id [Integer] the team ID
    # @return [Integer, nil] the score
    def self.find_score(scores, team_id)
      score_data = scores.find { |s| s.fetch("TEAM_ID").eql?(team_id) }
      extract_score(score_data)
    end
    private_class_method :find_score

    # Extracts score from score data
    #
    # @api private
    # @param score_data [Hash, nil] the score data
    # @return [Integer, nil] the score
    def self.extract_score(score_data)
      return unless score_data

      score_data["PTS"]
    end
    private_class_method :extract_score

    # Converts game status ID to string
    #
    # @api private
    # @param status_id [Integer] the status ID
    # @return [String] the status string
    def self.game_status(status_id)
      case status_id
      when 1 then "Scheduled"
      when 2 then "In Progress"
      when 3 then "Final"
      else "Unknown"
      end
    end
    private_class_method :game_status

    # Finds a team by ID
    #
    # @api private
    # @param team_id [Integer] the team ID
    # @return [Team, nil] the team or nil
    def self.find_team(team_id)
      Teams.find(team_id)
    end
    private_class_method :find_team
  end
end
