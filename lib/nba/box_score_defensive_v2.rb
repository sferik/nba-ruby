require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_defensive_player_stat"
require_relative "box_score_defensive_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve defensive statistics for a game
  module BoxScoreDefensiveV2
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves defensive statistics for players in a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreDefensiveV2.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.name_i}: #{s.steals} steals" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player defensive stats
    def self.player_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscoredefensivev2?GameID=#{game_id}"
      response = client.get(path)
      parse_player_response(response, game_id)
    end

    # Retrieves defensive statistics for teams in a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreDefensiveV2.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.minutes} minutes" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team defensive stats
    def self.team_stats(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscoredefensivev2?GameID=#{game_id}"
      response = client.get(path)
      parse_team_response(response, game_id)
    end

    # Parses player stats response
    # @api private
    # @param response [String, nil] the JSON response
    # @param game_id [String] the game ID
    # @return [Collection] collection of player stats
    def self.parse_player_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, PLAYER_STATS)
      return Collection.new unless result_set

      build_player_stats(result_set, game_id)
    end
    private_class_method :parse_player_response

    # Parses team stats response
    # @api private
    # @param response [String, nil] the JSON response
    # @param game_id [String] the game ID
    # @return [Collection] collection of team stats
    def self.parse_team_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, TEAM_STATS)
      return Collection.new unless result_set

      build_team_stats(result_set, game_id)
    end
    private_class_method :parse_team_response

    # Finds a result set by name
    # @api private
    # @param data [Hash] the parsed JSON
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(name) }
    end
    private_class_method :find_result_set

    # Builds player stats collection
    # @api private
    # @param result_set [Hash] the result set
    # @param game_id [String] the game ID
    # @return [Collection] collection of player stats
    def self.build_player_stats(result_set, game_id)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_player_stat(headers, row, game_id) }
      Collection.new(stats)
    end
    private_class_method :build_player_stats

    # Builds team stats collection
    # @api private
    # @param result_set [Hash] the result set
    # @param game_id [String] the game ID
    # @return [Collection] collection of team stats
    def self.build_team_stats(result_set, game_id)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_team_stat(headers, row, game_id) }
      Collection.new(stats)
    end
    private_class_method :build_team_stats

    # Builds a player stat
    # @api private
    # @return [BoxScoreDefensivePlayerStat] the player stat
    def self.build_player_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScoreDefensivePlayerStat.new(**player_identity(data, game_id), **defensive_stats(data), **shooting_stats(data))
    end
    private_class_method :build_player_stat

    # Builds a team stat
    # @api private
    # @return [BoxScoreDefensiveTeamStat] the team stat
    def self.build_team_stat(headers, row, game_id)
      data = headers.zip(row).to_h
      BoxScoreDefensiveTeamStat.new(**team_identity(data, game_id))
    end
    private_class_method :build_team_stat

    # Extracts player identity attributes
    # @api private
    # @return [Hash] identity attributes
    def self.player_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("teamId"), team_city: data.fetch("teamCity"),
       team_name: data.fetch("teamName"), team_tricode: data.fetch("teamTricode"), team_slug: data.fetch("teamSlug"),
       person_id: data.fetch("personId"), first_name: data.fetch("firstName"), family_name: data.fetch("familyName"),
       name_i: data.fetch("nameI"), player_slug: data.fetch("playerSlug"), position: data.fetch("position"),
       comment: data.fetch("comment"), jersey_num: data.fetch("jerseyNum")}
    end
    private_class_method :player_identity

    # Extracts team identity attributes
    # @api private
    # @return [Hash] identity attributes
    def self.team_identity(data, game_id)
      {game_id: game_id, team_id: data.fetch("teamId"), team_city: data.fetch("teamCity"),
       team_name: data.fetch("teamName"), team_tricode: data.fetch("teamTricode"), team_slug: data.fetch("teamSlug"),
       minutes: data.fetch("minutes")}
    end
    private_class_method :team_identity

    # Extracts defensive stats
    # @api private
    # @return [Hash] defensive stats
    def self.defensive_stats(data)
      {matchup_minutes: data.fetch("matchupMinutes"), partial_possessions: data.fetch("partialPossessions"),
       switches_on: data.fetch("switchesOn"), player_points: data.fetch("playerPoints"),
       defensive_rebounds: data.fetch("defensiveRebounds"), matchup_assists: data.fetch("matchupAssists"),
       matchup_turnovers: data.fetch("matchupTurnovers"), steals: data.fetch("steals"), blocks: data.fetch("blocks")}
    end
    private_class_method :defensive_stats

    # Extracts shooting stats
    # @api private
    # @return [Hash] shooting stats
    def self.shooting_stats(data)
      {matchup_field_goals_made: data.fetch("matchupFieldGoalsMade"),
       matchup_field_goals_attempted: data.fetch("matchupFieldGoalsAttempted"),
       matchup_field_goal_percentage: data.fetch("matchupFieldGoalPercentage"),
       matchup_three_pointers_made: data.fetch("matchupThreePointersMade"),
       matchup_three_pointers_attempted: data.fetch("matchupThreePointersAttempted"),
       matchup_three_pointer_percentage: data.fetch("matchupThreePointerPercentage")}
    end
    private_class_method :shooting_stats
  end
end
