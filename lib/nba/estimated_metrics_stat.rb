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
end
