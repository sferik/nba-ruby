require "equalizer"
require "shale"

module NBA
  # Represents team tracking rebound statistics
  #
  # @api public
  class TeamReboundStat < Shale::Mapper
    include Equalizer.new(:team_id, :g, :reb)

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

    # @!attribute [rw] sort_order
    #   Returns the sort order for the row
    #   @api public
    #   @example
    #     stat.sort_order #=> 1
    #   @return [Integer, nil] the sort order for the row
    attribute :sort_order, Shale::Type::Integer

    # @!attribute [rw] g
    #   Returns the number of games
    #   @api public
    #   @example
    #     stat.g #=> 74
    #   @return [Integer, nil] the number of games
    attribute :g, Shale::Type::Integer

    # @!attribute [rw] reb_num_contesting_range
    #   Returns the number of contesting players range
    #   @api public
    #   @example
    #     stat.reb_num_contesting_range #=> "0 Contests"
    #   @return [String, nil] the number of contesting players range
    attribute :reb_num_contesting_range, Shale::Type::String

    # @!attribute [rw] overall
    #   Returns the overall category
    #   @api public
    #   @example
    #     stat.overall #=> "Overall"
    #   @return [String, nil] the overall category
    attribute :overall, Shale::Type::String

    # @!attribute [rw] reb_dist_range
    #   Returns the rebound distance range
    #   @api public
    #   @example
    #     stat.reb_dist_range #=> "0-6 Feet"
    #   @return [String, nil] the rebound distance range
    attribute :reb_dist_range, Shale::Type::String

    # @!attribute [rw] shot_dist_range
    #   Returns the shot distance range
    #   @api public
    #   @example
    #     stat.shot_dist_range #=> "0-6 Feet"
    #   @return [String, nil] the shot distance range
    attribute :shot_dist_range, Shale::Type::String

    # @!attribute [rw] shot_type_range
    #   Returns the shot type range
    #   @api public
    #   @example
    #     stat.shot_type_range #=> "2PT FGs"
    #   @return [String, nil] the shot type range
    attribute :shot_type_range, Shale::Type::String

    # @!attribute [rw] reb_frequency
    #   Returns the rebound frequency
    #   @api public
    #   @example
    #     stat.reb_frequency #=> 0.25
    #   @return [Float, nil] the rebound frequency
    attribute :reb_frequency, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 1.2
    #   @return [Float, nil] offensive rebounds per game
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 4.5
    #   @return [Float, nil] defensive rebounds per game
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 5.7
    #   @return [Float, nil] total rebounds per game
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] c_oreb
    #   Returns contested offensive rebounds per game
    #   @api public
    #   @example
    #     stat.c_oreb #=> 0.8
    #   @return [Float, nil] contested offensive rebounds per game
    attribute :c_oreb, Shale::Type::Float

    # @!attribute [rw] c_dreb
    #   Returns contested defensive rebounds per game
    #   @api public
    #   @example
    #     stat.c_dreb #=> 2.1
    #   @return [Float, nil] contested defensive rebounds per game
    attribute :c_dreb, Shale::Type::Float

    # @!attribute [rw] c_reb
    #   Returns contested total rebounds per game
    #   @api public
    #   @example
    #     stat.c_reb #=> 2.9
    #   @return [Float, nil] contested total rebounds per game
    attribute :c_reb, Shale::Type::Float

    # @!attribute [rw] c_reb_pct
    #   Returns contested rebound percentage
    #   @api public
    #   @example
    #     stat.c_reb_pct #=> 0.509
    #   @return [Float, nil] contested rebound percentage
    attribute :c_reb_pct, Shale::Type::Float

    # @!attribute [rw] uc_oreb
    #   Returns uncontested offensive rebounds per game
    #   @api public
    #   @example
    #     stat.uc_oreb #=> 0.4
    #   @return [Float, nil] uncontested offensive rebounds per game
    attribute :uc_oreb, Shale::Type::Float

    # @!attribute [rw] uc_dreb
    #   Returns uncontested defensive rebounds per game
    #   @api public
    #   @example
    #     stat.uc_dreb #=> 2.4
    #   @return [Float, nil] uncontested defensive rebounds per game
    attribute :uc_dreb, Shale::Type::Float

    # @!attribute [rw] uc_reb
    #   Returns uncontested total rebounds per game
    #   @api public
    #   @example
    #     stat.uc_reb #=> 2.8
    #   @return [Float, nil] uncontested total rebounds per game
    attribute :uc_reb, Shale::Type::Float

    # @!attribute [rw] uc_reb_pct
    #   Returns uncontested rebound percentage
    #   @api public
    #   @example
    #     stat.uc_reb_pct #=> 0.491
    #   @return [Float, nil] uncontested rebound percentage
    attribute :uc_reb_pct, Shale::Type::Float

    # Returns the team associated with this stat
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team ...>
    # @return [Team, nil] the Team object
    def team
      Teams.find(team_id)
    end
  end
end
