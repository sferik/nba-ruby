require_relative "../../test_helper"

module NBA
  class ShotChartParseIdentityTest < Minitest::Test
    cover ShotChart

    def test_parses_game_id
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal "0022400001", shot.game_id
    end

    def test_parses_game_event_id
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal 1, shot.game_event_id
    end

    def test_parses_player_id
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal 201_939, shot.player_id
    end

    def test_parses_player_name
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal "Stephen Curry", shot.player_name
    end

    def test_parses_team_id
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal Team::GSW, shot.team_id
    end

    def test_parses_team_name
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal "Warriors", shot.team_name
    end

    def test_parses_period
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal 1, shot.period
    end

    def test_parses_time_remaining
      stub_shot_chart_request

      shot = ShotChart.find(player: 201_939, team: Team::GSW).first

      assert_equal 10, shot.minutes_remaining
      assert_equal 30, shot.seconds_remaining
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
