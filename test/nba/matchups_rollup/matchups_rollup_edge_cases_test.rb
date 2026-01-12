require_relative "../../test_helper"

module NBA
  class MatchupsRollupEdgeCasesTest < Minitest::Test
    cover MatchupsRollup

    def test_all_handles_nil_response
      stub_request(:get, /matchupsrollup/).to_return(body: nil)

      result = MatchupsRollup.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /matchupsrollup/).to_return(body: {resultSets: []}.to_json)

      result = MatchupsRollup.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      result = MatchupsRollup.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "MatchupsRollup",
                                headers: %w[SEASON_ID DEF_PLAYER_ID], rowSet: []}]}
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      result = MatchupsRollup.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_season_id
      response = {resultSets: [{name: "MatchupsRollup",
                                headers: %w[DEF_PLAYER_ID DEF_PLAYER_NAME],
                                rowSet: [[1_628_369, "Jayson Tatum"]]}]}
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.season_id
      assert_equal 1_628_369, matchup.def_player_id
    end

    def test_all_handles_missing_fg_pct
      response = {resultSets: [{name: "MatchupsRollup",
                                headers: %w[SEASON_ID DEF_PLAYER_ID DEF_PLAYER_NAME],
                                rowSet: [["22023", 1_628_369, "Jayson Tatum"]]}]}
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_equal "22023", matchup.season_id
      assert_nil matchup.matchup_fg_pct
      assert_nil matchup.matchup_fg3_pct
    end

    def test_all_handles_missing_position
      response = build_response_without("POSITION")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.position
      assert_equal "22023", matchup.season_id
    end

    def test_all_handles_missing_percent_of_time
      response = build_response_without("PERCENT_OF_TIME")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.percent_of_time
      assert_equal "F", matchup.position
    end

    def test_all_handles_missing_def_player_id
      response = build_response_without("DEF_PLAYER_ID")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.def_player_id
      assert_equal "Jayson Tatum", matchup.def_player_name
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "MatchupsRollup", headers: all_headers, rowSet: [full_row]}
      ]}
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_equal "22023", matchup.season_id
      assert_equal 1_628_369, matchup.def_player_id
    end

    private

    def all_headers
      %w[SEASON_ID POSITION PERCENT_OF_TIME DEF_PLAYER_ID DEF_PLAYER_NAME
        GP MATCHUP_MIN PARTIAL_POSS PLAYER_PTS TEAM_PTS
        MATCHUP_FG_PCT MATCHUP_FG3_PCT]
    end

    def full_row
      ["22023", "F", 0.25, 1_628_369, "Jayson Tatum",
        82, 15.5, 10.2, 8.5, 12.3, 0.425, 0.352]
    end

    def build_response_without(excluded_header)
      headers = all_headers.reject { |h| h.eql?(excluded_header) }
      excluded_index = all_headers.index(excluded_header)
      row = full_row.reject.with_index { |_v, i| i.eql?(excluded_index) }
      {resultSets: [{name: "MatchupsRollup", headers: headers, rowSet: [row]}]}
    end
  end
end
