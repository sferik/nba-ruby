require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents an assist tracker entry (pass to score)
  class AssistTrackerEntry < Shale::Mapper
    include Equalizer.new(:player_id, :pass_to)

    # @!attribute [rw] player_id
    #   Returns the passer's player ID
    #   @api public
    #   @example
    #     entry.player_id #=> 201566
    #   @return [Integer] the passer's player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the passer's name
    #   @api public
    #   @example
    #     entry.player_name #=> "Russell Westbrook"
    #   @return [String] the passer's name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     entry.team_id #=> 1610612746
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     entry.team_abbreviation #=> "LAC"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] pass_to
    #   Returns the name of the player receiving the pass
    #   @api public
    #   @example
    #     entry.pass_to #=> "Kawhi Leonard"
    #   @return [String] the receiver's name
    attribute :pass_to, Shale::Type::String

    # @!attribute [rw] pass_to_player_id
    #   Returns the ID of the player receiving the pass
    #   @api public
    #   @example
    #     entry.pass_to_player_id #=> 202695
    #   @return [Integer] the receiver's player ID
    attribute :pass_to_player_id, Shale::Type::Integer

    # @!attribute [rw] frequency
    #   Returns the frequency of this pass combination
    #   @api public
    #   @example
    #     entry.frequency #=> 0.123
    #   @return [Float] the frequency
    attribute :frequency, Shale::Type::Float

    # @!attribute [rw] pass
    #   Returns the number of passes
    #   @api public
    #   @example
    #     entry.pass #=> 45
    #   @return [Integer] the number of passes
    attribute :pass, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns the number of assists
    #   @api public
    #   @example
    #     entry.ast #=> 32
    #   @return [Integer] the number of assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] fg_m
    #   Returns the field goals made
    #   @api public
    #   @example
    #     entry.fg_m #=> 28
    #   @return [Integer] the field goals made
    attribute :fg_m, Shale::Type::Integer

    # @!attribute [rw] fg_a
    #   Returns the field goal attempts
    #   @api public
    #   @example
    #     entry.fg_a #=> 45
    #   @return [Integer] the field goal attempts
    attribute :fg_a, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     entry.fg_pct #=> 0.622
    #   @return [Float] the field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg2m
    #   Returns the 2-point field goals made
    #   @api public
    #   @example
    #     entry.fg2m #=> 20
    #   @return [Integer] the 2-point field goals made
    attribute :fg2m, Shale::Type::Integer

    # @!attribute [rw] fg2a
    #   Returns the 2-point field goal attempts
    #   @api public
    #   @example
    #     entry.fg2a #=> 30
    #   @return [Integer] the 2-point field goal attempts
    attribute :fg2a, Shale::Type::Integer

    # @!attribute [rw] fg2_pct
    #   Returns the 2-point field goal percentage
    #   @api public
    #   @example
    #     entry.fg2_pct #=> 0.667
    #   @return [Float] the 2-point field goal percentage
    attribute :fg2_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the 3-point field goals made
    #   @api public
    #   @example
    #     entry.fg3m #=> 8
    #   @return [Integer] the 3-point field goals made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns the 3-point field goal attempts
    #   @api public
    #   @example
    #     entry.fg3a #=> 15
    #   @return [Integer] the 3-point field goal attempts
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns the 3-point field goal percentage
    #   @api public
    #   @example
    #     entry.fg3_pct #=> 0.533
    #   @return [Float] the 3-point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # Returns the passer player object
    #
    # @api public
    # @example
    #   entry.player #=> #<NBA::Player>
    # @return [Player, nil] the passer player object
    def player
      Players.find(player_id)
    end

    # Returns the receiver player object
    #
    # @api public
    # @example
    #   entry.pass_to_player #=> #<NBA::Player>
    # @return [Player, nil] the receiver player object
    def pass_to_player
      Players.find(pass_to_player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   entry.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    json do
      map "player_id", to: :player_id
      map "player_name", to: :player_name
      map "team_id", to: :team_id
      map "team_abbreviation", to: :team_abbreviation
      map "pass_to", to: :pass_to
      map "pass_to_player_id", to: :pass_to_player_id
      map "frequency", to: :frequency
      map "pass", to: :pass
      map "ast", to: :ast
      map "fg_m", to: :fg_m
      map "fg_a", to: :fg_a
      map "fg_pct", to: :fg_pct
      map "fg2m", to: :fg2m
      map "fg2a", to: :fg2a
      map "fg2_pct", to: :fg2_pct
      map "fg3m", to: :fg3m
      map "fg3a", to: :fg3a
      map "fg3_pct", to: :fg3_pct
    end
  end
end
