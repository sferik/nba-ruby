module NBA
  # Represents a draft pick
  class DraftPick < Shale::Mapper
    include Equalizer.new(:player_id, :season)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     pick.player_id #=> 1630162
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] season
    #   Returns the draft season/year
    #   @api public
    #   @example
    #     pick.season #=> 2023
    #   @return [Integer] the season
    attribute :season, Shale::Type::Integer

    # @!attribute [rw] round_number
    #   Returns the round number
    #   @api public
    #   @example
    #     pick.round_number #=> 1
    #   @return [Integer] the round number
    attribute :round_number, Shale::Type::Integer

    # @!attribute [rw] round_pick
    #   Returns the pick number within the round
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

    # @!attribute [rw] draft_type
    #   Returns the draft type
    #   @api public
    #   @example
    #     pick.draft_type #=> "Draft"
    #   @return [String] the draft type
    attribute :draft_type, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID that drafted the player
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

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     pick.player_name #=> "Victor Wembanyama"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     pick.position #=> "C"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     pick.height #=> "7-4"
    #   @return [String] the height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight
    #   @api public
    #   @example
    #     pick.weight #=> 210
    #   @return [Integer] the weight
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] college
    #   Returns the player's college
    #   @api public
    #   @example
    #     pick.college #=> "France"
    #   @return [String] the college
    attribute :college, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the player's country
    #   @api public
    #   @example
    #     pick.country #=> "France"
    #   @return [String] the country
    attribute :country, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   pick.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
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
