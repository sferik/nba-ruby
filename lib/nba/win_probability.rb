require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "win_probability_point"

module NBA
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

      headers = result_set["headers"]
      rows = result_set["rowSet"]
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
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(WIN_PROB_PBP) }
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
      {game_id: game_id, event_num: data["EVENT_NUM"],
       period: data["PERIOD"], seconds_remaining: data["SECONDS_REMAINING"],
       location: data["LOCATION"]}
    end
    private_class_method :event_attributes

    # Extracts score attributes from data
    #
    # @api private
    # @return [Hash] score attributes
    def self.score_attributes(data)
      {home_pct: data["HOME_PCT"], visitor_pct: data["VISITOR_PCT"],
       home_pts: data["HOME_PTS"], visitor_pts: data["VISITOR_PTS"],
       home_score_by: data["HOME_SCORE_BY"], visitor_score_by: data["VISITOR_SCORE_BY"]}
    end
    private_class_method :score_attributes

    # Extracts description attributes from data
    #
    # @api private
    # @return [Hash] description attributes
    def self.description_attributes(data)
      {home_description: data["HOME_DESCRIPTION"],
       neutral_description: data["NEUTRAL_DESCRIPTION"],
       visitor_description: data["VISITOR_DESCRIPTION"]}
    end
    private_class_method :description_attributes
  end
end
