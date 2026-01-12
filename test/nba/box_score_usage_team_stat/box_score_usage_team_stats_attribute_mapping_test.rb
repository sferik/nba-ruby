require_relative "../../test_helper"

module NBA
  class BoxScoreUsageTeamStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreUsage

    def test_maps_identity_attributes
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_min_attribute
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_equal "240:00", stat.min
    end

    def test_maps_shooting_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 1.0, stat.usg_pct
      assert_in_delta 0.45, stat.pct_fgm
      assert_in_delta 0.50, stat.pct_fga
      assert_in_delta 0.35, stat.pct_fg3m
      assert_in_delta 0.40, stat.pct_fg3a
    end

    def test_maps_free_throw_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.80, stat.pct_ftm
      assert_in_delta 0.85, stat.pct_fta
    end

    def test_maps_rebound_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.25, stat.pct_oreb
      assert_in_delta 0.75, stat.pct_dreb
      assert_in_delta 0.50, stat.pct_reb
    end

    def test_maps_other_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.60, stat.pct_ast
      assert_in_delta 0.40, stat.pct_tov
      assert_in_delta 0.55, stat.pct_stl
      assert_in_delta 0.45, stat.pct_blk
      assert_in_delta 0.30, stat.pct_blka
    end

    def test_maps_foul_and_points_usage_attributes
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")
      stat = stats.first

      assert_in_delta 0.65, stat.pct_pf
      assert_in_delta 0.35, stat.pct_pfd
      assert_in_delta 0.52, stat.pct_pts
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreusagev2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN USG_PCT PCT_FGM PCT_FGA
        PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB PCT_AST PCT_TOV
        PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        1.0, 0.45, 0.50, 0.35, 0.40, 0.80, 0.85, 0.25, 0.75, 0.50, 0.60, 0.40, 0.55, 0.45, 0.30, 0.65, 0.35, 0.52]
    end
  end
end
