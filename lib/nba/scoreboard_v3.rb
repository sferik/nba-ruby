require "date"
require "json"
require_relative "client"
require_relative "collection"
require_relative "game"
require_relative "league"
require_relative "team"
require_relative "teams"

module NBA
  # Provides methods to retrieve NBA scoreboard data using the V3 endpoint
  module ScoreboardV3
    # Retrieves games for a specific date
    #
    # @api public
    # @example
    #   games = NBA::ScoreboardV3.games(date: Date.today)
    #   games.each { |game| puts "#{game.away_team.name} @ #{game.home_team.name}" }
    # @param date [Date] the date to retrieve games for (defaults to today)
    # @param league [League, String] the league ID (defaults to NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of games
    def self.games(date: Date.today, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = "scoreboardv3?GameDate=#{date}&LeagueID=#{league_id}"
      response = client.get(path)
      parse_scoreboard_response(response)
    end

    # Parses the scoreboard API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of games
    def self.parse_scoreboard_response(response)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      scoreboard = data["scoreboard"]
      return Collection.new unless scoreboard

      game_data = scoreboard["games"]
      return Collection.new unless game_data

      games = game_data.map { |game_info| build_game(game_info) }
      Collection.new(games)
    end
    private_class_method :parse_scoreboard_response

    # Builds a game from game data
    #
    # @api private
    # @param game_info [Hash] the game info
    # @return [Game] the built game
    def self.build_game(game_info)
      Game.new(**game_attributes(game_info))
    end
    private_class_method :build_game

    # Extracts game attributes from game info
    #
    # @api private
    # @param info [Hash] the game info
    # @return [Hash] the game attributes
    def self.game_attributes(info)
      {
        id: info["gameId"],
        date: info["gameTimeUTC"],
        status: game_status(info["gameStatus"]),
        home_team: find_team(info.dig("homeTeam", "teamId")),
        away_team: find_team(info.dig("awayTeam", "teamId")),
        home_score: info.dig("homeTeam", "score"),
        away_score: info.dig("awayTeam", "score"),
        arena: info["arenaName"]
      }
    end
    private_class_method :game_attributes

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
