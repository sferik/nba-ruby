require "equalizer"
require "shale"

module NBA
  # Represents a draft board pick
  class DraftBoardPick < Shale::Mapper
    include Equalizer.new(:person_id)

    # @!attribute [rw] person_id
    #   Returns the person ID
    #   @api public
    #   @example
    #     pick.person_id #=> 1630162
    #   @return [Integer] the person ID
    attribute :person_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     pick.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] season
    #   Returns the draft season
    #   @api public
    #   @example
    #     pick.season #=> "2023"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] round_number
    #   Returns the draft round number
    #   @api public
    #   @example
    #     pick.round_number #=> 1
    #   @return [Integer] the round number
    attribute :round_number, Shale::Type::Integer

    # @!attribute [rw] round_pick
    #   Returns the pick number in the round
    #   @api public
    #   @example
    #     pick.round_pick #=> 1
    #   @return [Integer] the round pick
    attribute :round_pick, Shale::Type::Integer

    # @!attribute [rw] overall_pick
    #   Returns the overall pick number
    #   @api public
    #   @example
    #     pick.overall_pick #=> 1
    #   @return [Integer] the overall pick
    attribute :overall_pick, Shale::Type::Integer

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     pick.team_id #=> 1610612759
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     pick.team_city #=> "San Antonio"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     pick.team_name #=> "Spurs"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     pick.team_abbreviation #=> "SAS"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] organization
    #   Returns the organization name
    #   @api public
    #   @example
    #     pick.organization #=> "Metropolitans 92"
    #   @return [String] the organization
    attribute :organization, Shale::Type::String

    # @!attribute [rw] organization_type
    #   Returns the organization type
    #   @api public
    #   @example
    #     pick.organization_type #=> "International"
    #   @return [String] the organization type
    attribute :organization_type, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player height
    #   @api public
    #   @example
    #     pick.height #=> "7-4"
    #   @return [String] the height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player weight
    #   @api public
    #   @example
    #     pick.weight #=> "210"
    #   @return [String] the weight
    attribute :weight, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player position
    #   @api public
    #   @example
    #     pick.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] jersey_number
    #   Returns the jersey number
    #   @api public
    #   @example
    #     pick.jersey_number #=> "1"
    #   @return [String] the jersey number
    attribute :jersey_number, Shale::Type::String

    # @!attribute [rw] birthdate
    #   Returns the birthdate
    #   @api public
    #   @example
    #     pick.birthdate #=> "2004-01-04"
    #   @return [String] the birthdate
    attribute :birthdate, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player age
    #   @api public
    #   @example
    #     pick.age #=> 19.0
    #   @return [Float] the age
    attribute :age, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   pick.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(person_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   pick.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
