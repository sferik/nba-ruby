require_relative "../test_helper"

module NBA
  class ShotChartFindBasicTest < Minitest::Test
    cover ShotChart

    def test_find_returns_collection
      stub_shot_chart_request

      assert_instance_of Collection, ShotChart.find(player: 201_939, team: Team::GSW)
    end

    def test_find_uses_correct_player_id_in_path
      stub_shot_chart_request

      ShotChart.find(player: 201_939, team: Team::GSW)

      assert_requested :get, /shotchartdetail.*PlayerID=201939/
    end

    def test_find_uses_correct_team_id_in_path
      stub_shot_chart_request

      ShotChart.find(player: 201_939, team: Team::GSW)

      assert_requested :get, /shotchartdetail.*TeamID=#{Team::GSW}/o
    end

    def test_find_uses_default_season
      stub_shot_chart_request

      ShotChart.find(player: 201_939, team: Team::GSW)

      assert_requested :get, /shotchartdetail.*Season=\d{4}-\d{2}/
    end

    def test_find_accepts_custom_season
      stub_shot_chart_request

      ShotChart.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /shotchartdetail.*Season=2023-24/
    end

    private

    def stub_shot_chart_request
      stub_request(:get, /shotchartdetail/).to_return(body: shot_chart_response.to_json)
    end

    def shot_chart_response
      {resultSets: [{name: "Shot_Chart_Detail", headers: shot_headers, rowSet: [shot_row]}]}
    end

    def shot_headers
      %w[GRID_TYPE GAME_ID GAME_EVENT_ID PLAYER_ID PLAYER_NAME TEAM_ID TEAM_NAME PERIOD
        MINUTES_REMAINING SECONDS_REMAINING EVENT_TYPE ACTION_TYPE SHOT_TYPE SHOT_ZONE_BASIC
        SHOT_ZONE_AREA SHOT_ZONE_RANGE SHOT_DISTANCE LOC_X LOC_Y SHOT_ATTEMPTED_FLAG SHOT_MADE_FLAG]
    end

    def shot_row
      ["Shot Chart Detail", "0022400001", 1, 201_939, "Stephen Curry", Team::GSW, "Warriors", 1,
        10, 30, "Made Shot", "Jump Shot", "3PT Field Goal", "Above the Break 3",
        "Right Side Center(RC)", "24+ ft.", 26, 100, 150, 1, 1]
    end
  end
end
