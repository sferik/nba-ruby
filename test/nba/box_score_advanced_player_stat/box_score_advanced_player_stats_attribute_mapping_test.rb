require_relative "../../test_helper"

module NBA
  class BoxScoreAdvancedPlayerStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_maps_player_game_and_team_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_identity_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "G", stat.start_position
      assert_equal "", stat.comment
      assert_equal "34:22", stat.min
    end

    def test_maps_player_offensive_rating_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 115.0, stat.e_off_rating
      assert_in_delta 118.0, stat.off_rating
      assert_in_delta 10.0, stat.e_net_rating
      assert_in_delta 10.0, stat.net_rating
    end

    def test_maps_player_defensive_rating_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 105.0, stat.e_def_rating
      assert_in_delta 108.0, stat.def_rating
    end

    def test_maps_player_assist_efficiency_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 0.35, stat.ast_pct
      assert_in_delta 2.5, stat.ast_tov
      assert_in_delta 0.25, stat.ast_ratio
    end

    def test_maps_player_rebound_efficiency_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 0.05, stat.oreb_pct
      assert_in_delta 0.15, stat.dreb_pct
      assert_in_delta 0.10, stat.reb_pct
    end

    def test_maps_player_shooting_efficiency_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 0.12, stat.tov_pct
      assert_in_delta 0.55, stat.efg_pct
      assert_in_delta 0.60, stat.ts_pct
      assert_in_delta 0.15, stat.pie
    end

    def test_maps_player_usage_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 0.28, stat.usg_pct
      assert_in_delta 0.30, stat.e_usg_pct
    end

    def test_maps_all_tempo_attributes
      stub_box_score_request

      stat = BoxScoreAdvanced.player_stats(game: "0022400001").first

      assert_in_delta 98.0, stat.e_pace
      assert_in_delta 100.0, stat.pace
      assert_in_delta 102.0, stat.pace_per40
      assert_equal 50, stat.poss
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN E_OFF_RATING OFF_RATING E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING
        AST_PCT AST_TOV AST_RATIO OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT
        USG_PCT E_USG_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 115.0, 118.0, 105.0, 108.0, 10.0, 10.0,
        0.35, 2.5, 0.25, 0.05, 0.15, 0.10, 0.12, 0.55, 0.60,
        0.28, 0.30, 98.0, 100.0, 102.0, 50, 0.15]
    end
  end
end
