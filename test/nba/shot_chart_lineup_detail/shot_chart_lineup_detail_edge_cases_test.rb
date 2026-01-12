require_relative "../../test_helper"

module NBA
  class ShotChartLineupDetailEdgeCasesTest < Minitest::Test
    cover ShotChartLineupDetail

    def test_all_handles_nil_response
      stub_request(:get, /shotchartlineupdetail/).to_return(body: nil)

      result = ShotChartLineupDetail.all(group_id: 12_345)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /shotchartlineupdetail/).to_return(body: {resultSets: []}.to_json)

      result = ShotChartLineupDetail.all(group_id: 12_345)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      result = ShotChartLineupDetail.all(group_id: 12_345)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "ShotChartLineupDetail",
                                headers: %w[GAME_ID PLAYER_ID], rowSet: []}]}
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      result = ShotChartLineupDetail.all(group_id: 12_345)

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_game_id
      response = {resultSets: [{name: "ShotChartLineupDetail",
                                headers: %w[GAME_EVENT_ID PLAYER_ID PLAYER_NAME],
                                rowSet: [[10, 201_939, "Stephen Curry"]]}]}
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_nil shot.game_id
      assert_equal 10, shot.game_event_id
    end

    def test_all_handles_missing_location
      response = {resultSets: [{name: "ShotChartLineupDetail",
                                headers: %w[GAME_ID GAME_EVENT_ID PLAYER_ID],
                                rowSet: [["0022400001", 10, 201_939]]}]}
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal "0022400001", shot.game_id
      assert_nil shot.loc_x
      assert_nil shot.loc_y
    end

    def test_all_handles_missing_shot_made_flag
      response = {resultSets: [{name: "ShotChartLineupDetail",
                                headers: %w[GAME_ID GAME_EVENT_ID SHOT_ATTEMPTED_FLAG],
                                rowSet: [["0022400001", 10, 1]]}]}
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal 1, shot.shot_attempted_flag
      assert_nil shot.shot_made_flag
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "ShotChartLineupDetail", headers: all_headers, rowSet: [full_row]}
      ]}
      stub_request(:get, /shotchartlineupdetail/).to_return(body: response.to_json)

      shot = ShotChartLineupDetail.all(group_id: 12_345).first

      assert_equal "0022400001", shot.game_id
      assert_equal 201_939, shot.player_id
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
  end
end
