require_relative "client"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Represents player estimated metrics
  class EstimatedMetricsStat < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
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
    #     stat.l #=> 28
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.622
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 32.7
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

    # @!attribute [rw] e_ast_ratio
    #   Returns estimated assist ratio
    #   @api public
    #   @example
    #     stat.e_ast_ratio #=> 25.5
    #   @return [Float] estimated assist ratio
    attribute :e_ast_ratio, Shale::Type::Float

    # @!attribute [rw] e_oreb_pct
    #   Returns estimated offensive rebound percentage
    #   @api public
    #   @example
    #     stat.e_oreb_pct #=> 2.5
    #   @return [Float] estimated offensive rebound percentage
    attribute :e_oreb_pct, Shale::Type::Float

    # @!attribute [rw] e_dreb_pct
    #   Returns estimated defensive rebound percentage
    #   @api public
    #   @example
    #     stat.e_dreb_pct #=> 15.5
    #   @return [Float] estimated defensive rebound percentage
    attribute :e_dreb_pct, Shale::Type::Float

    # @!attribute [rw] e_reb_pct
    #   Returns estimated rebound percentage
    #   @api public
    #   @example
    #     stat.e_reb_pct #=> 9.5
    #   @return [Float] estimated rebound percentage
    attribute :e_reb_pct, Shale::Type::Float

    # @!attribute [rw] e_tov_pct
    #   Returns estimated turnover percentage
    #   @api public
    #   @example
    #     stat.e_tov_pct #=> 11.5
    #   @return [Float] estimated turnover percentage
    attribute :e_tov_pct, Shale::Type::Float

    # @!attribute [rw] e_usg_pct
    #   Returns estimated usage percentage
    #   @api public
    #   @example
    #     stat.e_usg_pct #=> 31.5
    #   @return [Float] estimated usage percentage
    attribute :e_usg_pct, Shale::Type::Float

    # @!attribute [rw] e_pace
    #   Returns estimated pace
    #   @api public
    #   @example
    #     stat.e_pace #=> 101.5
    #   @return [Float] estimated pace
    attribute :e_pace, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end

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
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       gp: data.fetch("GP", nil), w: data.fetch("W", nil), l: data.fetch("L", nil),
       w_pct: data.fetch("W_PCT", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_info

    # Extracts rating information from data
    # @api private
    # @return [Hash]
    def self.rating_info(data)
      {e_off_rating: data.fetch("E_OFF_RATING", nil), e_def_rating: data.fetch("E_DEF_RATING", nil),
       e_net_rating: data.fetch("E_NET_RATING", nil), e_ast_ratio: data.fetch("E_AST_RATIO", nil)}
    end
    private_class_method :rating_info

    # Extracts percentage information from data
    # @api private
    # @return [Hash]
    def self.percentage_info(data)
      {e_oreb_pct: data.fetch("E_OREB_PCT", nil), e_dreb_pct: data.fetch("E_DREB_PCT", nil),
       e_reb_pct: data.fetch("E_REB_PCT", nil), e_tov_pct: data.fetch("E_TOV_PCT", nil),
       e_usg_pct: data.fetch("E_USG_PCT", nil), e_pace: data.fetch("E_PACE", nil)}
    end
    private_class_method :percentage_info
  end
end
