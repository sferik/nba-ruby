require_relative "box_score_advanced_player_stat"
require_relative "box_score_advanced_team_stat"
require_relative "client"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve advanced box score statistics
  module BoxScoreAdvanced
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player advanced box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreAdvanced.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.off_rating} ORTG" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player advanced box score stats
    def self.player_stats(game:, client: CLIENT)
      path = "boxscoreadvancedv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: PLAYER_STATS) { |data| build_player_stat(data) }
    end

    # Retrieves team advanced box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreAdvanced.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.off_rating} ORTG" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team advanced box score stats
    def self.team_stats(game:, client: CLIENT)
      path = "boxscoreadvancedv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: TEAM_STATS) { |data| build_team_stat(data) }
    end

    # Builds a player stat object from API data
    # @api private
    # @return [BoxScoreAdvancedPlayerStat]
    def self.build_player_stat(data)
      BoxScoreAdvancedPlayerStat.new(**player_identity(data), **rating_stats(data),
        **efficiency_stats(data), **tempo_stats(data), usg_pct: data.fetch("USG_PCT", nil), e_usg_pct: data.fetch("E_USG_PCT", nil))
    end
    private_class_method :build_player_stat

    # Builds a team stat object from API data
    # @api private
    # @return [BoxScoreAdvancedTeamStat]
    def self.build_team_stat(data)
      BoxScoreAdvancedTeamStat.new(**team_identity(data), **rating_stats(data),
        **efficiency_stats(data), **tempo_stats(data))
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

    # Extracts rating statistics from data
    # @api private
    # @return [Hash]
    def self.rating_stats(data)
      {e_off_rating: data.fetch("E_OFF_RATING", nil), off_rating: data.fetch("OFF_RATING", nil),
       e_def_rating: data.fetch("E_DEF_RATING", nil), def_rating: data.fetch("DEF_RATING", nil),
       e_net_rating: data.fetch("E_NET_RATING", nil), net_rating: data.fetch("NET_RATING", nil)}
    end
    private_class_method :rating_stats

    # Extracts efficiency statistics from data
    # @api private
    # @return [Hash]
    def self.efficiency_stats(data)
      {ast_pct: data.fetch("AST_PCT", nil), ast_tov: data.fetch("AST_TOV", nil),
       ast_ratio: data.fetch("AST_RATIO", nil), oreb_pct: data.fetch("OREB_PCT", nil),
       dreb_pct: data.fetch("DREB_PCT", nil), reb_pct: data.fetch("REB_PCT", nil),
       tov_pct: data.fetch("TM_TOV_PCT", nil), efg_pct: data.fetch("EFG_PCT", nil),
       ts_pct: data.fetch("TS_PCT", nil), pie: data.fetch("PIE", nil)}
    end
    private_class_method :efficiency_stats

    # Extracts tempo statistics from data
    # @api private
    # @return [Hash]
    def self.tempo_stats(data)
      {e_pace: data.fetch("E_PACE", nil), pace: data.fetch("PACE", nil), pace_per40: data.fetch("PACE_PER40", nil),
       poss: data.fetch("POSS", nil)}
    end
    private_class_method :tempo_stats
  end
end
