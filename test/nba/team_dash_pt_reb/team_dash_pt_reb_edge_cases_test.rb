require_relative "../../test_helper"

module NBA
  class TeamDashPtRebEdgeCasesTest < Minitest::Test
    cover TeamDashPtReb

    def test_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /teamdashptreb/).to_return(body: response_without_result_sets.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_result_set_not_found
      stub_request(:get, /teamdashptreb/).to_return(body: wrong_result_set_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_result_set_has_no_name_key
      stub_request(:get, /teamdashptreb/).to_return(body: result_set_no_name_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_headers_nil
      stub_request(:get, /teamdashptreb/).to_return(body: headers_nil_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_rowset_nil
      stub_request(:get, /teamdashptreb/).to_return(body: rowset_nil_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_headers_key_missing
      stub_request(:get, /teamdashptreb/).to_return(body: headers_key_missing_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_returns_empty_collection_when_rowset_key_missing
      stub_request(:get, /teamdashptreb/).to_return(body: rowset_key_missing_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_empty result
    end

    def test_reb_distance_includes_correct_params
      stub_request(:get, /teamdashptreb/).to_return(body: reb_distance_response.to_json)

      TeamDashPtReb.reb_distance(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    def test_shot_distance_includes_correct_params
      stub_request(:get, /teamdashptreb/).to_return(body: shot_distance_response.to_json)

      TeamDashPtReb.shot_distance(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    def test_shot_type_includes_correct_params
      stub_request(:get, /teamdashptreb/).to_return(body: shot_type_response.to_json)

      TeamDashPtReb.shot_type(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

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
      {resultSets: [{name: "NumContestedRebounding", headers: nil, rowSet: [row]}]}
    end

    def rowset_nil_response
      {resultSets: [{name: "NumContestedRebounding", headers: headers, rowSet: nil}]}
    end

    def headers_key_missing_response
      {resultSets: [{name: "NumContestedRebounding", rowSet: [row]}]}
    end

    def rowset_key_missing_response
      {resultSets: [{name: "NumContestedRebounding", headers: headers}]}
    end

    def reb_distance_response
      {resultSets: [{name: "RebDistanceRebounding", headers: headers, rowSet: [row]}]}
    end

    def shot_distance_response
      {resultSets: [{name: "ShotDistanceRebounding", headers: headers, rowSet: [row]}]}
    end

    def shot_type_response
      {resultSets: [{name: "ShotTypeRebounding", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
