require_relative "../test_helper"

module NBA
  class ShotChartEdgeCasesTest < Minitest::Test
    cover ShotChart

    def test_find_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, ShotChart.find(player: 1, team: 1, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_when_no_result_sets
      stub_request(:get, /shotchartdetail/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_returns_empty_when_result_sets_key_missing
      stub_request(:get, /shotchartdetail/).to_return(body: {}.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_returns_empty_when_no_headers
      response = {resultSets: [{name: "Shot_Chart_Detail", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "Shot_Chart_Detail", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_returns_empty_when_no_rows
      response = {resultSets: [{name: "Shot_Chart_Detail", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "Shot_Chart_Detail", headers: %w[GAME_ID]}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      assert_equal 0, ShotChart.find(player: 1, team: 1).size
    end

    def test_find_finds_correct_result_set_when_not_first
      avg_set = {name: "LeagueAverages", headers: %w[FGA], rowSet: [[100]]}
      shot_set = {name: "Shot_Chart_Detail", headers: %w[GAME_ID GAME_EVENT_ID], rowSet: [["001", 1]]}
      response = {resultSets: [avg_set, shot_set]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      shot = ShotChart.find(player: 1, team: 1).first

      assert_equal "001", shot.game_id
      assert_equal 1, shot.game_event_id
    end

    def test_find_uses_find_not_last_for_result_set
      first_set = {name: "LeagueAverages", headers: %w[FGA], rowSet: [[100]]}
      shot_set = {name: "Shot_Chart_Detail", headers: %w[GAME_ID GAME_EVENT_ID], rowSet: [["001", 1]]}
      last_set = {name: "OtherData", headers: %w[OTHER], rowSet: [["wrong"]]}
      response = {resultSets: [first_set, shot_set, last_set]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      shot = ShotChart.find(player: 1, team: 1).first

      assert_equal "001", shot.game_id
      assert_equal 1, shot.game_event_id
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      shot_set = {name: "Shot_Chart_Detail", headers: %w[GAME_ID], rowSet: [["001"]]}
      response = {resultSets: [unnamed_set, shot_set]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      shot = ShotChart.find(player: 1, team: 1).first

      assert_equal "001", shot.game_id
    end

    def test_find_handles_missing_game_id_header
      response = {resultSets: [{name: "Shot_Chart_Detail", headers: %w[GAME_EVENT_ID], rowSet: [[1]]}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      shot = ShotChart.find(player: 1, team: 1).first

      assert_nil shot.game_id
      assert_equal 1, shot.game_event_id
    end

    def test_find_handles_missing_game_event_id
      response = {resultSets: [{name: "Shot_Chart_Detail", headers: %w[GAME_ID], rowSet: [["001"]]}]}
      stub_request(:get, /shotchartdetail/).to_return(body: response.to_json)

      shot = ShotChart.find(player: 1, team: 1).first

      assert_nil shot.game_event_id
      assert_equal "001", shot.game_id
    end
  end
end
