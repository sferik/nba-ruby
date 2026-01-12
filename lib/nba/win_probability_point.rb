module NBA
  # Represents a win probability data point
  class WinProbabilityPoint < Shale::Mapper
    include Equalizer.new(:game_id, :event_num)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     point.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] event_num
    #   Returns the event number
    #   @api public
    #   @example
    #     point.event_num #=> 1
    #   @return [Integer] the event number
    attribute :event_num, Shale::Type::Integer

    # @!attribute [rw] home_pct
    #   Returns the home team win probability
    #   @api public
    #   @example
    #     point.home_pct #=> 0.52
    #   @return [Float] home win probability (0.0 to 1.0)
    attribute :home_pct, Shale::Type::Float

    # @!attribute [rw] visitor_pct
    #   Returns the visitor team win probability
    #   @api public
    #   @example
    #     point.visitor_pct #=> 0.48
    #   @return [Float] visitor win probability (0.0 to 1.0)
    attribute :visitor_pct, Shale::Type::Float

    # @!attribute [rw] home_pts
    #   Returns the home team points at this event
    #   @api public
    #   @example
    #     point.home_pts #=> 25
    #   @return [Integer] home team points
    attribute :home_pts, Shale::Type::Integer

    # @!attribute [rw] visitor_pts
    #   Returns the visitor team points at this event
    #   @api public
    #   @example
    #     point.visitor_pts #=> 23
    #   @return [Integer] visitor team points
    attribute :visitor_pts, Shale::Type::Integer

    # @!attribute [rw] home_score_by
    #   Returns points scored by home team on this event
    #   @api public
    #   @example
    #     point.home_score_by #=> 2
    #   @return [Integer] points scored
    attribute :home_score_by, Shale::Type::Integer

    # @!attribute [rw] visitor_score_by
    #   Returns points scored by visitor team on this event
    #   @api public
    #   @example
    #     point.visitor_score_by #=> 0
    #   @return [Integer] points scored
    attribute :visitor_score_by, Shale::Type::Integer

    # @!attribute [rw] period
    #   Returns the period
    #   @api public
    #   @example
    #     point.period #=> 1
    #   @return [Integer] the period number
    attribute :period, Shale::Type::Integer

    # @!attribute [rw] seconds_remaining
    #   Returns seconds remaining in the period
    #   @api public
    #   @example
    #     point.seconds_remaining #=> 420
    #   @return [Integer] seconds remaining
    attribute :seconds_remaining, Shale::Type::Integer

    # @!attribute [rw] home_description
    #   Returns the home team play description
    #   @api public
    #   @example
    #     point.home_description #=> "Curry 3PT Shot"
    #   @return [String] the description
    attribute :home_description, Shale::Type::String

    # @!attribute [rw] neutral_description
    #   Returns the neutral play description
    #   @api public
    #   @example
    #     point.neutral_description #=> "Jump Ball"
    #   @return [String] the description
    attribute :neutral_description, Shale::Type::String

    # @!attribute [rw] visitor_description
    #   Returns the visitor team play description
    #   @api public
    #   @example
    #     point.visitor_description #=> "James Layup"
    #   @return [String] the description
    attribute :visitor_description, Shale::Type::String

    # @!attribute [rw] location
    #   Returns the event location
    #   @api public
    #   @example
    #     point.location #=> "H"
    #   @return [String] the location
    attribute :location, Shale::Type::String

    # Returns the description for this event
    #
    # @api public
    # @example
    #   point.description #=> "Curry 3PT Shot"
    # @return [String, nil] the description
    def description
      home_description || neutral_description || visitor_description
    end

    # Returns the score margin (positive = home leading)
    #
    # @api public
    # @example
    #   point.margin #=> 5
    # @return [Integer, nil] the score margin, or nil if either score is missing
    def margin
      return nil unless home_pts && visitor_pts

      home_pts - visitor_pts
    end
  end
end
