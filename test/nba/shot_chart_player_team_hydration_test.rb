require_relative "../test_helper"

module NBA
  class ShotChartPlayerHydrationTest < Minitest::Test
    cover ShotChart

    def test_find_accepts_player_object
      stub_shot_chart_request
      player = Player.new(id: 201_939, full_name: "Stephen Curry")

      ShotChart.find(player: player, team: Team::GSW)

      assert_requested :get, /shotchartdetail.*PlayerID=201939/
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

  class ShotChartTeamHydrationTest < Minitest::Test
    cover ShotChart

    def test_find_accepts_team_object
      stub_shot_chart_request
      team = Team.new(id: Team::GSW, full_name: "Golden State Warriors")

      ShotChart.find(player: 201_939, team: team)

      assert_requested :get, /shotchartdetail.*TeamID=#{Team::GSW}/o
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
