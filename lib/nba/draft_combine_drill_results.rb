require "json"
require_relative "client"
require_relative "collection"
require_relative "draft_combine_drill_result"

module NBA
  # Provides methods to retrieve draft combine drill results data
  module DraftCombineDrillResults
    # Result set name
    # @return [String] the result set name
    RESULTS = "Results".freeze

    # Retrieves draft combine drill results for a season
    #
    # @api public
    # @example
    #   results = NBA::DraftCombineDrillResults.all(season: 2019)
    #   results.each { |r| puts "#{r.player_name}: #{r.max_vertical_leap}" }
    # @param season [Integer] the draft combine season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft combine drill results
    def self.all(season:, league: League::NBA, client: CLIENT)
      league_id = extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      "draftcombinedrillresults?LeagueID=#{league_id}&SeasonYear=#{season}"
    end
    private_class_method :build_path

    # Parses the API response into result objects
    # @api private
    # @return [Collection] collection of results
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      results = rows.map { |row| build_result(headers, row) }
      Collection.new(results)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a DraftCombineDrillResult object from raw data
    # @api private
    # @return [DraftCombineDrillResult] the result object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineDrillResult.new(**result_attributes(data))
    end
    private_class_method :build_result

    # Extracts result attributes from data
    # @api private
    # @return [Hash] the result attributes
    def self.result_attributes(data)
      {
        temp_player_id: data.fetch("TEMP_PLAYER_ID", nil),
        player_id: data.fetch("PLAYER_ID", nil),
        first_name: data.fetch("FIRST_NAME", nil),
        last_name: data.fetch("LAST_NAME", nil),
        player_name: data.fetch("PLAYER_NAME", nil),
        position: data.fetch("POSITION", nil),
        standing_vertical_leap: data.fetch("STANDING_VERTICAL_LEAP", nil),
        max_vertical_leap: data.fetch("MAX_VERTICAL_LEAP", nil),
        lane_agility_time: data.fetch("LANE_AGILITY_TIME", nil),
        modified_lane_agility_time: data.fetch("MODIFIED_LANE_AGILITY_TIME", nil),
        three_quarter_sprint: data.fetch("THREE_QUARTER_SPRINT", nil),
        bench_press: data.fetch("BENCH_PRESS", nil)
      }
    end
    private_class_method :result_attributes

    # Extracts the league ID from a League object or string
    #
    # @api private
    # @param league [String, League] the league ID or League object
    # @return [String] the league ID string
    def self.extract_league_id(league)
      case league
      when League then league.id
      else league
      end
    end
    private_class_method :extract_league_id
  end
end
