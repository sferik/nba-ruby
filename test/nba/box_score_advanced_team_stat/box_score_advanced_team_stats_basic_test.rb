require_relative "../../test_helper"

module NBA
  class BoxScoreAdvancedTeamStatsBasicTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_team_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreAdvanced.team_stats(game: "0022400001")
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreAdvanced.team_stats(game: "0022400001")

      assert_requested :get, /boxscoreadvancedv2.*GameID=0022400001/
    end

    def test_team_stats_parses_result_set_successfully
      stub_box_score_request

      stats = BoxScoreAdvanced.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamStats", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN E_OFF_RATING OFF_RATING
        E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING AST_PCT AST_TOV AST_RATIO
        OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        115.0, 118.0, 105.0, 108.0, 10.0, 10.0, 0.60, 2.0, 0.30,
        0.25, 0.75, 0.50, 0.12, 0.55, 0.58, 98.0, 100.0, 102.0, 200, 0.55]
    end
  end
end
