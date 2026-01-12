require_relative "../../test_helper"

module NBA
  class BoxScoreUsagePlayerStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreUsage

    def test_maps_game_and_team_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_identity_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "G", stat.start_position
      assert_equal "", stat.comment
      assert_equal "34:22", stat.min
    end

    def test_maps_shooting_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.28, stat.usg_pct
      assert_in_delta 0.25, stat.pct_fgm
      assert_in_delta 0.22, stat.pct_fga
      assert_in_delta 0.35, stat.pct_fg3m
      assert_in_delta 0.30, stat.pct_fg3a
    end

    def test_maps_free_throw_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.20, stat.pct_ftm
      assert_in_delta 0.18, stat.pct_fta
    end

    def test_maps_rebound_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.05, stat.pct_oreb
      assert_in_delta 0.12, stat.pct_dreb
      assert_in_delta 0.10, stat.pct_reb
    end

    def test_maps_other_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.30, stat.pct_ast
      assert_in_delta 0.15, stat.pct_tov
      assert_in_delta 0.08, stat.pct_stl
      assert_in_delta 0.02, stat.pct_blk
      assert_in_delta 0.03, stat.pct_blka
    end

    def test_maps_foul_and_points_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.player_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.10, stat.pct_pf
      assert_in_delta 0.15, stat.pct_pfd
      assert_in_delta 0.28, stat.pct_pts
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreusagev2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN USG_PCT PCT_FGM PCT_FGA PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB
        PCT_AST PCT_TOV PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.28, 0.25, 0.22, 0.35, 0.30, 0.20, 0.18, 0.05, 0.12, 0.10,
        0.30, 0.15, 0.08, 0.02, 0.03, 0.10, 0.15, 0.28]
    end
  end
end
