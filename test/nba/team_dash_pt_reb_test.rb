require_relative "../test_helper"

module NBA
  class TeamDashPtRebTest < Minitest::Test
    cover TeamDashPtReb

    def test_num_contested_returns_collection
      stub_request(:get, /teamdashptreb/).to_return(body: num_contested_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_overall_returns_collection
      stub_request(:get, /teamdashptreb/).to_return(body: overall_response.to_json)

      result = TeamDashPtReb.overall(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_reb_distance_returns_collection
      stub_request(:get, /teamdashptreb/).to_return(body: reb_distance_response.to_json)

      result = TeamDashPtReb.reb_distance(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_shot_distance_returns_collection
      stub_request(:get, /teamdashptreb/).to_return(body: shot_distance_response.to_json)

      result = TeamDashPtReb.shot_distance(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_shot_type_returns_collection
      stub_request(:get, /teamdashptreb/).to_return(body: shot_type_response.to_json)

      result = TeamDashPtReb.shot_type(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_num_contested_returns_team_rebound_stat_objects
      stub_request(:get, /teamdashptreb/).to_return(body: num_contested_response.to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_instance_of TeamReboundStat, result.first
    end

    def test_returns_empty_collection_for_nil_response
      client = Minitest::Mock.new
      client.expect :get, nil, [String]

      result = TeamDashPtReb.num_contested(team: 1_610_612_744, client: client)

      assert_empty result
      client.verify
    end

    def test_returns_empty_collection_for_empty_response
      stub_request(:get, /teamdashptreb/).to_return(body: "")

      result = TeamDashPtReb.overall(team: 1_610_612_744)

      assert_empty result
    end

    private

    def num_contested_response
      {resultSets: [{name: "NumContestedRebounding", headers: headers, rowSet: [row]}]}
    end

    def overall_response
      {resultSets: [{name: "OverallRebounding", headers: overall_headers, rowSet: [overall_row]}]}
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

    def overall_headers
      %w[TEAM_ID TEAM_NAME G OVERALL REB_FREQUENCY OREB DREB REB
        C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def overall_row
      [1_610_612_744, "Golden State Warriors", 82, "Overall", 1.0,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
