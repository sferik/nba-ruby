require_relative "../test_helper"

module NBA
  class BoxScoreAdvancedTeamStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_maps_team_game_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_maps_team_identity_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "240:00", stat.min
    end

    def test_maps_team_offensive_rating_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_in_delta 115.0, stat.e_off_rating
      assert_in_delta 118.0, stat.off_rating
      assert_in_delta 10.0, stat.e_net_rating
      assert_in_delta 10.0, stat.net_rating
    end

    def test_maps_team_defensive_rating_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_in_delta 105.0, stat.e_def_rating
      assert_in_delta 108.0, stat.def_rating
    end

    def test_maps_team_assist_efficiency_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_in_delta 0.60, stat.ast_pct
      assert_in_delta 2.0, stat.ast_tov
      assert_in_delta 0.30, stat.ast_ratio
    end

    def test_maps_team_rebound_efficiency_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_in_delta 0.25, stat.oreb_pct
      assert_in_delta 0.75, stat.dreb_pct
      assert_in_delta 0.50, stat.reb_pct
    end

    def test_maps_team_shooting_efficiency_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_in_delta 0.12, stat.tov_pct
      assert_in_delta 0.55, stat.efg_pct
      assert_in_delta 0.58, stat.ts_pct
      assert_in_delta 0.55, stat.pie
    end

    def test_maps_team_tempo_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.team_stats(game: "0022400001").first

      assert_in_delta 98.0, stat.e_pace
      assert_in_delta 100.0, stat.pace
      assert_in_delta 102.0, stat.pace_per40
      assert_equal 200, stat.poss
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
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
