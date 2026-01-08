require_relative "../test_helper"

module NBA
  class TeamDashPtShotsEdgeCasesTest < Minitest::Test
    cover TeamDashPtShots

    def test_returns_empty_collection_when_client_returns_nil
      client = Minitest::Mock.new
      client.expect :get, nil, [String]

      result = TeamDashPtShots.general(team: 1_610_612_744, client: client)

      assert_empty result
      client.verify
    end

    def test_returns_empty_collection_when_client_returns_empty_string
      client = Minitest::Mock.new
      client.expect :get, "", [String]

      result = TeamDashPtShots.general(team: 1_610_612_744, client: client)

      assert_empty result
      client.verify
    end

    def test_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /teamdashptshots/).to_return(body: response_without_result_sets.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_result_set_not_found
      stub_request(:get, /teamdashptshots/).to_return(body: wrong_result_set_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_result_set_has_no_name_key
      stub_request(:get, /teamdashptshots/).to_return(body: result_set_no_name_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_headers_nil
      stub_request(:get, /teamdashptshots/).to_return(body: headers_nil_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_rowset_nil
      stub_request(:get, /teamdashptshots/).to_return(body: rowset_nil_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_headers_key_missing
      stub_request(:get, /teamdashptshots/).to_return(body: headers_key_missing_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_rowset_key_missing
      stub_request(:get, /teamdashptshots/).to_return(body: rowset_key_missing_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_empty result
    end

    def test_shot_clock_includes_correct_params
      stub_request(:get, /teamdashptshots/).to_return(body: shot_clock_response.to_json)

      TeamDashPtShots.shot_clock(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    def test_dribble_includes_correct_params
      stub_request(:get, /teamdashptshots/).to_return(body: dribble_response.to_json)

      TeamDashPtShots.dribble(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    private

    def response_without_result_sets
      {parameters: {}}
    end

    def wrong_result_set_response
      {resultSets: [{name: "WrongName", headers: headers, rowSet: [row]}]}
    end

    def result_set_no_name_response
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end

    def headers_nil_response
      {resultSets: [{name: "GeneralShooting", headers: nil, rowSet: [row]}]}
    end

    def rowset_nil_response
      {resultSets: [{name: "GeneralShooting", headers: headers, rowSet: nil}]}
    end

    def headers_key_missing_response
      {resultSets: [{name: "GeneralShooting", rowSet: [row]}]}
    end

    def rowset_key_missing_response
      {resultSets: [{name: "GeneralShooting", headers: headers}]}
    end

    def shot_clock_response
      {resultSets: [{name: "ShotClockShooting", headers: headers, rowSet: [row]}]}
    end

    def dribble_response
      {resultSets: [{name: "DribbleShooting", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION SORT_ORDER G SHOT_TYPE FGA_FREQUENCY
        FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "Catch and Shoot", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end
  end
end
