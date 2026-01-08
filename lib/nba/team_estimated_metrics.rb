require_relative "client"
require_relative "collection"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Represents team estimated metrics
  #
  # @api public
  class TeamEstimatedMetricsStat < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 36
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.561
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 48.0
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] e_off_rating
    #   Returns estimated offensive rating
    #   @api public
    #   @example
    #     stat.e_off_rating #=> 117.5
    #   @return [Float] estimated offensive rating
    attribute :e_off_rating, Shale::Type::Float

    # @!attribute [rw] e_def_rating
    #   Returns estimated defensive rating
    #   @api public
    #   @example
    #     stat.e_def_rating #=> 110.2
    #   @return [Float] estimated defensive rating
    attribute :e_def_rating, Shale::Type::Float

    # @!attribute [rw] e_net_rating
    #   Returns estimated net rating
    #   @api public
    #   @example
    #     stat.e_net_rating #=> 7.3
    #   @return [Float] estimated net rating
    attribute :e_net_rating, Shale::Type::Float

    # @!attribute [rw] e_pace
    #   Returns estimated pace
    #   @api public
    #   @example
    #     stat.e_pace #=> 101.5
    #   @return [Float] estimated pace
    attribute :e_pace, Shale::Type::Float

    # @!attribute [rw] e_ast_ratio
    #   Returns estimated assist ratio
    #   @api public
    #   @example
    #     stat.e_ast_ratio #=> 18.5
    #   @return [Float] estimated assist ratio
    attribute :e_ast_ratio, Shale::Type::Float

    # @!attribute [rw] e_oreb_pct
    #   Returns estimated offensive rebound percentage
    #   @api public
    #   @example
    #     stat.e_oreb_pct #=> 25.5
    #   @return [Float] estimated offensive rebound percentage
    attribute :e_oreb_pct, Shale::Type::Float

    # @!attribute [rw] e_dreb_pct
    #   Returns estimated defensive rebound percentage
    #   @api public
    #   @example
    #     stat.e_dreb_pct #=> 75.5
    #   @return [Float] estimated defensive rebound percentage
    attribute :e_dreb_pct, Shale::Type::Float

    # @!attribute [rw] e_reb_pct
    #   Returns estimated rebound percentage
    #   @api public
    #   @example
    #     stat.e_reb_pct #=> 50.5
    #   @return [Float] estimated rebound percentage
    attribute :e_reb_pct, Shale::Type::Float

    # @!attribute [rw] e_tm_tov_pct
    #   Returns estimated team turnover percentage
    #   @api public
    #   @example
    #     stat.e_tm_tov_pct #=> 11.5
    #   @return [Float] estimated team turnover percentage
    attribute :e_tm_tov_pct, Shale::Type::Float

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end

  # Provides methods to retrieve team estimated metrics
  #
  # @api public
  module TeamEstimatedMetrics
    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Result set name for team estimated metrics
    # @return [String] the result set name
    RESULT_SET_NAME = "TeamEstimatedMetrics".freeze

    # Retrieves estimated metrics for all teams
    #
    # @api public
    # @example
    #   stats = NBA::TeamEstimatedMetrics.all
    #   stats.each { |s| puts "#{s.team_name}: #{s.e_net_rating} net rating" }
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
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, season_type)
      season_str = Utils.format_season(season)
      "teamestimatedmetrics?LeagueID=00&Season=#{season_str}&SeasonType=#{season_type}"
    end
    private_class_method :build_path

    # Builds an estimated metrics stat from API data
    #
    # @api private
    # @return [TeamEstimatedMetricsStat]
    def self.build_stat(data)
      TeamEstimatedMetricsStat.new(**identity_info(data), **rating_info(data), **percentage_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       gp: data["GP"], w: data["W"], l: data["L"],
       w_pct: data["W_PCT"], min: data["MIN"]}
    end
    private_class_method :identity_info

    # Extracts rating information from data
    #
    # @api private
    # @return [Hash]
    def self.rating_info(data)
      {e_off_rating: data["E_OFF_RATING"], e_def_rating: data["E_DEF_RATING"],
       e_net_rating: data["E_NET_RATING"], e_pace: data["E_PACE"], e_ast_ratio: data["E_AST_RATIO"]}
    end
    private_class_method :rating_info

    # Extracts percentage information from data
    #
    # @api private
    # @return [Hash]
    def self.percentage_info(data)
      {e_oreb_pct: data["E_OREB_PCT"], e_dreb_pct: data["E_DREB_PCT"],
       e_reb_pct: data["E_REB_PCT"], e_tm_tov_pct: data["E_TM_TOV_PCT"]}
    end
    private_class_method :percentage_info
  end
end
