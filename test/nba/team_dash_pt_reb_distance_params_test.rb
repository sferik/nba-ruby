require_relative "../test_helper"

module NBA
  class TeamDashPtRebDistanceParamsTest < Minitest::Test
    cover TeamDashPtReb

    def test_reb_distance_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: reb_distance_response.to_json)
      TeamDashPtReb.reb_distance(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_reb_distance_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: reb_distance_response.to_json)
      TeamDashPtReb.reb_distance(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_reb_distance_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: reb_distance_response.to_json)
      TeamDashPtReb.reb_distance(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_shot_distance_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: shot_distance_response.to_json)
      TeamDashPtReb.shot_distance(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_shot_distance_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: shot_distance_response.to_json)
      TeamDashPtReb.shot_distance(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_shot_distance_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: shot_distance_response.to_json)
      TeamDashPtReb.shot_distance(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_shot_type_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: shot_type_response.to_json)
      TeamDashPtReb.shot_type(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_shot_type_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: shot_type_response.to_json)
      TeamDashPtReb.shot_type(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_shot_type_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: shot_type_response.to_json)
      TeamDashPtReb.shot_type(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    private

    def headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
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
  end
end
