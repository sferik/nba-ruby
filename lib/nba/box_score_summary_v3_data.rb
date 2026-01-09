require "equalizer"
require "shale"

module NBA
  # Represents game summary information from V3 API
  class BoxScoreSummaryV3Data < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     summary.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_code
    #   Returns the game code
    #   @api public
    #   @example
    #     summary.game_code #=> "20241022/LALGSW"
    #   @return [String] the game code
    attribute :game_code, Shale::Type::String

    # @!attribute [rw] game_status
    #   Returns the game status ID
    #   @api public
    #   @example
    #     summary.game_status #=> 3
    #   @return [Integer] the status ID
    attribute :game_status, Shale::Type::Integer

    # @!attribute [rw] game_status_text
    #   Returns the game status text
    #   @api public
    #   @example
    #     summary.game_status_text #=> "Final"
    #   @return [String] the status text
    attribute :game_status_text, Shale::Type::String

    # @!attribute [rw] period
    #   Returns the current period
    #   @api public
    #   @example
    #     summary.period #=> 4
    #   @return [Integer] the period
    attribute :period, Shale::Type::Integer

    # @!attribute [rw] game_clock
    #   Returns the game clock time
    #   @api public
    #   @example
    #     summary.game_clock #=> "PT00M00.00S"
    #   @return [String] the game clock
    attribute :game_clock, Shale::Type::String

    # @!attribute [rw] game_time_utc
    #   Returns the game time in UTC
    #   @api public
    #   @example
    #     summary.game_time_utc #=> "2024-10-23T02:00:00Z"
    #   @return [String] the game time UTC
    attribute :game_time_utc, Shale::Type::String

    # @!attribute [rw] game_et
    #   Returns the game time in Eastern Time
    #   @api public
    #   @example
    #     summary.game_et #=> "2024-10-22T22:00:00"
    #   @return [String] the game time ET
    attribute :game_et, Shale::Type::String

    # @!attribute [rw] duration
    #   Returns the game duration in minutes
    #   @api public
    #   @example
    #     summary.duration #=> 138
    #   @return [Integer] the duration
    attribute :duration, Shale::Type::Integer

    # @!attribute [rw] attendance
    #   Returns the attendance
    #   @api public
    #   @example
    #     summary.attendance #=> 18064
    #   @return [Integer] the attendance
    attribute :attendance, Shale::Type::Integer

    # @!attribute [rw] sellout
    #   Returns the sellout status
    #   @api public
    #   @example
    #     summary.sellout #=> "1"
    #   @return [String] the sellout status
    attribute :sellout, Shale::Type::String

    # @!attribute [rw] arena_id
    #   Returns the arena ID
    #   @api public
    #   @example
    #     summary.arena_id #=> 10
    #   @return [Integer] the arena ID
    attribute :arena_id, Shale::Type::Integer

    # @!attribute [rw] arena_name
    #   Returns the arena name
    #   @api public
    #   @example
    #     summary.arena_name #=> "Chase Center"
    #   @return [String] the arena name
    attribute :arena_name, Shale::Type::String

    # @!attribute [rw] arena_city
    #   Returns the arena city
    #   @api public
    #   @example
    #     summary.arena_city #=> "San Francisco"
    #   @return [String] the arena city
    attribute :arena_city, Shale::Type::String

    # @!attribute [rw] arena_state
    #   Returns the arena state
    #   @api public
    #   @example
    #     summary.arena_state #=> "CA"
    #   @return [String] the arena state
    attribute :arena_state, Shale::Type::String

    # @!attribute [rw] arena_country
    #   Returns the arena country
    #   @api public
    #   @example
    #     summary.arena_country #=> "US"
    #   @return [String] the arena country
    attribute :arena_country, Shale::Type::String

    # @!attribute [rw] arena_timezone
    #   Returns the arena timezone
    #   @api public
    #   @example
    #     summary.arena_timezone #=> "America/Los_Angeles"
    #   @return [String] the arena timezone
    attribute :arena_timezone, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     summary.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] home_team_name
    #   Returns the home team name
    #   @api public
    #   @example
    #     summary.home_team_name #=> "Warriors"
    #   @return [String] the home team name
    attribute :home_team_name, Shale::Type::String

    # @!attribute [rw] home_team_city
    #   Returns the home team city
    #   @api public
    #   @example
    #     summary.home_team_city #=> "Golden State"
    #   @return [String] the home team city
    attribute :home_team_city, Shale::Type::String

    # @!attribute [rw] home_team_tricode
    #   Returns the home team tricode
    #   @api public
    #   @example
    #     summary.home_team_tricode #=> "GSW"
    #   @return [String] the home team tricode
    attribute :home_team_tricode, Shale::Type::String

    # @!attribute [rw] home_team_slug
    #   Returns the home team slug
    #   @api public
    #   @example
    #     summary.home_team_slug #=> "warriors"
    #   @return [String] the home team slug
    attribute :home_team_slug, Shale::Type::String

    # @!attribute [rw] home_team_wins
    #   Returns the home team wins
    #   @api public
    #   @example
    #     summary.home_team_wins #=> 1
    #   @return [Integer] the home team wins
    attribute :home_team_wins, Shale::Type::Integer

    # @!attribute [rw] home_team_losses
    #   Returns the home team losses
    #   @api public
    #   @example
    #     summary.home_team_losses #=> 0
    #   @return [Integer] the home team losses
    attribute :home_team_losses, Shale::Type::Integer

    # @!attribute [rw] home_pts
    #   Returns home team total points
    #   @api public
    #   @example
    #     summary.home_pts #=> 118
    #   @return [Integer] total points
    attribute :home_pts, Shale::Type::Integer

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

    # @!attribute [rw] away_team_id
    #   Returns the away team ID
    #   @api public
    #   @example
    #     summary.away_team_id #=> 1610612747
    #   @return [Integer] the away team ID
    attribute :away_team_id, Shale::Type::Integer

    # @!attribute [rw] away_team_name
    #   Returns the away team name
    #   @api public
    #   @example
    #     summary.away_team_name #=> "Lakers"
    #   @return [String] the away team name
    attribute :away_team_name, Shale::Type::String

    # @!attribute [rw] away_team_city
    #   Returns the away team city
    #   @api public
    #   @example
    #     summary.away_team_city #=> "Los Angeles"
    #   @return [String] the away team city
    attribute :away_team_city, Shale::Type::String

    # @!attribute [rw] away_team_tricode
    #   Returns the away team tricode
    #   @api public
    #   @example
    #     summary.away_team_tricode #=> "LAL"
    #   @return [String] the away team tricode
    attribute :away_team_tricode, Shale::Type::String

    # @!attribute [rw] away_team_slug
    #   Returns the away team slug
    #   @api public
    #   @example
    #     summary.away_team_slug #=> "lakers"
    #   @return [String] the away team slug
    attribute :away_team_slug, Shale::Type::String

    # @!attribute [rw] away_team_wins
    #   Returns the away team wins
    #   @api public
    #   @example
    #     summary.away_team_wins #=> 0
    #   @return [Integer] the away team wins
    attribute :away_team_wins, Shale::Type::Integer

    # @!attribute [rw] away_team_losses
    #   Returns the away team losses
    #   @api public
    #   @example
    #     summary.away_team_losses #=> 1
    #   @return [Integer] the away team losses
    attribute :away_team_losses, Shale::Type::Integer

    # @!attribute [rw] away_pts
    #   Returns away team total points
    #   @api public
    #   @example
    #     summary.away_pts #=> 109
    #   @return [Integer] total points
    attribute :away_pts, Shale::Type::Integer

    # @!attribute [rw] away_pts_q1
    #   Returns away team Q1 points
    #   @api public
    #   @example
    #     summary.away_pts_q1 #=> 25
    #   @return [Integer] Q1 points
    attribute :away_pts_q1, Shale::Type::Integer

    # @!attribute [rw] away_pts_q2
    #   Returns away team Q2 points
    #   @api public
    #   @example
    #     summary.away_pts_q2 #=> 28
    #   @return [Integer] Q2 points
    attribute :away_pts_q2, Shale::Type::Integer

    # @!attribute [rw] away_pts_q3
    #   Returns away team Q3 points
    #   @api public
    #   @example
    #     summary.away_pts_q3 #=> 30
    #   @return [Integer] Q3 points
    attribute :away_pts_q3, Shale::Type::Integer

    # @!attribute [rw] away_pts_q4
    #   Returns away team Q4 points
    #   @api public
    #   @example
    #     summary.away_pts_q4 #=> 26
    #   @return [Integer] Q4 points
    attribute :away_pts_q4, Shale::Type::Integer

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

    # @!attribute [rw] largest_lead
    #   Returns the largest lead
    #   @api public
    #   @example
    #     summary.largest_lead #=> 15
    #   @return [Integer] largest lead
    attribute :largest_lead, Shale::Type::Integer

    # @!attribute [rw] officials
    #   Returns the game officials
    #   @api public
    #   @example
    #     summary.officials #=> ["Scott Foster", "Tony Brothers", "Marc Davis"]
    #   @return [Array<String>] the officials
    attribute :officials, Shale::Type::String, collection: true

    # Returns the home team object
    #
    # @api public
    # @example
    #   summary.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the away team object
    #
    # @api public
    # @example
    #   summary.away_team #=> #<NBA::Team>
    # @return [Team, nil] the away team
    def away_team
      Teams.find(away_team_id)
    end

    # Returns whether the game is final
    #
    # @api public
    # @example
    #   summary.final? #=> true
    # @return [Boolean] true if final
    def final?
      game_status.eql?(3)
    end

    # Returns whether the game is in progress
    #
    # @api public
    # @example
    #   summary.in_progress? #=> false
    # @return [Boolean] true if in progress
    def in_progress?
      game_status.eql?(2)
    end

    # Returns whether the game has not started
    #
    # @api public
    # @example
    #   summary.scheduled? #=> false
    # @return [Boolean] true if scheduled
    def scheduled?
      game_status.eql?(1)
    end
  end
end
