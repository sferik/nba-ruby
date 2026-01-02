require "equalizer"
require "shale"

module NBA
  # Represents detailed player biographical information
  class PlayerInfo < Shale::Mapper
    include Equalizer.new(:player_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     info.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     info.first_name #=> "Stephen"
    #   @return [String] the player's first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     info.last_name #=> "Curry"
    #   @return [String] the player's last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] display_name
    #   Returns the player's display name
    #   @api public
    #   @example
    #     info.display_name #=> "Stephen Curry"
    #   @return [String] the player's display name
    attribute :display_name, Shale::Type::String

    # @!attribute [rw] birthdate
    #   Returns the player's birthdate
    #   @api public
    #   @example
    #     info.birthdate #=> "1988-03-14"
    #   @return [String] the player's birthdate
    attribute :birthdate, Shale::Type::String

    # @!attribute [rw] school
    #   Returns the player's school
    #   @api public
    #   @example
    #     info.school #=> "Davidson"
    #   @return [String] the player's school
    attribute :school, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     info.country #=> "USA"
    #   @return [String] the player's country
    attribute :country, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     info.height #=> "6-2"
    #   @return [String] the player's height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight in pounds
    #   @api public
    #   @example
    #     info.weight #=> 185
    #   @return [Integer] the player's weight
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] season_exp
    #   Returns the player's years of experience
    #   @api public
    #   @example
    #     info.season_exp #=> 15
    #   @return [Integer] years of experience
    attribute :season_exp, Shale::Type::Integer

    # @!attribute [rw] jersey
    #   Returns the player's jersey number
    #   @api public
    #   @example
    #     info.jersey #=> "30"
    #   @return [String] the jersey number
    attribute :jersey, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     info.position #=> "Guard"
    #   @return [String] the player's position
    attribute :position, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the player's team ID
    #   @api public
    #   @example
    #     info.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_name
    #   Returns the player's team name
    #   @api public
    #   @example
    #     info.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the player's team abbreviation
    #   @api public
    #   @example
    #     info.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_city
    #   Returns the player's team city
    #   @api public
    #   @example
    #     info.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] draft_year
    #   Returns the year the player was drafted
    #   @api public
    #   @example
    #     info.draft_year #=> 2009
    #   @return [Integer] the draft year
    attribute :draft_year, Shale::Type::Integer

    # @!attribute [rw] draft_round
    #   Returns the round the player was drafted
    #   @api public
    #   @example
    #     info.draft_round #=> 1
    #   @return [Integer] the draft round
    attribute :draft_round, Shale::Type::Integer

    # @!attribute [rw] draft_number
    #   Returns the pick number
    #   @api public
    #   @example
    #     info.draft_number #=> 7
    #   @return [Integer] the draft number
    attribute :draft_number, Shale::Type::Integer

    # @!attribute [rw] from_year
    #   Returns the player's first NBA year
    #   @api public
    #   @example
    #     info.from_year #=> 2009
    #   @return [Integer] the first year
    attribute :from_year, Shale::Type::Integer

    # @!attribute [rw] to_year
    #   Returns the player's most recent NBA year
    #   @api public
    #   @example
    #     info.to_year #=> 2024
    #   @return [Integer] the most recent year
    attribute :to_year, Shale::Type::Integer

    # @!attribute [rw] greatest_75_flag
    #   Returns whether the player is in the NBA 75 greatest
    #   @api public
    #   @example
    #     info.greatest_75_flag #=> "Y"
    #   @return [String] Y or N
    attribute :greatest_75_flag, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   info.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   info.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the player's full name
    #
    # @api public
    # @example
    #   info.full_name #=> "Stephen Curry"
    # @return [String] the full name
    def full_name
      display_name || "#{first_name} #{last_name}".strip
    end

    # Returns whether the player is in the NBA 75 greatest
    #
    # @api public
    # @example
    #   info.greatest_75? #=> true
    # @return [Boolean] true if in NBA 75
    def greatest_75?
      greatest_75_flag.eql?("Y")
    end
  end
end
