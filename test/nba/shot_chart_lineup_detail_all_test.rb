require_relative "../test_helper"

module NBA
  class ShotChartLineupDetailAllTest < Minitest::Test
    cover ShotChartLineupDetail

    def test_all_returns_collection
      stub_shot_chart_lineup_detail_request

      assert_instance_of Collection, ShotChartLineupDetail.all(group_id: 12_345)
    end

    def test_all_parses_game_info
      stub_shot_chart_lineup_detail_request

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal "0022400001", shot.game_id
      assert_equal 10, shot.game_event_id
      assert_equal 1, shot.period
      assert_equal 10, shot.minutes_remaining
      assert_equal 45, shot.seconds_remaining
    end

    def test_all_parses_player_info
      stub_shot_chart_lineup_detail_request

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal 201_939, shot.player_id
      assert_equal "Stephen Curry", shot.player_name
    end

    def test_all_parses_team_info
      stub_shot_chart_lineup_detail_request

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal Team::GSW, shot.team_id
      assert_equal "Golden State Warriors", shot.team_name
    end

    def test_all_parses_shot_info
      stub_shot_chart_lineup_detail_request

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal "Jump Shot", shot.action_type
      assert_equal "3PT Field Goal", shot.shot_type
      assert_equal 26, shot.shot_distance
    end

    def test_all_parses_location
      stub_shot_chart_lineup_detail_request

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal(-22, shot.loc_x)
      assert_equal 239, shot.loc_y
    end

    def test_all_parses_shot_flags
      stub_shot_chart_lineup_detail_request

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal 1, shot.shot_attempted_flag
      assert_equal 1, shot.shot_made_flag
    end

    def test_all_with_custom_season
      stub_request(:get, /shotchartlineupdetail.*Season=2022-23/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345, season: 2022)

      assert_requested :get, /shotchartlineupdetail.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /shotchartlineupdetail.*SeasonType=Playoffs/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345, season_type: "Playoffs")

      assert_requested :get, /shotchartlineupdetail.*SeasonType=Playoffs/
    end

    def test_all_with_context_measure
      stub_request(:get, /shotchartlineupdetail.*ContextMeasure=FG3A/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345, context_measure: "FG3A")

      assert_requested :get, /shotchartlineupdetail.*ContextMeasure=FG3A/
    end

    def test_all_with_period
      stub_request(:get, /shotchartlineupdetail.*Period=4/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345, period: 4)

      assert_requested :get, /shotchartlineupdetail.*Period=4/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /shotchartlineupdetail.*LeagueID=00/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345, league: league)

      assert_requested :get, /shotchartlineupdetail.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /shotchartlineupdetail.*LeagueID=00/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345, league: "00")

      assert_requested :get, /shotchartlineupdetail.*LeagueID=00/
    end

    private

    def stub_shot_chart_lineup_detail_request
      stub_request(:get, /shotchartlineupdetail/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)
    end

    def shot_chart_lineup_detail_response
      {resultSets: [{name: "ShotChartLineupDetail",
                     headers: %w[GAME_ID GAME_EVENT_ID PLAYER_ID PLAYER_NAME TEAM_ID TEAM_NAME
                       PERIOD MINUTES_REMAINING SECONDS_REMAINING ACTION_TYPE SHOT_TYPE
                       SHOT_ZONE_BASIC SHOT_ZONE_AREA SHOT_ZONE_RANGE SHOT_DISTANCE
                       LOC_X LOC_Y SHOT_ATTEMPTED_FLAG SHOT_MADE_FLAG],
                     rowSet: [["0022400001", 10, 201_939, "Stephen Curry", Team::GSW,
                       "Golden State Warriors", 1, 10, 45, "Jump Shot", "3PT Field Goal",
                       "Above the Break 3", "Center(C)", "24+ ft.", 26, -22, 239, 1, 1]]}]}
    end
  end
end
