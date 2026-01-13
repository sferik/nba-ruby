require_relative "client"
require_relative "response_parser"
require_relative "box_score_four_factors_player_stat"
require_relative "box_score_four_factors_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve four factors box score statistics
  module BoxScoreFourFactors
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player four factors box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreFourFactors.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.efg_pct}% eFG" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player four factors box score stats
    def self.player_stats(game:, client: CLIENT)
      path = "boxscorefourfactorsv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: PLAYER_STATS) { |data| build_player_stat(data) }
    end

    # Retrieves team four factors box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreFourFactors.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.tov_pct}% TOV" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team four factors box score stats
    def self.team_stats(game:, client: CLIENT)
      path = "boxscorefourfactorsv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: TEAM_STATS) { |data| build_team_stat(data) }
    end

    # Builds a player four factors stat from API data
    # @api private
    # @return [BoxScoreFourFactorsPlayerStat]
    def self.build_player_stat(data)
      BoxScoreFourFactorsPlayerStat.new(**player_identity(data), **four_factors(data))
    end
    private_class_method :build_player_stat

    # Builds a team four factors stat from API data
    # @api private
    # @return [BoxScoreFourFactorsTeamStat]
    def self.build_team_stat(data)
      BoxScoreFourFactorsTeamStat.new(**team_identity(data), **four_factors(data))
    end
    private_class_method :build_team_stat

    # Extracts player identity attributes from data
    # @api private
    # @return [Hash]
    def self.player_identity(data)
      {game_id: data["GAME_ID"], team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_city: data["TEAM_CITY"], player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       start_position: data["START_POSITION"], comment: data["COMMENT"], min: data["MIN"]}
    end
    private_class_method :player_identity

    # Extracts team identity attributes from data
    # @api private
    # @return [Hash]
    def self.team_identity(data)
      {game_id: data["GAME_ID"], team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       team_abbreviation: data["TEAM_ABBREVIATION"], team_city: data["TEAM_CITY"], min: data["MIN"]}
    end
    private_class_method :team_identity

    # Extracts four factors statistics from data
    # @api private
    # @return [Hash]
    def self.four_factors(data)
      {efg_pct: data["EFG_PCT"], fta_rate: data["FTA_RATE"], tov_pct: data["TM_TOV_PCT"],
       oreb_pct: data["OREB_PCT"], opp_efg_pct: data["OPP_EFG_PCT"], opp_fta_rate: data["OPP_FTA_RATE"],
       opp_tov_pct: data["OPP_TOV_PCT"], opp_oreb_pct: data["OPP_OREB_PCT"]}
    end
    private_class_method :four_factors
  end
end
