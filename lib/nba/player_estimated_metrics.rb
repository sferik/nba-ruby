require_relative "client"
require_relative "response_parser"
require_relative "utils"

require_relative "estimated_metrics_stat"

module NBA
  # Provides methods to retrieve player estimated metrics
  module PlayerEstimatedMetrics
    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Result set name for player estimated metrics
    # @return [String] the result set name
    RESULT_SET_NAME = "PlayerEstimatedMetrics".freeze

    # Retrieves estimated metrics for all players
    #
    # @api public
    # @example
    #   stats = NBA::PlayerEstimatedMetrics.all
    #   stats.each { |s| puts "#{s.player_name}: #{s.e_net_rating} net rating" }
    #
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of estimated metrics stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      path = build_path(season, season_type)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_stat(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, season_type)
      season_str = Utils.format_season(season)
      "playerestimatedmetrics?LeagueID=00&Season=#{season_str}&SeasonType=#{season_type}"
    end
    private_class_method :build_path

    # Builds an estimated metrics stat from API data
    # @api private
    # @return [EstimatedMetricsStat]
    def self.build_stat(data)
      EstimatedMetricsStat.new(**identity_info(data), **rating_info(data), **percentage_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       gp: data["GP"], w: data["W"], l: data["L"],
       w_pct: data["W_PCT"], min: data["MIN"]}
    end
    private_class_method :identity_info

    # Extracts rating information from data
    # @api private
    # @return [Hash]
    def self.rating_info(data)
      {e_off_rating: data["E_OFF_RATING"], e_def_rating: data["E_DEF_RATING"],
       e_net_rating: data["E_NET_RATING"], e_ast_ratio: data["E_AST_RATIO"]}
    end
    private_class_method :rating_info

    # Extracts percentage information from data
    # @api private
    # @return [Hash]
    def self.percentage_info(data)
      {e_oreb_pct: data["E_OREB_PCT"], e_dreb_pct: data["E_DREB_PCT"],
       e_reb_pct: data["E_REB_PCT"], e_tov_pct: data["E_TOV_PCT"],
       e_usg_pct: data["E_USG_PCT"], e_pace: data["E_PACE"]}
    end
    private_class_method :percentage_info
  end
end
