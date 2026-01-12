require_relative "../../test_helper"

module NBA
  class MatchupsRollupMissingFieldsTest < Minitest::Test
    cover MatchupsRollup

    def test_all_handles_missing_gp
      response = build_response_without("GP")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.gp
      assert_equal "22023", matchup.season_id
    end

    def test_all_handles_missing_matchup_min
      response = build_response_without("MATCHUP_MIN")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.matchup_min
      assert_equal 82, matchup.gp
    end

    def test_all_handles_missing_partial_poss
      response = build_response_without("PARTIAL_POSS")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.partial_poss
      assert_in_delta 15.5, matchup.matchup_min
    end

    def test_all_handles_missing_player_pts
      response = build_response_without("PLAYER_PTS")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.player_pts
      assert_in_delta 10.2, matchup.partial_poss
    end

    def test_all_handles_missing_team_pts
      response = build_response_without("TEAM_PTS")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.team_pts
      assert_in_delta 8.5, matchup.player_pts
    end

    def test_all_handles_missing_matchup_fg3_pct
      response = build_response_without("MATCHUP_FG3_PCT")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.matchup_fg3_pct
      assert_in_delta 0.425, matchup.matchup_fg_pct
    end

    def test_all_handles_missing_def_player_name
      response = build_response_without("DEF_PLAYER_NAME")
      stub_request(:get, /matchupsrollup/).to_return(body: response.to_json)

      matchup = MatchupsRollup.all.first

      assert_nil matchup.def_player_name
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
