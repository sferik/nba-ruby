require_relative "../test_helper"

module NBA
  class ShotChartLineupDetailMissingFieldsTest < Minitest::Test
    cover ShotChartLineupDetail

    def test_all_handles_missing_game_event_id
      response = build_response_without("GAME_EVENT_ID")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.game_event_id
      assert_equal "0022400001", shot.game_id
    end

    def test_all_handles_missing_period
      response = build_response_without("PERIOD")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.period
      assert_equal "0022400001", shot.game_id
    end

    def test_all_handles_missing_minutes_remaining
      response = build_response_without("MINUTES_REMAINING")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.minutes_remaining
      assert_equal 1, shot.period
    end

    def test_all_handles_missing_seconds_remaining
      response = build_response_without("SECONDS_REMAINING")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.seconds_remaining
      assert_equal 10, shot.minutes_remaining
    end

    def test_all_handles_missing_player_id
      response = build_response_without("PLAYER_ID")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.player_id
      assert_equal "Stephen Curry", shot.player_name
    end

    def test_all_handles_missing_player_name
      response = build_response_without("PLAYER_NAME")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.player_name
      assert_equal 201_939, shot.player_id
    end

    def test_all_handles_missing_team_id
      response = build_response_without("TEAM_ID")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.team_id
      assert_equal "Golden State Warriors", shot.team_name
    end

    def test_all_handles_missing_team_name
      response = build_response_without("TEAM_NAME")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.team_name
      assert_equal Team::GSW, shot.team_id
    end

    def test_all_handles_missing_action_type
      response = build_response_without("ACTION_TYPE")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.action_type
      assert_equal "3PT Field Goal", shot.shot_type
    end

    def test_all_handles_missing_shot_type
      response = build_response_without("SHOT_TYPE")
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.shot_type
      assert_equal "Jump Shot", shot.action_type
    end

    private

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
