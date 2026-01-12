require_relative "../../test_helper"

module NBA
  class ShotChartParseLocationTest < Minitest::Test
    cover ShotChart

    def test_parses_action_type
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal "Jump Shot", shot.action_type
    end

    def test_parses_shot_type
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal "3PT Field Goal", shot.shot_type
    end

    def test_parses_shot_zones
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal "Above the Break 3", shot.shot_zone_basic
      assert_equal "Right Side Center(RC)", shot.shot_zone_area
      assert_equal "24+ ft.", shot.shot_zone_range
    end

    def test_parses_shot_distance
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal 26, shot.shot_distance
    end

    def test_parses_coordinates
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal 100, shot.loc_x
      assert_equal 150, shot.loc_y
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
