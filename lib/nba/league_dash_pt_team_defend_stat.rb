require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents league-wide team defensive statistics
  #
  # @api public
  class LeagueDashPtTeamDefendStat < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String, nil] the team's name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team's abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] g
    #   Returns games (alias for games played)
    #   @api public
    #   @example
    #     stat.g #=> 82
    #   @return [Integer, nil] games
    attribute :g, Shale::Type::Integer

    # @!attribute [rw] freq
    #   Returns frequency percentage
    #   @api public
    #   @example
    #     stat.freq #=> 0.089
    #   @return [Float, nil] frequency percentage
    attribute :freq, Shale::Type::Float

    # @!attribute [rw] d_fgm
    #   Returns defended field goals made
    #   @api public
    #   @example
    #     stat.d_fgm #=> 245.0
    #   @return [Float, nil] defended field goals made
    attribute :d_fgm, Shale::Type::Float

    # @!attribute [rw] d_fga
    #   Returns defended field goals attempted
    #   @api public
    #   @example
    #     stat.d_fga #=> 612.0
    #   @return [Float, nil] defended field goals attempted
    attribute :d_fga, Shale::Type::Float

    # @!attribute [rw] d_fg_pct
    #   Returns defended field goal percentage
    #   @api public
    #   @example
    #     stat.d_fg_pct #=> 0.400
    #   @return [Float, nil] defended field goal percentage
    attribute :d_fg_pct, Shale::Type::Float

    # @!attribute [rw] normal_fg_pct
    #   Returns normal (uncontested) field goal percentage
    #   @api public
    #   @example
    #     stat.normal_fg_pct #=> 0.450
    #   @return [Float, nil] normal field goal percentage
    attribute :normal_fg_pct, Shale::Type::Float

    # @!attribute [rw] pct_plusminus
    #   Returns percentage plus/minus (difference from normal)
    #   @api public
    #   @example
    #     stat.pct_plusminus #=> -0.050
    #   @return [Float, nil] percentage plus/minus
    attribute :pct_plusminus, Shale::Type::Float

    # Returns the team
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team id=1610612744 ...>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
