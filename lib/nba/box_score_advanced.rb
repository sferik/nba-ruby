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
        **efficiency_stats(data), **tempo_stats(data), usg_pct: data["USG_PCT"], e_usg_pct: data["E_USG_PCT"])
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

    # Extracts rating statistics from data
    # @api private
    # @return [Hash]
    def self.rating_stats(data)
      {e_off_rating: data["E_OFF_RATING"], off_rating: data["OFF_RATING"],
       e_def_rating: data["E_DEF_RATING"], def_rating: data["DEF_RATING"],
       e_net_rating: data["E_NET_RATING"], net_rating: data["NET_RATING"]}
    end
    private_class_method :rating_stats

    # Extracts efficiency statistics from data
    # @api private
    # @return [Hash]
    def self.efficiency_stats(data)
      {ast_pct: data["AST_PCT"], ast_tov: data["AST_TOV"], ast_ratio: data["AST_RATIO"],
       oreb_pct: data["OREB_PCT"], dreb_pct: data["DREB_PCT"], reb_pct: data["REB_PCT"],
       tov_pct: data["TM_TOV_PCT"], efg_pct: data["EFG_PCT"], ts_pct: data["TS_PCT"], pie: data["PIE"]}
    end
    private_class_method :efficiency_stats

    # Extracts tempo statistics from data
    # @api private
    # @return [Hash]
    def self.tempo_stats(data)
      {e_pace: data["E_PACE"], pace: data["PACE"], pace_per40: data["PACE_PER40"], poss: data["POSS"]}
    end
    private_class_method :tempo_stats
  end
end
