require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

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

  # Provides methods to retrieve win probability data
  module WinProbability
    # Result set name for win probability
    # @return [String] the result set name
    WIN_PROB_PBP = "WinProbPBP".freeze

    # Retrieves win probability data for a game
    #
    # @api public
    # @example
    #   points = NBA::WinProbability.find(game: "0022400001")
    #   points.each { |p| puts "Period #{p.period}: Home #{(p.home_pct * 100).round}%" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of win probability points
    def self.find(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      path = "winprobabilitypbp?GameID=#{game_id}&LeagueID=00"
      response = client.get(path)
      parse_response(response, game_id)
    end

    # Parses the API response into win probability point objects
    #
    # @api private
    # @return [Collection] collection of win probability points
    def self.parse_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      points = rows.map { |row| build_win_prob_point(headers, row, game_id) }
      Collection.new(points)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    #
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(WIN_PROB_PBP) }
    end
    private_class_method :find_result_set

    # Builds a WinProbabilityPoint object from raw data
    #
    # @api private
    # @return [WinProbabilityPoint] the win probability point object
    def self.build_win_prob_point(headers, row, game_id)
      data = headers.zip(row).to_h
      WinProbabilityPoint.new(**win_prob_attributes(data, game_id))
    end
    private_class_method :build_win_prob_point

    # Combines all win probability attributes
    #
    # @api private
    # @return [Hash] the combined attributes
    def self.win_prob_attributes(data, game_id)
      event_attributes(data, game_id)
        .merge(score_attributes(data))
        .merge(description_attributes(data))
    end
    private_class_method :win_prob_attributes

    # Extracts event attributes from data
    #
    # @api private
    # @return [Hash] event attributes
    def self.event_attributes(data, game_id)
      {game_id: game_id, event_num: data.fetch("EVENT_NUM", nil),
       period: data.fetch("PERIOD", nil), seconds_remaining: data.fetch("SECONDS_REMAINING", nil),
       location: data.fetch("LOCATION", nil)}
    end
    private_class_method :event_attributes

    # Extracts score attributes from data
    #
    # @api private
    # @return [Hash] score attributes
    def self.score_attributes(data)
      {home_pct: data.fetch("HOME_PCT", nil), visitor_pct: data.fetch("VISITOR_PCT", nil),
       home_pts: data.fetch("HOME_PTS", nil), visitor_pts: data.fetch("VISITOR_PTS", nil),
       home_score_by: data.fetch("HOME_SCORE_BY", nil), visitor_score_by: data.fetch("VISITOR_SCORE_BY", nil)}
    end
    private_class_method :score_attributes

    # Extracts description attributes from data
    #
    # @api private
    # @return [Hash] description attributes
    def self.description_attributes(data)
      {home_description: data.fetch("HOME_DESCRIPTION", nil),
       neutral_description: data.fetch("NEUTRAL_DESCRIPTION", nil),
       visitor_description: data.fetch("VISITOR_DESCRIPTION", nil)}
    end
    private_class_method :description_attributes
  end
end
