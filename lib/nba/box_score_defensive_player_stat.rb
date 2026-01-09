require "equalizer"
require "shale"

module NBA
  # Represents defensive statistics for a player in a game
  class BoxScoreDefensivePlayerStat < Shale::Mapper
    include Equalizer.new(:game_id, :person_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     stat.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_tricode
    #   Returns the team tricode
    #   @api public
    #   @example
    #     stat.team_tricode #=> "GSW"
    #   @return [String] the team tricode
    attribute :team_tricode, Shale::Type::String

    # @!attribute [rw] team_slug
    #   Returns the team slug
    #   @api public
    #   @example
    #     stat.team_slug #=> "warriors"
    #   @return [String] the team slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] person_id
    #   Returns the person ID
    #   @api public
    #   @example
    #     stat.person_id #=> 201939
    #   @return [Integer] the person ID
    attribute :person_id, Shale::Type::Integer

    # @!attribute [rw] first_name
    #   Returns the player first name
    #   @api public
    #   @example
    #     stat.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] family_name
    #   Returns the player family name
    #   @api public
    #   @example
    #     stat.family_name #=> "Curry"
    #   @return [String] the family name
    attribute :family_name, Shale::Type::String

    # @!attribute [rw] name_i
    #   Returns the player name initial format
    #   @api public
    #   @example
    #     stat.name_i #=> "S. Curry"
    #   @return [String] the name initial format
    attribute :name_i, Shale::Type::String

    # @!attribute [rw] player_slug
    #   Returns the player slug
    #   @api public
    #   @example
    #     stat.player_slug #=> "stephen-curry"
    #   @return [String] the player slug
    attribute :player_slug, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the player position
    #   @api public
    #   @example
    #     stat.position #=> "G"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] comment
    #   Returns any comment about the player
    #   @api public
    #   @example
    #     stat.comment #=> "DNP - Rest"
    #   @return [String] the comment
    attribute :comment, Shale::Type::String

    # @!attribute [rw] jersey_num
    #   Returns the jersey number
    #   @api public
    #   @example
    #     stat.jersey_num #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_num, Shale::Type::String

    # @!attribute [rw] matchup_minutes
    #   Returns the matchup minutes
    #   @api public
    #   @example
    #     stat.matchup_minutes #=> 24.5
    #   @return [Float] the matchup minutes
    attribute :matchup_minutes, Shale::Type::Float

    # @!attribute [rw] partial_possessions
    #   Returns partial possessions
    #   @api public
    #   @example
    #     stat.partial_possessions #=> 15.2
    #   @return [Float] partial possessions
    attribute :partial_possessions, Shale::Type::Float

    # @!attribute [rw] switches_on
    #   Returns number of switches on
    #   @api public
    #   @example
    #     stat.switches_on #=> 8
    #   @return [Integer] switches on
    attribute :switches_on, Shale::Type::Integer

    # @!attribute [rw] player_points
    #   Returns points allowed
    #   @api public
    #   @example
    #     stat.player_points #=> 12
    #   @return [Integer] player points allowed
    attribute :player_points, Shale::Type::Integer

    # @!attribute [rw] defensive_rebounds
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.defensive_rebounds #=> 5
    #   @return [Integer] defensive rebounds
    attribute :defensive_rebounds, Shale::Type::Integer

    # @!attribute [rw] matchup_assists
    #   Returns matchup assists
    #   @api public
    #   @example
    #     stat.matchup_assists #=> 3
    #   @return [Integer] matchup assists
    attribute :matchup_assists, Shale::Type::Integer

    # @!attribute [rw] matchup_turnovers
    #   Returns matchup turnovers
    #   @api public
    #   @example
    #     stat.matchup_turnovers #=> 2
    #   @return [Integer] matchup turnovers
    attribute :matchup_turnovers, Shale::Type::Integer

    # @!attribute [rw] steals
    #   Returns steals
    #   @api public
    #   @example
    #     stat.steals #=> 2
    #   @return [Integer] steals
    attribute :steals, Shale::Type::Integer

    # @!attribute [rw] blocks
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blocks #=> 1
    #   @return [Integer] blocks
    attribute :blocks, Shale::Type::Integer

    # @!attribute [rw] matchup_field_goals_made
    #   Returns matchup field goals made
    #   @api public
    #   @example
    #     stat.matchup_field_goals_made #=> 5
    #   @return [Integer] matchup field goals made
    attribute :matchup_field_goals_made, Shale::Type::Integer

    # @!attribute [rw] matchup_field_goals_attempted
    #   Returns matchup field goals attempted
    #   @api public
    #   @example
    #     stat.matchup_field_goals_attempted #=> 12
    #   @return [Integer] matchup field goals attempted
    attribute :matchup_field_goals_attempted, Shale::Type::Integer

    # @!attribute [rw] matchup_field_goal_percentage
    #   Returns matchup field goal percentage
    #   @api public
    #   @example
    #     stat.matchup_field_goal_percentage #=> 0.417
    #   @return [Float] matchup field goal percentage
    attribute :matchup_field_goal_percentage, Shale::Type::Float

    # @!attribute [rw] matchup_three_pointers_made
    #   Returns matchup three pointers made
    #   @api public
    #   @example
    #     stat.matchup_three_pointers_made #=> 2
    #   @return [Integer] matchup three pointers made
    attribute :matchup_three_pointers_made, Shale::Type::Integer

    # @!attribute [rw] matchup_three_pointers_attempted
    #   Returns matchup three pointers attempted
    #   @api public
    #   @example
    #     stat.matchup_three_pointers_attempted #=> 5
    #   @return [Integer] matchup three pointers attempted
    attribute :matchup_three_pointers_attempted, Shale::Type::Integer

    # @!attribute [rw] matchup_three_pointer_percentage
    #   Returns matchup three pointer percentage
    #   @api public
    #   @example
    #     stat.matchup_three_pointer_percentage #=> 0.4
    #   @return [Float] matchup three pointer percentage
    attribute :matchup_three_pointer_percentage, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(person_id)
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

    # Returns the game object
    #
    # @api public
    # @example
    #   stat.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end

    # Returns whether the player started
    #
    # @api public
    # @example
    #   stat.starter? #=> true
    # @return [Boolean] true if starter
    def starter?
      !position.nil? && !position.empty?
    end
  end
end
