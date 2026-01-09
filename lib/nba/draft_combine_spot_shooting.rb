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
      league_id = extract_league_id(league)
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

    # Builds a DraftCombineSpotShootingResult object from raw data
    # @api private
    # @return [DraftCombineSpotShootingResult] the result object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineSpotShootingResult.new(**result_attributes(data))
    end
    private_class_method :build_result

    # Extracts result attributes from data
    # @api private
    # @return [Hash] the result attributes
    def self.result_attributes(data)
      player_attributes(data).merge(
        fifteen_foot_attributes(data),
        college_range_attributes(data),
        nba_range_attributes(data)
      )
    end
    private_class_method :result_attributes

    # Extracts player attributes from data
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {
        player_id: data.fetch("PLAYER_ID", nil),
        player_name: data.fetch("PLAYER_NAME", nil),
        first_name: data.fetch("FIRST_NAME", nil),
        last_name: data.fetch("LAST_NAME", nil),
        position: data.fetch("POSITION", nil)
      }
    end
    private_class_method :player_attributes

    # Extracts 15-foot range attributes from data
    # @api private
    # @return [Hash] 15-foot range attributes
    def self.fifteen_foot_attributes(data)
      {
        fifteen_corner_left_made: data.fetch("FIFTEEN_CORNER_LEFT_MADE", nil),
        fifteen_corner_left_attempt: data.fetch("FIFTEEN_CORNER_LEFT_ATTEMPT", nil),
        fifteen_corner_left_pct: data.fetch("FIFTEEN_CORNER_LEFT_PCT", nil),
        fifteen_break_left_made: data.fetch("FIFTEEN_BREAK_LEFT_MADE", nil),
        fifteen_break_left_attempt: data.fetch("FIFTEEN_BREAK_LEFT_ATTEMPT", nil),
        fifteen_break_left_pct: data.fetch("FIFTEEN_BREAK_LEFT_PCT", nil),
        fifteen_top_key_made: data.fetch("FIFTEEN_TOP_KEY_MADE", nil),
        fifteen_top_key_attempt: data.fetch("FIFTEEN_TOP_KEY_ATTEMPT", nil),
        fifteen_top_key_pct: data.fetch("FIFTEEN_TOP_KEY_PCT", nil),
        fifteen_break_right_made: data.fetch("FIFTEEN_BREAK_RIGHT_MADE", nil),
        fifteen_break_right_attempt: data.fetch("FIFTEEN_BREAK_RIGHT_ATTEMPT", nil),
        fifteen_break_right_pct: data.fetch("FIFTEEN_BREAK_RIGHT_PCT", nil),
        fifteen_corner_right_made: data.fetch("FIFTEEN_CORNER_RIGHT_MADE", nil),
        fifteen_corner_right_attempt: data.fetch("FIFTEEN_CORNER_RIGHT_ATTEMPT", nil),
        fifteen_corner_right_pct: data.fetch("FIFTEEN_CORNER_RIGHT_PCT", nil)
      }
    end
    private_class_method :fifteen_foot_attributes

    # Extracts college range attributes from data
    # @api private
    # @return [Hash] college range attributes
    def self.college_range_attributes(data)
      {
        college_corner_left_made: data.fetch("COLLEGE_CORNER_LEFT_MADE", nil),
        college_corner_left_attempt: data.fetch("COLLEGE_CORNER_LEFT_ATTEMPT", nil),
        college_corner_left_pct: data.fetch("COLLEGE_CORNER_LEFT_PCT", nil),
        college_break_left_made: data.fetch("COLLEGE_BREAK_LEFT_MADE", nil),
        college_break_left_attempt: data.fetch("COLLEGE_BREAK_LEFT_ATTEMPT", nil),
        college_break_left_pct: data.fetch("COLLEGE_BREAK_LEFT_PCT", nil),
        college_top_key_made: data.fetch("COLLEGE_TOP_KEY_MADE", nil),
        college_top_key_attempt: data.fetch("COLLEGE_TOP_KEY_ATTEMPT", nil),
        college_top_key_pct: data.fetch("COLLEGE_TOP_KEY_PCT", nil),
        college_break_right_made: data.fetch("COLLEGE_BREAK_RIGHT_MADE", nil),
        college_break_right_attempt: data.fetch("COLLEGE_BREAK_RIGHT_ATTEMPT", nil),
        college_break_right_pct: data.fetch("COLLEGE_BREAK_RIGHT_PCT", nil),
        college_corner_right_made: data.fetch("COLLEGE_CORNER_RIGHT_MADE", nil),
        college_corner_right_attempt: data.fetch("COLLEGE_CORNER_RIGHT_ATTEMPT", nil),
        college_corner_right_pct: data.fetch("COLLEGE_CORNER_RIGHT_PCT", nil)
      }
    end
    private_class_method :college_range_attributes

    # Extracts NBA range attributes from data
    # @api private
    # @return [Hash] NBA range attributes
    def self.nba_range_attributes(data)
      {
        nba_corner_left_made: data.fetch("NBA_CORNER_LEFT_MADE", nil),
        nba_corner_left_attempt: data.fetch("NBA_CORNER_LEFT_ATTEMPT", nil),
        nba_corner_left_pct: data.fetch("NBA_CORNER_LEFT_PCT", nil),
        nba_break_left_made: data.fetch("NBA_BREAK_LEFT_MADE", nil),
        nba_break_left_attempt: data.fetch("NBA_BREAK_LEFT_ATTEMPT", nil),
        nba_break_left_pct: data.fetch("NBA_BREAK_LEFT_PCT", nil),
        nba_top_key_made: data.fetch("NBA_TOP_KEY_MADE", nil),
        nba_top_key_attempt: data.fetch("NBA_TOP_KEY_ATTEMPT", nil),
        nba_top_key_pct: data.fetch("NBA_TOP_KEY_PCT", nil),
        nba_break_right_made: data.fetch("NBA_BREAK_RIGHT_MADE", nil),
        nba_break_right_attempt: data.fetch("NBA_BREAK_RIGHT_ATTEMPT", nil),
        nba_break_right_pct: data.fetch("NBA_BREAK_RIGHT_PCT", nil),
        nba_corner_right_made: data.fetch("NBA_CORNER_RIGHT_MADE", nil),
        nba_corner_right_attempt: data.fetch("NBA_CORNER_RIGHT_ATTEMPT", nil),
        nba_corner_right_pct: data.fetch("NBA_CORNER_RIGHT_PCT", nil)
      }
    end
    private_class_method :nba_range_attributes

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
