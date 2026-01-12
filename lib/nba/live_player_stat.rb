module NBA
  # Represents a player's live box score stats
  class LivePlayerStat < Shale::Mapper
    include Equalizer.new(:player_id, :game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :name, Shale::Type::String

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     stat.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] family_name
    #   Returns the player's family name
    #   @api public
    #   @example
    #     stat.family_name #=> "Curry"
    #   @return [String] the family name
    attribute :family_name, Shale::Type::String

    # @!attribute [rw] jersey_num
    #   Returns the jersey number
    #   @api public
    #   @example
    #     stat.jersey_num #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_num, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the position
    #   @api public
    #   @example
    #     stat.position #=> "G"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_tricode
    #   Returns the team tricode
    #   @api public
    #   @example
    #     stat.team_tricode #=> "GSW"
    #   @return [String] the team tricode
    attribute :team_tricode, Shale::Type::String

    # @!attribute [rw] starter
    #   Returns whether the player started
    #   @api public
    #   @example
    #     stat.starter #=> "1"
    #   @return [String] "1" if starter, "0" otherwise
    attribute :starter, Shale::Type::String

    # @!attribute [rw] minutes
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.minutes #=> "PT34M12S"
    #   @return [String] minutes in ISO 8601 duration format
    attribute :minutes, Shale::Type::String

    # @!attribute [rw] points
    #   Returns points scored
    #   @api public
    #   @example
    #     stat.points #=> 28
    #   @return [Integer] points
    attribute :points, Shale::Type::Integer

    # @!attribute [rw] rebounds_total
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.rebounds_total #=> 7
    #   @return [Integer] total rebounds
    attribute :rebounds_total, Shale::Type::Integer

    # @!attribute [rw] rebounds_offensive
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.rebounds_offensive #=> 1
    #   @return [Integer] offensive rebounds
    attribute :rebounds_offensive, Shale::Type::Integer

    # @!attribute [rw] rebounds_defensive
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.rebounds_defensive #=> 6
    #   @return [Integer] defensive rebounds
    attribute :rebounds_defensive, Shale::Type::Integer

    # @!attribute [rw] assists
    #   Returns assists
    #   @api public
    #   @example
    #     stat.assists #=> 8
    #   @return [Integer] assists
    attribute :assists, Shale::Type::Integer

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

    # @!attribute [rw] turnovers
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.turnovers #=> 3
    #   @return [Integer] turnovers
    attribute :turnovers, Shale::Type::Integer

    # @!attribute [rw] fouls_personal
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.fouls_personal #=> 2
    #   @return [Integer] personal fouls
    attribute :fouls_personal, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 12.0
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # @!attribute [rw] field_goals_made
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.field_goals_made #=> 10
    #   @return [Integer] field goals made
    attribute :field_goals_made, Shale::Type::Integer

    # @!attribute [rw] field_goals_attempted
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.field_goals_attempted #=> 20
    #   @return [Integer] field goals attempted
    attribute :field_goals_attempted, Shale::Type::Integer

    # @!attribute [rw] field_goals_percentage
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.field_goals_percentage #=> 0.5
    #   @return [Float] field goal percentage
    attribute :field_goals_percentage, Shale::Type::Float

    # @!attribute [rw] three_pointers_made
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     stat.three_pointers_made #=> 5
    #   @return [Integer] three-pointers made
    attribute :three_pointers_made, Shale::Type::Integer

    # @!attribute [rw] three_pointers_attempted
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     stat.three_pointers_attempted #=> 12
    #   @return [Integer] three-pointers attempted
    attribute :three_pointers_attempted, Shale::Type::Integer

    # @!attribute [rw] three_pointers_percentage
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.three_pointers_percentage #=> 0.417
    #   @return [Float] three-point percentage
    attribute :three_pointers_percentage, Shale::Type::Float

    # @!attribute [rw] free_throws_made
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.free_throws_made #=> 3
    #   @return [Integer] free throws made
    attribute :free_throws_made, Shale::Type::Integer

    # @!attribute [rw] free_throws_attempted
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.free_throws_attempted #=> 3
    #   @return [Integer] free throws attempted
    attribute :free_throws_attempted, Shale::Type::Integer

    # @!attribute [rw] free_throws_percentage
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.free_throws_percentage #=> 1.0
    #   @return [Float] free throw percentage
    attribute :free_throws_percentage, Shale::Type::Float

    # Returns whether the player was a starter
    #
    # @api public
    # @example
    #   stat.starter? #=> true
    # @return [Boolean] true if starter
    def starter?
      starter.eql?("1")
    end

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
  end
end
