require "json"
require_relative "client"
require_relative "collection"
require_relative "draft_combine_spot_shooting_result"

module NBA
  # Provides methods to retrieve draft combine spot shooting data
  module DraftCombineSpotShooting
    # Result set name
    # @return [String] the result set name
    RESULTS = "Results".freeze

    # Retrieves draft combine spot shooting results for a season
    #
    # @api public
    # @example
    #   results = NBA::DraftCombineSpotShooting.all(season: 2019)
    #   results.each { |r| puts "#{r.player_name}: #{r.nba_corner_left_pct}" }
    # @param season [Integer] the draft combine season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft combine spot shooting results
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
      "draftcombinespotshooting?LeagueID=#{league_id}&SeasonYear=#{season}"
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

    # Builds a DraftCombineSpotShootingResult object from raw data
    # @api private
    # @return [DraftCombineSpotShootingResult] the result object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineSpotShootingResult.new(**ResultAttributes.extract(data))
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
        player(data).merge(fifteen_foot(data)).merge(college_range(data)).merge(nba_range(data))
      end

      # Extracts player attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] player attributes
      def self.player(data)
        {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
         first_name: data["FIRST_NAME"], last_name: data["LAST_NAME"],
         position: data["POSITION"]}
      end

      # Extracts fifteen-foot range shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] fifteen-foot range shot attributes
      def self.fifteen_foot(data)
        FifteenFoot.corners(data).merge(FifteenFoot.breaks(data)).merge(FifteenFoot.top(data))
      end

      # Extracts college range shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] college range shot attributes
      def self.college_range(data)
        CollegeRange.corners(data).merge(CollegeRange.breaks(data)).merge(CollegeRange.top(data))
      end

      # Extracts NBA range shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] NBA range shot attributes
      def self.nba_range(data)
        NbaRange.corners(data).merge(NbaRange.breaks(data)).merge(NbaRange.top(data))
      end
    end

    # Extracts fifteen-foot range shot attributes
    # @api private
    module FifteenFoot
      # Extracts corner shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] corner shot attributes
      def self.corners(data)
        {fifteen_corner_left_made: data["FIFTEEN_CORNER_LEFT_MADE"],
         fifteen_corner_left_attempt: data["FIFTEEN_CORNER_LEFT_ATTEMPT"],
         fifteen_corner_left_pct: data["FIFTEEN_CORNER_LEFT_PCT"],
         fifteen_corner_right_made: data["FIFTEEN_CORNER_RIGHT_MADE"],
         fifteen_corner_right_attempt: data["FIFTEEN_CORNER_RIGHT_ATTEMPT"],
         fifteen_corner_right_pct: data["FIFTEEN_CORNER_RIGHT_PCT"]}
      end

      # Extracts break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] break shot attributes
      def self.breaks(data)
        {fifteen_break_left_made: data["FIFTEEN_BREAK_LEFT_MADE"],
         fifteen_break_left_attempt: data["FIFTEEN_BREAK_LEFT_ATTEMPT"],
         fifteen_break_left_pct: data["FIFTEEN_BREAK_LEFT_PCT"],
         fifteen_break_right_made: data["FIFTEEN_BREAK_RIGHT_MADE"],
         fifteen_break_right_attempt: data["FIFTEEN_BREAK_RIGHT_ATTEMPT"],
         fifteen_break_right_pct: data["FIFTEEN_BREAK_RIGHT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {fifteen_top_key_made: data["FIFTEEN_TOP_KEY_MADE"],
         fifteen_top_key_attempt: data["FIFTEEN_TOP_KEY_ATTEMPT"],
         fifteen_top_key_pct: data["FIFTEEN_TOP_KEY_PCT"]}
      end
    end

    # Extracts college range shot attributes
    # @api private
    module CollegeRange
      # Extracts corner shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] corner shot attributes
      def self.corners(data)
        {college_corner_left_made: data["COLLEGE_CORNER_LEFT_MADE"],
         college_corner_left_attempt: data["COLLEGE_CORNER_LEFT_ATTEMPT"],
         college_corner_left_pct: data["COLLEGE_CORNER_LEFT_PCT"],
         college_corner_right_made: data["COLLEGE_CORNER_RIGHT_MADE"],
         college_corner_right_attempt: data["COLLEGE_CORNER_RIGHT_ATTEMPT"],
         college_corner_right_pct: data["COLLEGE_CORNER_RIGHT_PCT"]}
      end

      # Extracts break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] break shot attributes
      def self.breaks(data)
        {college_break_left_made: data["COLLEGE_BREAK_LEFT_MADE"],
         college_break_left_attempt: data["COLLEGE_BREAK_LEFT_ATTEMPT"],
         college_break_left_pct: data["COLLEGE_BREAK_LEFT_PCT"],
         college_break_right_made: data["COLLEGE_BREAK_RIGHT_MADE"],
         college_break_right_attempt: data["COLLEGE_BREAK_RIGHT_ATTEMPT"],
         college_break_right_pct: data["COLLEGE_BREAK_RIGHT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {college_top_key_made: data["COLLEGE_TOP_KEY_MADE"],
         college_top_key_attempt: data["COLLEGE_TOP_KEY_ATTEMPT"],
         college_top_key_pct: data["COLLEGE_TOP_KEY_PCT"]}
      end
    end

    # Extracts NBA range shot attributes
    # @api private
    module NbaRange
      # Extracts corner shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] corner shot attributes
      def self.corners(data)
        {nba_corner_left_made: data["NBA_CORNER_LEFT_MADE"],
         nba_corner_left_attempt: data["NBA_CORNER_LEFT_ATTEMPT"],
         nba_corner_left_pct: data["NBA_CORNER_LEFT_PCT"],
         nba_corner_right_made: data["NBA_CORNER_RIGHT_MADE"],
         nba_corner_right_attempt: data["NBA_CORNER_RIGHT_ATTEMPT"],
         nba_corner_right_pct: data["NBA_CORNER_RIGHT_PCT"]}
      end

      # Extracts break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] break shot attributes
      def self.breaks(data)
        {nba_break_left_made: data["NBA_BREAK_LEFT_MADE"],
         nba_break_left_attempt: data["NBA_BREAK_LEFT_ATTEMPT"],
         nba_break_left_pct: data["NBA_BREAK_LEFT_PCT"],
         nba_break_right_made: data["NBA_BREAK_RIGHT_MADE"],
         nba_break_right_attempt: data["NBA_BREAK_RIGHT_ATTEMPT"],
         nba_break_right_pct: data["NBA_BREAK_RIGHT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {nba_top_key_made: data["NBA_TOP_KEY_MADE"],
         nba_top_key_attempt: data["NBA_TOP_KEY_ATTEMPT"],
         nba_top_key_pct: data["NBA_TOP_KEY_PCT"]}
      end
    end
  end
end
