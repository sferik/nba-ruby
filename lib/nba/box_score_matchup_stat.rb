require "equalizer"
require "shale"

module NBA
  # Represents a player matchup statistic from the BoxScoreMatchupsV3 endpoint
  class BoxScoreMatchupStat < Shale::Mapper
    include Equalizer.new(:game_id, :person_id_off, :person_id_def)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400350"
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

    # @!attribute [rw] person_id_off
    #   Returns the offensive player ID
    #   @api public
    #   @example
    #     stat.person_id_off #=> 201939
    #   @return [Integer] the offensive player ID
    attribute :person_id_off, Shale::Type::Integer

    # @!attribute [rw] first_name_off
    #   Returns the offensive player first name
    #   @api public
    #   @example
    #     stat.first_name_off #=> "Stephen"
    #   @return [String] the offensive player first name
    attribute :first_name_off, Shale::Type::String

    # @!attribute [rw] family_name_off
    #   Returns the offensive player family name
    #   @api public
    #   @example
    #     stat.family_name_off #=> "Curry"
    #   @return [String] the offensive player family name
    attribute :family_name_off, Shale::Type::String

    # @!attribute [rw] name_i_off
    #   Returns the offensive player name initial format
    #   @api public
    #   @example
    #     stat.name_i_off #=> "S. Curry"
    #   @return [String] the offensive player name initial format
    attribute :name_i_off, Shale::Type::String

    # @!attribute [rw] player_slug_off
    #   Returns the offensive player slug
    #   @api public
    #   @example
    #     stat.player_slug_off #=> "stephen-curry"
    #   @return [String] the offensive player slug
    attribute :player_slug_off, Shale::Type::String

    # @!attribute [rw] jersey_num_off
    #   Returns the offensive player jersey number
    #   @api public
    #   @example
    #     stat.jersey_num_off #=> "30"
    #   @return [String] the offensive player jersey number
    attribute :jersey_num_off, Shale::Type::String

    # @!attribute [rw] person_id_def
    #   Returns the defensive player ID
    #   @api public
    #   @example
    #     stat.person_id_def #=> 203507
    #   @return [Integer] the defensive player ID
    attribute :person_id_def, Shale::Type::Integer

    # @!attribute [rw] first_name_def
    #   Returns the defensive player first name
    #   @api public
    #   @example
    #     stat.first_name_def #=> "Giannis"
    #   @return [String] the defensive player first name
    attribute :first_name_def, Shale::Type::String

    # @!attribute [rw] family_name_def
    #   Returns the defensive player family name
    #   @api public
    #   @example
    #     stat.family_name_def #=> "Antetokounmpo"
    #   @return [String] the defensive player family name
    attribute :family_name_def, Shale::Type::String

    # @!attribute [rw] name_i_def
    #   Returns the defensive player name initial format
    #   @api public
    #   @example
    #     stat.name_i_def #=> "G. Antetokounmpo"
    #   @return [String] the defensive player name initial format
    attribute :name_i_def, Shale::Type::String

    # @!attribute [rw] player_slug_def
    #   Returns the defensive player slug
    #   @api public
    #   @example
    #     stat.player_slug_def #=> "giannis-antetokounmpo"
    #   @return [String] the defensive player slug
    attribute :player_slug_def, Shale::Type::String

    # @!attribute [rw] position_def
    #   Returns the defensive player position
    #   @api public
    #   @example
    #     stat.position_def #=> "F"
    #   @return [String] the defensive player position
    attribute :position_def, Shale::Type::String

    # @!attribute [rw] comment_def
    #   Returns the defensive player comment
    #   @api public
    #   @example
    #     stat.comment_def #=> ""
    #   @return [String] the defensive player comment
    attribute :comment_def, Shale::Type::String

    # @!attribute [rw] jersey_num_def
    #   Returns the defensive player jersey number
    #   @api public
    #   @example
    #     stat.jersey_num_def #=> "34"
    #   @return [String] the defensive player jersey number
    attribute :jersey_num_def, Shale::Type::String

    # @!attribute [rw] matchup_minutes
    #   Returns the matchup minutes in display format
    #   @api public
    #   @example
    #     stat.matchup_minutes #=> "05:30"
    #   @return [String] the matchup minutes
    attribute :matchup_minutes, Shale::Type::String

    # @!attribute [rw] matchup_minutes_sort
    #   Returns the matchup minutes as sortable float
    #   @api public
    #   @example
    #     stat.matchup_minutes_sort #=> 5.5
    #   @return [Float] the matchup minutes sortable
    attribute :matchup_minutes_sort, Shale::Type::Float

    # @!attribute [rw] partial_possessions
    #   Returns the partial possessions
    #   @api public
    #   @example
    #     stat.partial_possessions #=> 12.5
    #   @return [Float] the partial possessions
    attribute :partial_possessions, Shale::Type::Float

    # @!attribute [rw] percentage_defender_total_time
    #   Returns the percentage of defender's total time
    #   @api public
    #   @example
    #     stat.percentage_defender_total_time #=> 0.15
    #   @return [Float] the percentage of defender's total time
    attribute :percentage_defender_total_time, Shale::Type::Float

    # @!attribute [rw] percentage_offensive_total_time
    #   Returns the percentage of offensive player's total time
    #   @api public
    #   @example
    #     stat.percentage_offensive_total_time #=> 0.18
    #   @return [Float] the percentage of offensive player's total time
    attribute :percentage_offensive_total_time, Shale::Type::Float

    # @!attribute [rw] percentage_total_time_both_on
    #   Returns the percentage of time both players were on court
    #   @api public
    #   @example
    #     stat.percentage_total_time_both_on #=> 0.25
    #   @return [Float] the percentage of time both players were on
    attribute :percentage_total_time_both_on, Shale::Type::Float

    # @!attribute [rw] switches_on
    #   Returns the number of switches onto the matchup
    #   @api public
    #   @example
    #     stat.switches_on #=> 3
    #   @return [Integer] the switches on
    attribute :switches_on, Shale::Type::Integer

    # @!attribute [rw] player_points
    #   Returns the points scored by the offensive player
    #   @api public
    #   @example
    #     stat.player_points #=> 8
    #   @return [Integer] the player points
    attribute :player_points, Shale::Type::Integer

    # @!attribute [rw] team_points
    #   Returns the team points while in matchup
    #   @api public
    #   @example
    #     stat.team_points #=> 12
    #   @return [Integer] the team points
    attribute :team_points, Shale::Type::Integer

    # @!attribute [rw] matchup_assists
    #   Returns the assists in the matchup
    #   @api public
    #   @example
    #     stat.matchup_assists #=> 2
    #   @return [Integer] the matchup assists
    attribute :matchup_assists, Shale::Type::Integer

    # @!attribute [rw] matchup_potential_assists
    #   Returns the potential assists in the matchup
    #   @api public
    #   @example
    #     stat.matchup_potential_assists #=> 3
    #   @return [Integer] the matchup potential assists
    attribute :matchup_potential_assists, Shale::Type::Integer

    # @!attribute [rw] matchup_turnovers
    #   Returns the turnovers in the matchup
    #   @api public
    #   @example
    #     stat.matchup_turnovers #=> 1
    #   @return [Integer] the matchup turnovers
    attribute :matchup_turnovers, Shale::Type::Integer

    # @!attribute [rw] matchup_blocks
    #   Returns the blocks in the matchup
    #   @api public
    #   @example
    #     stat.matchup_blocks #=> 0
    #   @return [Integer] the matchup blocks
    attribute :matchup_blocks, Shale::Type::Integer

    # @!attribute [rw] matchup_field_goals_made
    #   Returns the field goals made in the matchup
    #   @api public
    #   @example
    #     stat.matchup_field_goals_made #=> 3
    #   @return [Integer] the matchup field goals made
    attribute :matchup_field_goals_made, Shale::Type::Integer

    # @!attribute [rw] matchup_field_goals_attempted
    #   Returns the field goals attempted in the matchup
    #   @api public
    #   @example
    #     stat.matchup_field_goals_attempted #=> 6
    #   @return [Integer] the matchup field goals attempted
    attribute :matchup_field_goals_attempted, Shale::Type::Integer

    # @!attribute [rw] matchup_field_goals_percentage
    #   Returns the field goal percentage in the matchup
    #   @api public
    #   @example
    #     stat.matchup_field_goals_percentage #=> 0.5
    #   @return [Float] the matchup field goal percentage
    attribute :matchup_field_goals_percentage, Shale::Type::Float

    # @!attribute [rw] matchup_three_pointers_made
    #   Returns the three pointers made in the matchup
    #   @api public
    #   @example
    #     stat.matchup_three_pointers_made #=> 1
    #   @return [Integer] the matchup three pointers made
    attribute :matchup_three_pointers_made, Shale::Type::Integer

    # @!attribute [rw] matchup_three_pointers_attempted
    #   Returns the three pointers attempted in the matchup
    #   @api public
    #   @example
    #     stat.matchup_three_pointers_attempted #=> 3
    #   @return [Integer] the matchup three pointers attempted
    attribute :matchup_three_pointers_attempted, Shale::Type::Integer

    # @!attribute [rw] matchup_three_pointers_percentage
    #   Returns the three point percentage in the matchup
    #   @api public
    #   @example
    #     stat.matchup_three_pointers_percentage #=> 0.333
    #   @return [Float] the matchup three point percentage
    attribute :matchup_three_pointers_percentage, Shale::Type::Float

    # @!attribute [rw] help_blocks
    #   Returns the help blocks in the matchup
    #   @api public
    #   @example
    #     stat.help_blocks #=> 1
    #   @return [Integer] the help blocks
    attribute :help_blocks, Shale::Type::Integer

    # @!attribute [rw] help_field_goals_made
    #   Returns the help field goals made in the matchup
    #   @api public
    #   @example
    #     stat.help_field_goals_made #=> 2
    #   @return [Integer] the help field goals made
    attribute :help_field_goals_made, Shale::Type::Integer

    # @!attribute [rw] help_field_goals_attempted
    #   Returns the help field goals attempted in the matchup
    #   @api public
    #   @example
    #     stat.help_field_goals_attempted #=> 4
    #   @return [Integer] the help field goals attempted
    attribute :help_field_goals_attempted, Shale::Type::Integer

    # @!attribute [rw] help_field_goals_percentage
    #   Returns the help field goal percentage in the matchup
    #   @api public
    #   @example
    #     stat.help_field_goals_percentage #=> 0.5
    #   @return [Float] the help field goal percentage
    attribute :help_field_goals_percentage, Shale::Type::Float

    # @!attribute [rw] matchup_free_throws_made
    #   Returns the free throws made in the matchup
    #   @api public
    #   @example
    #     stat.matchup_free_throws_made #=> 2
    #   @return [Integer] the matchup free throws made
    attribute :matchup_free_throws_made, Shale::Type::Integer

    # @!attribute [rw] matchup_free_throws_attempted
    #   Returns the free throws attempted in the matchup
    #   @api public
    #   @example
    #     stat.matchup_free_throws_attempted #=> 2
    #   @return [Integer] the matchup free throws attempted
    attribute :matchup_free_throws_attempted, Shale::Type::Integer

    # @!attribute [rw] shooting_fouls
    #   Returns the shooting fouls drawn in the matchup
    #   @api public
    #   @example
    #     stat.shooting_fouls #=> 1
    #   @return [Integer] the shooting fouls
    attribute :shooting_fouls, Shale::Type::Integer

    # Returns the offensive player object
    #
    # @api public
    # @example
    #   stat.offensive_player #=> #<NBA::Player>
    # @return [Player, nil] the offensive player object
    def offensive_player
      Players.find(person_id_off)
    end

    # Returns the defensive player object
    #
    # @api public
    # @example
    #   stat.defensive_player #=> #<NBA::Player>
    # @return [Player, nil] the defensive player object
    def defensive_player
      Players.find(person_id_def)
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

    # Returns the game object for this matchup
    #
    # @api public
    # @example
    #   stat.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end
end
