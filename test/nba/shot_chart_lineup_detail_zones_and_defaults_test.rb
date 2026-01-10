require_relative "../test_helper"

module NBA
  class ShotChartLineupDetailZonesAndDefaultsTest < Minitest::Test
    cover ShotChartLineupDetail

    def test_all_handles_missing_shot_zone_basic
      response = build_response_without("SHOT_ZONE_BASIC")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.shot_zone_basic
      assert_equal "3PT Field Goal", shot.shot_type
    end

    def test_all_handles_missing_shot_zone_area
      response = build_response_without("SHOT_ZONE_AREA")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.shot_zone_area
      assert_equal "Above the Break 3", shot.shot_zone_basic
    end

    def test_all_handles_missing_shot_zone_range
      response = build_response_without("SHOT_ZONE_RANGE")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.shot_zone_range
      assert_equal "Center(C)", shot.shot_zone_area
    end

    def test_all_handles_missing_shot_distance
      response = build_response_without("SHOT_DISTANCE")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.shot_distance
      assert_equal "24+ ft.", shot.shot_zone_range
    end

    def test_all_handles_missing_shot_attempted_flag
      response = build_response_without("SHOT_ATTEMPTED_FLAG")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.shot_attempted_flag
      assert_equal 239, shot.loc_y
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /shotchartlineupdetail.*SeasonType=Regular%20Season/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345)

      assert_requested :get, /shotchartlineupdetail.*SeasonType=Regular%20Season/
    end

    def test_all_default_context_measure_is_fga
      stub_request(:get, /shotchartlineupdetail.*ContextMeasure=FGA/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345)

      assert_requested :get, /shotchartlineupdetail.*ContextMeasure=FGA/
    end

    def test_all_default_period_is_zero
      stub_request(:get, /shotchartlineupdetail.*Period=0/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345)

      assert_requested :get, /shotchartlineupdetail.*Period=0/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /shotchartlineupdetail.*LeagueID=00/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345)

      assert_requested :get, /shotchartlineupdetail.*LeagueID=00/
    end

    def test_all_uses_group_id_in_request
      stub_request(:get, /shotchartlineupdetail.*GROUP_ID=12345/)
        .to_return(body: shot_chart_lineup_detail_response.to_json)

      ShotChartLineupDetail.all(group_id: 12_345)

      assert_requested :get, /shotchartlineupdetail.*GROUP_ID=12345/
    end

    private

    def shot_chart_lineup_detail_response
      {resultSets: [{name: "ShotChartLineupDetail", headers: all_headers, rowSet: [full_row]}]}
    end

    def all_headers
      %w[GAME_ID GAME_EVENT_ID PLAYER_ID PLAYER_NAME TEAM_ID TEAM_NAME
        PERIOD MINUTES_REMAINING SECONDS_REMAINING ACTION_TYPE SHOT_TYPE
        SHOT_ZONE_BASIC SHOT_ZONE_AREA SHOT_ZONE_RANGE SHOT_DISTANCE
        LOC_X LOC_Y SHOT_ATTEMPTED_FLAG SHOT_MADE_FLAG]
    end

    def full_row
      ["0022400001", 10, 201_939, "Stephen Curry", Team::GSW,
        "Golden State Warriors", 1, 10, 45, "Jump Shot", "3PT Field Goal",
        "Above the Break 3", "Center(C)", "24+ ft.", 26, -22, 239, 1, 1]
    end

    def build_response_without(excluded_header)
      headers = all_headers.reject { |h| h.eql?(excluded_header) }
      excluded_index = all_headers.index(excluded_header)
      row = full_row.reject.with_index { |_v, i| i.eql?(excluded_index) }
      {resultSets: [{name: "ShotChartLineupDetail", headers: headers, rowSet: [row]}]}
    end
  end
end
