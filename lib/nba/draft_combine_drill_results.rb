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
      league_id = Utils.extract_league_id(league)
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

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      results = rows.map { |row| build_result(headers, row) }
      Collection.new(results)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a DraftCombineDrillResult object from raw data
    # @api private
    # @return [DraftCombineDrillResult] the result object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineDrillResult.new(**ResultAttributes.extract(data))
    end
    private_class_method :build_result

    # Extracts result attributes from data
    # @api private
    module ResultAttributes
      # Extracts all result attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] extracted attributes
      def self.extract(data)
        player(data).merge(drills(data))
      end

      # Extracts player attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] player attributes
      def self.player(data)
        {temp_player_id: data["TEMP_PLAYER_ID"], player_id: data["PLAYER_ID"],
         first_name: data["FIRST_NAME"], last_name: data["LAST_NAME"],
         player_name: data["PLAYER_NAME"], position: data["POSITION"]}
      end

      # Extracts drill result attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] drill result attributes
      def self.drills(data)
        {standing_vertical_leap: data["STANDING_VERTICAL_LEAP"],
         max_vertical_leap: data["MAX_VERTICAL_LEAP"],
         lane_agility_time: data["LANE_AGILITY_TIME"],
         modified_lane_agility_time: data["MODIFIED_LANE_AGILITY_TIME"],
         three_quarter_sprint: data["THREE_QUARTER_SPRINT"],
         bench_press: data["BENCH_PRESS"]}
      end
    end
  end
end
