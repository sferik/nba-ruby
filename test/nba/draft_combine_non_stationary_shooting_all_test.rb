require_relative "../test_helper"

module NBA
  class DraftCombineNonStationaryShootingAllTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION
      OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT
      OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT
    ].freeze

    ROW = [1, 1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C", 3, 5, 0.6].freeze

    def test_all_returns_collection
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      result = DraftCombineNonStationaryShooting.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      DraftCombineNonStationaryShooting.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      DraftCombineNonStationaryShooting.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      DraftCombineNonStationaryShooting.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_results_successfully
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      results = DraftCombineNonStationaryShooting.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombineNonStationaryShooting.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombineNonStationaryShooting.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "Results", headers: HEADERS, rowSet: [ROW]}]}
    end
  end

  class DraftCombineNonStationaryShootingPlayerAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_parses_temp_player_id
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineNonStationaryShooting.all(season: 2019).first.temp_player_id
    end

    def test_parses_player_id
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombineNonStationaryShooting.all(season: 2019).first.player_id
    end

    def test_parses_player_name
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftCombineNonStationaryShooting.all(season: 2019).first.player_name
    end

    def test_parses_first_name
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal "Victor", DraftCombineNonStationaryShooting.all(season: 2019).first.first_name
    end

    def test_parses_last_name
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal "Wembanyama", DraftCombineNonStationaryShooting.all(season: 2019).first.last_name
    end

    def test_parses_position
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal "C", DraftCombineNonStationaryShooting.all(season: 2019).first.position
    end

    private

    def response
      headers = %w[TEMP_PLAYER_ID PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION]
      row = [1, 1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C"]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineNonStationaryShootingFifteenAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_parses_off_dribble_fifteen_break_left_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_left_made
    end

    def test_parses_off_dribble_fifteen_break_left_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_left_attempt
    end

    def test_parses_off_dribble_fifteen_break_left_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.6, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_left_pct)
    end

    def test_parses_off_dribble_fifteen_top_key_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_top_key_made
    end

    def test_parses_off_dribble_fifteen_top_key_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_top_key_attempt
    end

    def test_parses_off_dribble_fifteen_top_key_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.67, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_top_key_pct)
    end

    def test_parses_off_dribble_fifteen_break_right_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_right_made
    end

    def test_parses_off_dribble_fifteen_break_right_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_right_attempt
    end

    def test_parses_off_dribble_fifteen_break_right_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.29, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_fifteen_break_right_pct)
    end

    private

    def response
      headers = %w[
        OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_ATTEMPT
        OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_PCT OFF_DRIBBLE_FIFTEEN_TOP_KEY_MADE
        OFF_DRIBBLE_FIFTEEN_TOP_KEY_ATTEMPT OFF_DRIBBLE_FIFTEEN_TOP_KEY_PCT
        OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_MADE OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_ATTEMPT
        OFF_DRIBBLE_FIFTEEN_BREAK_RIGHT_PCT
      ]
      row = [3, 5, 0.6, 4, 6, 0.67, 2, 7, 0.29]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineNonStationaryShootingOnMoveAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_parses_on_move_fifteen_break_left_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_made
    end

    def test_parses_on_move_fifteen_break_left_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_attempt
    end

    def test_parses_on_move_fifteen_break_left_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.4, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_pct)
    end

    def test_parses_on_move_fifteen_top_key_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_made
    end

    def test_parses_on_move_fifteen_top_key_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_attempt
    end

    def test_parses_on_move_fifteen_top_key_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.5, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_pct)
    end

    def test_parses_on_move_fifteen_break_right_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_made
    end

    def test_parses_on_move_fifteen_break_right_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_attempt
    end

    def test_parses_on_move_fifteen_break_right_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.14, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_pct)
    end

    private

    def response
      headers = %w[
        ON_MOVE_FIFTEEN_BREAK_LEFT_MADE ON_MOVE_FIFTEEN_BREAK_LEFT_ATTEMPT
        ON_MOVE_FIFTEEN_BREAK_LEFT_PCT ON_MOVE_FIFTEEN_TOP_KEY_MADE
        ON_MOVE_FIFTEEN_TOP_KEY_ATTEMPT ON_MOVE_FIFTEEN_TOP_KEY_PCT
        ON_MOVE_FIFTEEN_BREAK_RIGHT_MADE ON_MOVE_FIFTEEN_BREAK_RIGHT_ATTEMPT
        ON_MOVE_FIFTEEN_BREAK_RIGHT_PCT
      ]
      row = [2, 5, 0.4, 3, 6, 0.5, 1, 7, 0.14]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineNonStationaryShootingOffDribbleCollegeAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_parses_off_dribble_college_break_left_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_left_made
    end

    def test_parses_off_dribble_college_break_left_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_left_attempt
    end

    def test_parses_off_dribble_college_break_left_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.4, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_left_pct)
    end

    def test_parses_off_dribble_college_top_key_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_top_key_made
    end

    def test_parses_off_dribble_college_top_key_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_top_key_attempt
    end

    def test_parses_off_dribble_college_top_key_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.5, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_top_key_pct)
    end

    def test_parses_off_dribble_college_break_right_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_right_made
    end

    def test_parses_off_dribble_college_break_right_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_right_attempt
    end

    def test_parses_off_dribble_college_break_right_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.57, DraftCombineNonStationaryShooting.all(season: 2019).first.off_dribble_college_break_right_pct)
    end

    private

    def response
      headers = %w[
        OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE OFF_DRIBBLE_COLLEGE_BREAK_LEFT_ATTEMPT
        OFF_DRIBBLE_COLLEGE_BREAK_LEFT_PCT OFF_DRIBBLE_COLLEGE_TOP_KEY_MADE
        OFF_DRIBBLE_COLLEGE_TOP_KEY_ATTEMPT OFF_DRIBBLE_COLLEGE_TOP_KEY_PCT
        OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_MADE OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_ATTEMPT
        OFF_DRIBBLE_COLLEGE_BREAK_RIGHT_PCT
      ]
      row = [2, 5, 0.4, 3, 6, 0.5, 4, 7, 0.57]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineNonStationaryShootingOnMoveCollegeAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_parses_on_move_college_break_left_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_made
    end

    def test_parses_on_move_college_break_left_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_attempt
    end

    def test_parses_on_move_college_break_left_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.2, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_left_pct)
    end

    def test_parses_on_move_college_top_key_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_made
    end

    def test_parses_on_move_college_top_key_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_attempt
    end

    def test_parses_on_move_college_top_key_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.33, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_top_key_pct)
    end

    def test_parses_on_move_college_break_right_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_made
    end

    def test_parses_on_move_college_break_right_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_attempt
    end

    def test_parses_on_move_college_break_right_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.43, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_college_break_right_pct)
    end

    private

    def response
      headers = %w[
        ON_MOVE_COLLEGE_BREAK_LEFT_MADE ON_MOVE_COLLEGE_BREAK_LEFT_ATTEMPT
        ON_MOVE_COLLEGE_BREAK_LEFT_PCT ON_MOVE_COLLEGE_TOP_KEY_MADE
        ON_MOVE_COLLEGE_TOP_KEY_ATTEMPT ON_MOVE_COLLEGE_TOP_KEY_PCT
        ON_MOVE_COLLEGE_BREAK_RIGHT_MADE ON_MOVE_COLLEGE_BREAK_RIGHT_ATTEMPT
        ON_MOVE_COLLEGE_BREAK_RIGHT_PCT
      ]
      row = [1, 5, 0.2, 2, 6, 0.33, 3, 7, 0.43]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineNonStationaryShootingMergedAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_merges_all_attribute_groups
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      result = DraftCombineNonStationaryShooting.all(season: 2019).first

      assert_equal "Victor Wembanyama", result.player_name
      assert_equal 3, result.off_dribble_fifteen_break_left_made
      assert_equal 2, result.on_move_fifteen_break_left_made
      assert_equal 4, result.off_dribble_college_break_left_made
      assert_equal 1, result.on_move_college_break_left_made
    end

    private

    def response
      headers = %w[
        PLAYER_NAME
        OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE
        ON_MOVE_FIFTEEN_BREAK_LEFT_MADE
        OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE
        ON_MOVE_COLLEGE_BREAK_LEFT_MADE
      ]
      row = ["Victor Wembanyama", 3, 2, 4, 1]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
