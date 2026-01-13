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
      league_id = Utils.extract_league_id(league)
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

    # Builds a DraftCombineNonStationaryShootingResult object from raw data
    # @api private
    # @return [DraftCombineNonStationaryShootingResult] the result object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineNonStationaryShootingResult.new(**ResultAttributes.extract(data))
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
        player(data).merge(off_dribble_fifteen(data)).merge(on_move_fifteen(data))
          .merge(off_dribble_college(data)).merge(on_move_college(data))
      end

      # Extracts player attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] player attributes
      def self.player(data)
        {temp_player_id: data["TEMP_PLAYER_ID"], player_id: data["PLAYER_ID"],
         player_name: data["PLAYER_NAME"], first_name: data["FIRST_NAME"],
         last_name: data["LAST_NAME"], position: data["POSITION"]}
      end

      # Extracts off-dribble fifteen-foot shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] off-dribble fifteen-foot shot attributes
      def self.off_dribble_fifteen(data)
        OffDribbleFifteen.left(data).merge(OffDribbleFifteen.top(data)).merge(OffDribbleFifteen.right(data))
      end

      # Extracts on-move fifteen-foot shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] on-move fifteen-foot shot attributes
      def self.on_move_fifteen(data)
        OnMoveFifteen.left(data).merge(OnMoveFifteen.top(data)).merge(OnMoveFifteen.right(data))
      end

      # Extracts off-dribble college range shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] off-dribble college range shot attributes
      def self.off_dribble_college(data)
        OffDribbleCollege.left(data).merge(OffDribbleCollege.top(data)).merge(OffDribbleCollege.right(data))
      end

      # Extracts on-move college range shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] on-move college range shot attributes
      def self.on_move_college(data)
        OnMoveCollege.left(data).merge(OnMoveCollege.top(data)).merge(OnMoveCollege.right(data))
      end
    end

    # Extracts off-dribble fifteen-foot shot attributes
    # @api private
    module OffDribbleFifteen
      # Extracts left break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] left break shot attributes
      def self.left(data)
        {off_dribble_fifteen_break_left_made: data["OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE"],
         off_dribble_fifteen_break_left_attempt: data["OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT"],
         off_dribble_fifteen_break_left_pct: data["OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {off_dribble_fifteen_top_key_made: data["OFF_DRIBBLE_FIFTEEN_TOP_KEY_MADE"],
         off_dribble_fifteen_top_key_attempt: data["OFF_DRIBBLE_FIFTEEN_TOP_KEY_ATTEMPT"],
         off_dribble_fifteen_top_key_pct: data["OFF_DRIBBLE_FIFTEEN_TOP_KEY_PCT"]}
      end

      # Extracts right break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] right break shot attributes
      def self.right(data)
        {off_dribble_fifteen_break_right_made: data["OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_MADE"],
         off_dribble_fifteen_break_right_attempt: data["OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_ATTEMPT"],
         off_dribble_fifteen_break_right_pct: data["OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_PCT"]}
      end
    end

    # Extracts on-move fifteen-foot shot attributes
    # @api private
    module OnMoveFifteen
      # Extracts left break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] left break shot attributes
      def self.left(data)
        {on_move_fifteen_break_left_made: data["ON_MOVE_FIFTEEN_BREAK_LEFT_MADE"],
         on_move_fifteen_break_left_attempt: data["ON_MOVE_FIFTEEN_BREAK_LEFT_ATTEMPT"],
         on_move_fifteen_break_left_pct: data["ON_MOVE_FIFTEEN_BREAK_LEFT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {on_move_fifteen_top_key_made: data["ON_MOVE_FIFTEEN_TOP_KEY_MADE"],
         on_move_fifteen_top_key_attempt: data["ON_MOVE_FIFTEEN_TOP_KEY_ATTEMPT"],
         on_move_fifteen_top_key_pct: data["ON_MOVE_FIFTEEN_TOP_KEY_PCT"]}
      end

      # Extracts right break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] right break shot attributes
      def self.right(data)
        {on_move_fifteen_break_right_made: data["ON_MOVE_FIFTEEN_BREAK_RIGHT_MADE"],
         on_move_fifteen_break_right_attempt: data["ON_MOVE_FIFTEEN_BREAK_RIGHT_ATTEMPT"],
         on_move_fifteen_break_right_pct: data["ON_MOVE_FIFTEEN_BREAK_RIGHT_PCT"]}
      end
    end

    # Extracts off-dribble college range shot attributes
    # @api private
    module OffDribbleCollege
      # Extracts left break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] left break shot attributes
      def self.left(data)
        {off_dribble_college_break_left_made: data["OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE"],
         off_dribble_college_break_left_attempt: data["OFF_DRIBBLE_COLLEGE_BREAK_LEFT_ATTEMPT"],
         off_dribble_college_break_left_pct: data["OFF_DRIBBLE_COLLEGE_BREAK_LEFT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {off_dribble_college_top_key_made: data["OFF_DRIBBLE_COLLEGE_TOP_KEY_MADE"],
         off_dribble_college_top_key_attempt: data["OFF_DRIBBLE_COLLEGE_TOP_KEY_ATTEMPT"],
         off_dribble_college_top_key_pct: data["OFF_DRIBBLE_COLLEGE_TOP_KEY_PCT"]}
      end

      # Extracts right break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] right break shot attributes
      def self.right(data)
        {off_dribble_college_break_right_made: data["OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_MADE"],
         off_dribble_college_break_right_attempt: data["OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_ATTEMPT"],
         off_dribble_college_break_right_pct: data["OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_PCT"]}
      end
    end

    # Extracts on-move college range shot attributes
    # @api private
    module OnMoveCollege
      # Extracts left break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] left break shot attributes
      def self.left(data)
        {on_move_college_break_left_made: data["ON_MOVE_COLLEGE_BREAK_LEFT_MADE"],
         on_move_college_break_left_attempt: data["ON_MOVE_COLLEGE_BREAK_LEFT_ATTEMPT"],
         on_move_college_break_left_pct: data["ON_MOVE_COLLEGE_BREAK_LEFT_PCT"]}
      end

      # Extracts top key shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] top key shot attributes
      def self.top(data)
        {on_move_college_top_key_made: data["ON_MOVE_COLLEGE_TOP_KEY_MADE"],
         on_move_college_top_key_attempt: data["ON_MOVE_COLLEGE_TOP_KEY_ATTEMPT"],
         on_move_college_top_key_pct: data["ON_MOVE_COLLEGE_TOP_KEY_PCT"]}
      end

      # Extracts right break shot attributes from data
      # @api private
      # @param data [Hash] the row data
      # @return [Hash] right break shot attributes
      def self.right(data)
        {on_move_college_break_right_made: data["ON_MOVE_COLLEGE_BREAK_RIGHT_MADE"],
         on_move_college_break_right_attempt: data["ON_MOVE_COLLEGE_BREAK_RIGHT_ATTEMPT"],
         on_move_college_break_right_pct: data["ON_MOVE_COLLEGE_BREAK_RIGHT_PCT"]}
      end
    end
  end
end
