require_relative "../test_helper"

module NBA
  class DraftCombineSpotShootingAllTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_all_returns_collection
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      result = DraftCombineSpotShooting.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      DraftCombineSpotShooting.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      DraftCombineSpotShooting.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      DraftCombineSpotShooting.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_results_successfully
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      results = DraftCombineSpotShooting.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_all_parses_player_attributes
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      result = DraftCombineSpotShooting.all(season: 2019).first

      assert_equal 1_630_162, result.player_id
      assert_equal "Victor Wembanyama", result.player_name
      assert_equal "Victor", result.first_name
      assert_equal "Wembanyama", result.last_name
      assert_equal "C", result.position
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombineSpotShooting.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombineSpotShooting.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      headers = %w[PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION]
      row = [1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C"]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineSpotShootingFifteenAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_parses_fifteen_corner_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_made
    end

    def test_parses_fifteen_corner_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_attempt
    end

    def test_parses_fifteen_corner_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.6, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_pct)
    end

    def test_parses_fifteen_break_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_made
    end

    def test_parses_fifteen_break_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_attempt
    end

    def test_parses_fifteen_break_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.67, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_pct)
    end

    def test_parses_fifteen_top_key_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_made
    end

    def test_parses_fifteen_top_key_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_attempt
    end

    def test_parses_fifteen_top_key_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.29, DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_pct)
    end

    def test_parses_fifteen_break_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_made
    end

    def test_parses_fifteen_break_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 8, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_attempt
    end

    def test_parses_fifteen_break_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.13, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_pct)
    end

    def test_parses_fifteen_corner_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_made
    end

    def test_parses_fifteen_corner_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 9, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_attempt
    end

    def test_parses_fifteen_corner_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.56, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_pct)
    end

    private

    def response
      headers = %w[
        FIFTEEN_CORNER_LEFT_MADE FIFTEEN_CORNER_LEFT_ATTEMPT FIFTEEN_CORNER_LEFT_PCT
        FIFTEEN_BREAK_LEFT_MADE FIFTEEN_BREAK_LEFT_ATTEMPT FIFTEEN_BREAK_LEFT_PCT
        FIFTEEN_TOP_KEY_MADE FIFTEEN_TOP_KEY_ATTEMPT FIFTEEN_TOP_KEY_PCT
        FIFTEEN_BREAK_RIGHT_MADE FIFTEEN_BREAK_RIGHT_ATTEMPT FIFTEEN_BREAK_RIGHT_PCT
        FIFTEEN_CORNER_RIGHT_MADE FIFTEEN_CORNER_RIGHT_ATTEMPT FIFTEEN_CORNER_RIGHT_PCT
      ]
      row = [3, 5, 0.6, 4, 6, 0.67, 2, 7, 0.29, 1, 8, 0.13, 5, 9, 0.56]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineSpotShootingCollegeAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_parses_college_corner_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_made
    end

    def test_parses_college_corner_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_attempt
    end

    def test_parses_college_corner_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.8, DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_pct)
    end

    def test_parses_college_break_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineSpotShooting.all(season: 2019).first.college_break_left_made
    end

    def test_parses_college_break_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineSpotShooting.all(season: 2019).first.college_break_left_attempt
    end

    def test_parses_college_break_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.5, DraftCombineSpotShooting.all(season: 2019).first.college_break_left_pct)
    end

    def test_parses_college_top_key_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineSpotShooting.all(season: 2019).first.college_top_key_made
    end

    def test_parses_college_top_key_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineSpotShooting.all(season: 2019).first.college_top_key_attempt
    end

    def test_parses_college_top_key_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.29, DraftCombineSpotShooting.all(season: 2019).first.college_top_key_pct)
    end

    def test_parses_college_break_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineSpotShooting.all(season: 2019).first.college_break_right_made
    end

    def test_parses_college_break_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 8, DraftCombineSpotShooting.all(season: 2019).first.college_break_right_attempt
    end

    def test_parses_college_break_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.13, DraftCombineSpotShooting.all(season: 2019).first.college_break_right_pct)
    end

    def test_parses_college_corner_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_made
    end

    def test_parses_college_corner_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 9, DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_attempt
    end

    def test_parses_college_corner_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.56, DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_pct)
    end

    private

    def response
      headers = %w[
        COLLEGE_CORNER_LEFT_MADE COLLEGE_CORNER_LEFT_ATTEMPT COLLEGE_CORNER_LEFT_PCT
        COLLEGE_BREAK_LEFT_MADE COLLEGE_BREAK_LEFT_ATTEMPT COLLEGE_BREAK_LEFT_PCT
        COLLEGE_TOP_KEY_MADE COLLEGE_TOP_KEY_ATTEMPT COLLEGE_TOP_KEY_PCT
        COLLEGE_BREAK_RIGHT_MADE COLLEGE_BREAK_RIGHT_ATTEMPT COLLEGE_BREAK_RIGHT_PCT
        COLLEGE_CORNER_RIGHT_MADE COLLEGE_CORNER_RIGHT_ATTEMPT COLLEGE_CORNER_RIGHT_PCT
      ]
      row = [4, 5, 0.8, 3, 6, 0.5, 2, 7, 0.29, 1, 8, 0.13, 5, 9, 0.56]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineSpotShootingNbaAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_parses_nba_corner_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineSpotShooting.all(season: 2019).first.nba_corner_left_made
    end

    def test_parses_nba_corner_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.nba_corner_left_attempt
    end

    def test_parses_nba_corner_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.4, DraftCombineSpotShooting.all(season: 2019).first.nba_corner_left_pct)
    end

    def test_parses_nba_break_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineSpotShooting.all(season: 2019).first.nba_break_left_made
    end

    def test_parses_nba_break_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineSpotShooting.all(season: 2019).first.nba_break_left_attempt
    end

    def test_parses_nba_break_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.5, DraftCombineSpotShooting.all(season: 2019).first.nba_break_left_pct)
    end

    def test_parses_nba_top_key_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineSpotShooting.all(season: 2019).first.nba_top_key_made
    end

    def test_parses_nba_top_key_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineSpotShooting.all(season: 2019).first.nba_top_key_attempt
    end

    def test_parses_nba_top_key_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.57, DraftCombineSpotShooting.all(season: 2019).first.nba_top_key_pct)
    end

    def test_parses_nba_break_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineSpotShooting.all(season: 2019).first.nba_break_right_made
    end

    def test_parses_nba_break_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 8, DraftCombineSpotShooting.all(season: 2019).first.nba_break_right_attempt
    end

    def test_parses_nba_break_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.13, DraftCombineSpotShooting.all(season: 2019).first.nba_break_right_pct)
    end

    def test_parses_nba_corner_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.nba_corner_right_made
    end

    def test_parses_nba_corner_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 9, DraftCombineSpotShooting.all(season: 2019).first.nba_corner_right_attempt
    end

    def test_parses_nba_corner_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.56, DraftCombineSpotShooting.all(season: 2019).first.nba_corner_right_pct)
    end

    private

    def response
      headers = %w[
        NBA_CORNER_LEFT_MADE NBA_CORNER_LEFT_ATTEMPT NBA_CORNER_LEFT_PCT
        NBA_BREAK_LEFT_MADE NBA_BREAK_LEFT_ATTEMPT NBA_BREAK_LEFT_PCT
        NBA_TOP_KEY_MADE NBA_TOP_KEY_ATTEMPT NBA_TOP_KEY_PCT
        NBA_BREAK_RIGHT_MADE NBA_BREAK_RIGHT_ATTEMPT NBA_BREAK_RIGHT_PCT
        NBA_CORNER_RIGHT_MADE NBA_CORNER_RIGHT_ATTEMPT NBA_CORNER_RIGHT_PCT
      ]
      row = [2, 5, 0.4, 3, 6, 0.5, 4, 7, 0.57, 1, 8, 0.13, 5, 9, 0.56]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineSpotShootingMergedAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_merges_all_attribute_groups
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      result = DraftCombineSpotShooting.all(season: 2019).first

      assert_equal "Victor Wembanyama", result.player_name
      assert_equal 3, result.fifteen_corner_left_made
      assert_equal 4, result.college_corner_left_made
      assert_equal 2, result.nba_corner_left_made
    end

    private

    def response
      headers = %w[PLAYER_NAME FIFTEEN_CORNER_LEFT_MADE COLLEGE_CORNER_LEFT_MADE NBA_CORNER_LEFT_MADE]
      row = ["Victor Wembanyama", 3, 4, 2]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
