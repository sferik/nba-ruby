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
      {game_id: data.fetch("GAME_ID", nil), team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       team_city: data.fetch("TEAM_CITY", nil), player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       start_position: data.fetch("START_POSITION", nil), comment: data.fetch("COMMENT", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :player_identity

    # Extracts team identity attributes from data
    # @api private
    # @return [Hash]
    def self.team_identity(data)
      {game_id: data.fetch("GAME_ID", nil), team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), team_city: data.fetch("TEAM_CITY", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :team_identity

    # Extracts four factors statistics from data
    # @api private
    # @return [Hash]
    def self.four_factors(data)
      {efg_pct: data.fetch("EFG_PCT", nil), fta_rate: data.fetch("FTA_RATE", nil), tov_pct: data.fetch("TM_TOV_PCT", nil),
       oreb_pct: data.fetch("OREB_PCT", nil), opp_efg_pct: data.fetch("OPP_EFG_PCT", nil), opp_fta_rate: data.fetch("OPP_FTA_RATE", nil),
       opp_tov_pct: data.fetch("OPP_TOV_PCT", nil), opp_oreb_pct: data.fetch("OPP_OREB_PCT", nil)}
    end
    private_class_method :four_factors
  end
end
