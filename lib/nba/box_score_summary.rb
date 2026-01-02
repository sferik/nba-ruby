require "equalizer"
require "shale"

module NBA
  # Represents game summary information
  class BoxScoreSummary < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     summary.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     summary.game_date #=> "2024-10-22"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] game_status_id
    #   Returns the game status ID
    #   @api public
    #   @example
    #     summary.game_status_id #=> 3
    #   @return [Integer] the status ID
    attribute :game_status_id, Shale::Type::Integer

    # @!attribute [rw] game_status_text
    #   Returns the game status text
    #   @api public
    #   @example
    #     summary.game_status_text #=> "Final"
    #   @return [String] the status text
    attribute :game_status_text, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     summary.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] visitor_team_id
    #   Returns the visitor team ID
    #   @api public
    #   @example
    #     summary.visitor_team_id #=> 1610612747
    #   @return [Integer] the visitor team ID
    attribute :visitor_team_id, Shale::Type::Integer

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     summary.season #=> "2024-25"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] live_period
    #   Returns the current period if live
    #   @api public
    #   @example
    #     summary.live_period #=> 4
    #   @return [Integer] the live period
    attribute :live_period, Shale::Type::Integer

    # @!attribute [rw] live_pc_time
    #   Returns the time on the clock if live
    #   @api public
    #   @example
    #     summary.live_pc_time #=> "0:00"
    #   @return [String] the live clock time
    attribute :live_pc_time, Shale::Type::String

    # @!attribute [rw] attendance
    #   Returns the attendance
    #   @api public
    #   @example
    #     summary.attendance #=> 18064
    #   @return [Integer] the attendance
    attribute :attendance, Shale::Type::Integer

    # @!attribute [rw] game_time
    #   Returns the game duration
    #   @api public
    #   @example
    #     summary.game_time #=> "2:18"
    #   @return [String] the game time
    attribute :game_time, Shale::Type::String

    # @!attribute [rw] arena
    #   Returns the arena name
    #   @api public
    #   @example
    #     summary.arena #=> "Chase Center"
    #   @return [String] the arena
    attribute :arena, Shale::Type::String

    # @!attribute [rw] lead_changes
    #   Returns the number of lead changes
    #   @api public
    #   @example
    #     summary.lead_changes #=> 12
    #   @return [Integer] lead changes
    attribute :lead_changes, Shale::Type::Integer

    # @!attribute [rw] times_tied
    #   Returns the number of times tied
    #   @api public
    #   @example
    #     summary.times_tied #=> 8
    #   @return [Integer] times tied
    attribute :times_tied, Shale::Type::Integer

    # @!attribute [rw] officials
    #   Returns the game officials
    #   @api public
    #   @example
    #     summary.officials #=> ["Scott Foster", "Tony Brothers", "Marc Davis"]
    #   @return [Array<String>] the officials
    attribute :officials, Shale::Type::String, collection: true

    # @!attribute [rw] home_pts_q1
    #   Returns home team Q1 points
    #   @api public
    #   @example
    #     summary.home_pts_q1 #=> 28
    #   @return [Integer] Q1 points
    attribute :home_pts_q1, Shale::Type::Integer

    # @!attribute [rw] home_pts_q2
    #   Returns home team Q2 points
    #   @api public
    #   @example
    #     summary.home_pts_q2 #=> 32
    #   @return [Integer] Q2 points
    attribute :home_pts_q2, Shale::Type::Integer

    # @!attribute [rw] home_pts_q3
    #   Returns home team Q3 points
    #   @api public
    #   @example
    #     summary.home_pts_q3 #=> 25
    #   @return [Integer] Q3 points
    attribute :home_pts_q3, Shale::Type::Integer

    # @!attribute [rw] home_pts_q4
    #   Returns home team Q4 points
    #   @api public
    #   @example
    #     summary.home_pts_q4 #=> 33
    #   @return [Integer] Q4 points
    attribute :home_pts_q4, Shale::Type::Integer

    # @!attribute [rw] home_pts_ot
    #   Returns home team OT points
    #   @api public
    #   @example
    #     summary.home_pts_ot #=> 0
    #   @return [Integer] OT points
    attribute :home_pts_ot, Shale::Type::Integer

    # @!attribute [rw] home_pts
    #   Returns home team total points
    #   @api public
    #   @example
    #     summary.home_pts #=> 118
    #   @return [Integer] total points
    attribute :home_pts, Shale::Type::Integer

    # @!attribute [rw] visitor_pts_q1
    #   Returns visitor team Q1 points
    #   @api public
    #   @example
    #     summary.visitor_pts_q1 #=> 25
    #   @return [Integer] Q1 points
    attribute :visitor_pts_q1, Shale::Type::Integer

    # @!attribute [rw] visitor_pts_q2
    #   Returns visitor team Q2 points
    #   @api public
    #   @example
    #     summary.visitor_pts_q2 #=> 28
    #   @return [Integer] Q2 points
    attribute :visitor_pts_q2, Shale::Type::Integer

    # @!attribute [rw] visitor_pts_q3
    #   Returns visitor team Q3 points
    #   @api public
    #   @example
    #     summary.visitor_pts_q3 #=> 30
    #   @return [Integer] Q3 points
    attribute :visitor_pts_q3, Shale::Type::Integer

    # @!attribute [rw] visitor_pts_q4
    #   Returns visitor team Q4 points
    #   @api public
    #   @example
    #     summary.visitor_pts_q4 #=> 26
    #   @return [Integer] Q4 points
    attribute :visitor_pts_q4, Shale::Type::Integer

    # @!attribute [rw] visitor_pts_ot
    #   Returns visitor team OT points
    #   @api public
    #   @example
    #     summary.visitor_pts_ot #=> 0
    #   @return [Integer] OT points
    attribute :visitor_pts_ot, Shale::Type::Integer

    # @!attribute [rw] visitor_pts
    #   Returns visitor team total points
    #   @api public
    #   @example
    #     summary.visitor_pts #=> 109
    #   @return [Integer] total points
    attribute :visitor_pts, Shale::Type::Integer

    # Returns the home team object
    #
    # @api public
    # @example
    #   summary.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the visitor team object
    #
    # @api public
    # @example
    #   summary.visitor_team #=> #<NBA::Team>
    # @return [Team, nil] the visitor team
    def visitor_team
      Teams.find(visitor_team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   summary.game #=> #<NBA::Game>
    # @return [Game, nil] the game
    def game
      Games.find(game_id)
    end

    # Returns whether the game is final
    #
    # @api public
    # @example
    #   summary.final? #=> true
    # @return [Boolean] true if final
    def final?
      game_status_id.eql?(3)
    end

    # Returns whether the game is in progress
    #
    # @api public
    # @example
    #   summary.in_progress? #=> false
    # @return [Boolean] true if in progress
    def in_progress?
      game_status_id.eql?(2)
    end

    # Returns whether the game has not started
    #
    # @api public
    # @example
    #   summary.scheduled? #=> false
    # @return [Boolean] true if scheduled
    def scheduled?
      game_status_id.eql?(1)
    end
  end
end
