require "shale"
require "equalizer"

module NBA
  # Represents team on/off player summary statistics
  #
  # @api public
  class TeamOnOffPlayerSummary < Shale::Mapper
    include Equalizer.new(:team_id, :vs_player_id, :court_status)

    # @!attribute [rw] group_set
    #   Returns the group set
    #   @api public
    #   @example
    #     summary.group_set #=> "Overall"
    #   @return [String, nil] the group set
    attribute :group_set, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     summary.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     summary.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     summary.team_name #=> "Warriors"
    #   @return [String, nil] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] vs_player_id
    #   Returns the opponent player ID
    #   @api public
    #   @example
    #     summary.vs_player_id #=> 201939
    #   @return [Integer, nil] the opponent player ID
    attribute :vs_player_id, Shale::Type::Integer

    # @!attribute [rw] vs_player_name
    #   Returns the opponent player name
    #   @api public
    #   @example
    #     summary.vs_player_name #=> "Stephen Curry"
    #   @return [String, nil] the opponent player name
    attribute :vs_player_name, Shale::Type::String

    # @!attribute [rw] court_status
    #   Returns whether player is on or off court
    #   @api public
    #   @example
    #     summary.court_status #=> "On"
    #   @return [String, nil] whether player is on or off court
    attribute :court_status, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     summary.gp #=> 82
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     summary.min #=> 32.5
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus rating
    #   @api public
    #   @example
    #     summary.plus_minus #=> 8.5
    #   @return [Float, nil] plus/minus rating
    attribute :plus_minus, Shale::Type::Float

    # @!attribute [rw] off_rating
    #   Returns offensive rating
    #   @api public
    #   @example
    #     summary.off_rating #=> 115.2
    #   @return [Float, nil] offensive rating
    attribute :off_rating, Shale::Type::Float

    # @!attribute [rw] def_rating
    #   Returns defensive rating
    #   @api public
    #   @example
    #     summary.def_rating #=> 108.7
    #   @return [Float, nil] defensive rating
    attribute :def_rating, Shale::Type::Float

    # @!attribute [rw] net_rating
    #   Returns net rating
    #   @api public
    #   @example
    #     summary.net_rating #=> 6.5
    #   @return [Float, nil] net rating
    attribute :net_rating, Shale::Type::Float
  end
end
