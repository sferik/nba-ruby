module NBA
  # Represents synergy play type statistics
  class PlayTypeStat < Shale::Mapper
    include Equalizer.new(:player_id, :play_type, :type_grouping)

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

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] play_type
    #   Returns the play type
    #   @api public
    #   @example
    #     stat.play_type #=> "Isolation"
    #   @return [String] the play type
    attribute :play_type, Shale::Type::String

    # @!attribute [rw] type_grouping
    #   Returns the type grouping (Offensive or Defensive)
    #   @api public
    #   @example
    #     stat.type_grouping #=> "offensive"
    #   @return [String] the type grouping
    attribute :type_grouping, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] poss
    #   Returns possessions
    #   @api public
    #   @example
    #     stat.poss #=> 150
    #   @return [Integer] possessions
    attribute :poss, Shale::Type::Integer

    # @!attribute [rw] poss_pct
    #   Returns possession percentage
    #   @api public
    #   @example
    #     stat.poss_pct #=> 0.15
    #   @return [Float] possession percentage
    attribute :poss_pct, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 180
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] pts_pct
    #   Returns points percentage
    #   @api public
    #   @example
    #     stat.pts_pct #=> 0.20
    #   @return [Float] points percentage
    attribute :pts_pct, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 60
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 130
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.462
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] efg_pct
    #   Returns effective field goal percentage
    #   @api public
    #   @example
    #     stat.efg_pct #=> 0.538
    #   @return [Float] effective field goal percentage
    attribute :efg_pct, Shale::Type::Float

    # @!attribute [rw] ft_poss_pct
    #   Returns free throw possession percentage
    #   @api public
    #   @example
    #     stat.ft_poss_pct #=> 0.12
    #   @return [Float] free throw possession percentage
    attribute :ft_poss_pct, Shale::Type::Float

    # @!attribute [rw] tov_poss_pct
    #   Returns turnover possession percentage
    #   @api public
    #   @example
    #     stat.tov_poss_pct #=> 0.08
    #   @return [Float] turnover possession percentage
    attribute :tov_poss_pct, Shale::Type::Float

    # @!attribute [rw] sf_poss_pct
    #   Returns shooting foul possession percentage
    #   @api public
    #   @example
    #     stat.sf_poss_pct #=> 0.10
    #   @return [Float] shooting foul possession percentage
    attribute :sf_poss_pct, Shale::Type::Float

    # @!attribute [rw] ppp
    #   Returns points per possession
    #   @api public
    #   @example
    #     stat.ppp #=> 1.2
    #   @return [Float] points per possession
    attribute :ppp, Shale::Type::Float

    # @!attribute [rw] percentile
    #   Returns the percentile ranking
    #   @api public
    #   @example
    #     stat.percentile #=> 0.85
    #   @return [Float] percentile
    attribute :percentile, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns whether this is offensive play type
    #
    # @api public
    # @example
    #   stat.offensive? #=> true
    # @return [Boolean] true if offensive
    def offensive?
      type_grouping.eql?("offensive")
    end

    # Returns whether this is defensive play type
    #
    # @api public
    # @example
    #   stat.defensive? #=> true
    # @return [Boolean] true if defensive
    def defensive?
      type_grouping.eql?("defensive")
    end
  end
end
