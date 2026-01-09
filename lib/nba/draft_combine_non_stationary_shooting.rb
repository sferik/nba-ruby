require "json"
require_relative "client"
require_relative "collection"
require_relative "draft_combine_non_stationary_shooting_result"

module NBA
  # Provides methods to retrieve draft combine non-stationary shooting data
  module DraftCombineNonStationaryShooting
    # Result set name
    # @return [String] the result set name
    RESULTS = "Results".freeze

    # Retrieves draft combine non-stationary shooting results for a season
    #
    # @api public
    # @example
    #   results = NBA::DraftCombineNonStationaryShooting.all(season: 2019)
    #   results.each { |r| puts "#{r.player_name}: #{r.off_dribble_fifteen_top_key_pct}" }
    # @param season [Integer] the draft combine season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft combine non-stationary shooting results
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
      "draftcombinenonstationaryshooting?LeagueID=#{league_id}&SeasonYear=#{season}"
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

    # Builds a DraftCombineNonStationaryShootingResult object from raw data
    # @api private
    # @return [DraftCombineNonStationaryShootingResult] the result object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineNonStationaryShootingResult.new(**result_attributes(data))
    end
    private_class_method :build_result

    # Extracts result attributes from data
    # @api private
    # @return [Hash] the result attributes
    def self.result_attributes(data)
      player_attributes(data).merge(
        off_dribble_fifteen_attributes(data),
        on_move_fifteen_attributes(data),
        off_dribble_college_attributes(data),
        on_move_college_attributes(data)
      )
    end
    private_class_method :result_attributes

    # Extracts player attributes from data
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {
        temp_player_id: data.fetch("TEMP_PLAYER_ID", nil),
        player_id: data.fetch("PLAYER_ID", nil),
        player_name: data.fetch("PLAYER_NAME", nil),
        first_name: data.fetch("FIRST_NAME", nil),
        last_name: data.fetch("LAST_NAME", nil),
        position: data.fetch("POSITION", nil)
      }
    end
    private_class_method :player_attributes

    # Extracts off-dribble 15-foot attributes from data
    # @api private
    # @return [Hash] off-dribble 15-foot attributes
    def self.off_dribble_fifteen_attributes(data)
      {
        off_dribble_fifteen_break_left_made: data.fetch("OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE", nil),
        off_dribble_fifteen_break_left_attempt: data.fetch("OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT", nil),
        off_dribble_fifteen_break_left_pct: data.fetch("OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT", nil),
        off_dribble_fifteen_top_key_made: data.fetch("OFF_DRIBBLE_FIFTEEN_TOP_KEY_MADE", nil),
        off_dribble_fifteen_top_key_attempt: data.fetch("OFF_DRIBBLE_FIFTEEN_TOP_KEY_ATTEMPT", nil),
        off_dribble_fifteen_top_key_pct: data.fetch("OFF_DRIBBLE_FIFTEEN_TOP_KEY_PCT", nil),
        off_dribble_fifteen_break_right_made: data.fetch("OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_MADE", nil),
        off_dribble_fifteen_break_right_attempt: data.fetch("OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_ATTEMPT", nil),
        off_dribble_fifteen_break_right_pct: data.fetch("OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_PCT", nil)
      }
    end
    private_class_method :off_dribble_fifteen_attributes

    # Extracts on-the-move 15-foot attributes from data
    # @api private
    # @return [Hash] on-the-move 15-foot attributes
    def self.on_move_fifteen_attributes(data)
      {
        on_move_fifteen_break_left_made: data.fetch("ON_MOVE_FIFTEEN_BREAK_LEFT_MADE", nil),
        on_move_fifteen_break_left_attempt: data.fetch("ON_MOVE_FIFTEEN_BREAK_LEFT_ATTEMPT", nil),
        on_move_fifteen_break_left_pct: data.fetch("ON_MOVE_FIFTEEN_BREAK_LEFT_PCT", nil),
        on_move_fifteen_top_key_made: data.fetch("ON_MOVE_FIFTEEN_TOP_KEY_MADE", nil),
        on_move_fifteen_top_key_attempt: data.fetch("ON_MOVE_FIFTEEN_TOP_KEY_ATTEMPT", nil),
        on_move_fifteen_top_key_pct: data.fetch("ON_MOVE_FIFTEEN_TOP_KEY_PCT", nil),
        on_move_fifteen_break_right_made: data.fetch("ON_MOVE_FIFTEEN_BREAK_RIGHT_MADE", nil),
        on_move_fifteen_break_right_attempt: data.fetch("ON_MOVE_FIFTEEN_BREAK_RIGHT_ATTEMPT", nil),
        on_move_fifteen_break_right_pct: data.fetch("ON_MOVE_FIFTEEN_BREAK_RIGHT_PCT", nil)
      }
    end
    private_class_method :on_move_fifteen_attributes

    # Extracts off-dribble college range attributes from data
    # @api private
    # @return [Hash] off-dribble college range attributes
    def self.off_dribble_college_attributes(data)
      {
        off_dribble_college_break_left_made: data.fetch("OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE", nil),
        off_dribble_college_break_left_attempt: data.fetch("OFF_DRIBBLE_COLLEGE_BREAK_LEFT_ATTEMPT", nil),
        off_dribble_college_break_left_pct: data.fetch("OFF_DRIBBLE_COLLEGE_BREAK_LEFT_PCT", nil),
        off_dribble_college_top_key_made: data.fetch("OFF_DRIBBLE_COLLEGE_TOP_KEY_MADE", nil),
        off_dribble_college_top_key_attempt: data.fetch("OFF_DRIBBLE_COLLEGE_TOP_KEY_ATTEMPT", nil),
        off_dribble_college_top_key_pct: data.fetch("OFF_DRIBBLE_COLLEGE_TOP_KEY_PCT", nil),
        off_dribble_college_break_right_made: data.fetch("OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_MADE", nil),
        off_dribble_college_break_right_attempt: data.fetch("OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_ATTEMPT", nil),
        off_dribble_college_break_right_pct: data.fetch("OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_PCT", nil)
      }
    end
    private_class_method :off_dribble_college_attributes

    # Extracts on-the-move college range attributes from data
    # @api private
    # @return [Hash] on-the-move college range attributes
    def self.on_move_college_attributes(data)
      {
        on_move_college_break_left_made: data.fetch("ON_MOVE_COLLEGE_BREAK_LEFT_MADE", nil),
        on_move_college_break_left_attempt: data.fetch("ON_MOVE_COLLEGE_BREAK_LEFT_ATTEMPT", nil),
        on_move_college_break_left_pct: data.fetch("ON_MOVE_COLLEGE_BREAK_LEFT_PCT", nil),
        on_move_college_top_key_made: data.fetch("ON_MOVE_COLLEGE_TOP_KEY_MADE", nil),
        on_move_college_top_key_attempt: data.fetch("ON_MOVE_COLLEGE_TOP_KEY_ATTEMPT", nil),
        on_move_college_top_key_pct: data.fetch("ON_MOVE_COLLEGE_TOP_KEY_PCT", nil),
        on_move_college_break_right_made: data.fetch("ON_MOVE_COLLEGE_BREAK_RIGHT_MADE", nil),
        on_move_college_break_right_attempt: data.fetch("ON_MOVE_COLLEGE_BREAK_RIGHT_ATTEMPT", nil),
        on_move_college_break_right_pct: data.fetch("ON_MOVE_COLLEGE_BREAK_RIGHT_PCT", nil)
      }
    end
    private_class_method :on_move_college_attributes

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
