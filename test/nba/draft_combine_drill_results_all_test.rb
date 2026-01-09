require_relative "../test_helper"

module NBA
  class DraftCombineDrillResultsAllTest < Minitest::Test
    cover DraftCombineDrillResults

    HEADERS = %w[
      TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION
      STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
      MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS
    ].freeze

    ROW = [
      1_630_162, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C",
      30.5, 37.0, 10.5, 10.2, 3.2, 12
    ].freeze

    def test_all_returns_collection
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      result = DraftCombineDrillResults.all(season: 2019)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      DraftCombineDrillResults.all(season: 2019)

      assert_requested :get, /SeasonYear=2019/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      DraftCombineDrillResults.all(season: 2019, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      DraftCombineDrillResults.all(season: 2019)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_results_successfully
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      results = DraftCombineDrillResults.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftCombineDrillResults.all(season: 2019, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftCombineDrillResults.all(season: 2019, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "Results", headers: HEADERS, rowSet: [ROW]}]}
    end
  end

  class DraftCombineDrillResultsPlayerAttrTest < Minitest::Test
    cover DraftCombineDrillResults

    def test_parses_temp_player_id
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombineDrillResults.all(season: 2019).first.temp_player_id
    end

    def test_parses_player_id
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombineDrillResults.all(season: 2019).first.player_id
    end

    def test_parses_first_name
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal "Victor", DraftCombineDrillResults.all(season: 2019).first.first_name
    end

    def test_parses_last_name
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal "Wembanyama", DraftCombineDrillResults.all(season: 2019).first.last_name
    end

    def test_parses_player_name
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftCombineDrillResults.all(season: 2019).first.player_name
    end

    def test_parses_position
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal "C", DraftCombineDrillResults.all(season: 2019).first.position
    end

    private

    def response
      headers = %w[TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION]
      row = [1_630_162, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftCombineDrillResultsDrillAttrTest < Minitest::Test
    cover DraftCombineDrillResults

    def test_parses_standing_vertical_leap
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(30.5, DraftCombineDrillResults.all(season: 2019).first.standing_vertical_leap)
    end

    def test_parses_max_vertical_leap
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(37.0, DraftCombineDrillResults.all(season: 2019).first.max_vertical_leap)
    end

    def test_parses_lane_agility_time
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(10.5, DraftCombineDrillResults.all(season: 2019).first.lane_agility_time)
    end

    def test_parses_modified_lane_agility_time
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(10.2, DraftCombineDrillResults.all(season: 2019).first.modified_lane_agility_time)
    end

    def test_parses_three_quarter_sprint
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_in_delta(3.2, DraftCombineDrillResults.all(season: 2019).first.three_quarter_sprint)
    end

    def test_parses_bench_press
      stub_request(:get, /draftcombinedrillresults/).to_return(body: response.to_json)

      assert_equal 12, DraftCombineDrillResults.all(season: 2019).first.bench_press
    end

    private

    def response
      headers = %w[STANDING_VERTICAL_LEAP MAX_VERTICAL_LEAP LANE_AGILITY_TIME
        MODIFIED_LANE_AGILITY_TIME THREE_QUARTER_SPRINT BENCH_PRESS]
      row = [30.5, 37.0, 10.5, 10.2, 3.2, 12]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
