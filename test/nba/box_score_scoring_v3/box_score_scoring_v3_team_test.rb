require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreScoringV3TeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreScoringV3

    def test_team_stats_returns_collection
      stub_scoring_v3_request

      result = BoxScoreScoringV3.team_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_team_stats_parses_identity
      stub_scoring_v3_request

      stat = BoxScoreScoringV3.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_team_stats_parses_basic_stats
      stub_scoring_v3_request

      stat = BoxScoreScoringV3.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
      assert_in_delta 0.45, stat.pct_fga_2pt
      assert_in_delta 0.55, stat.pct_fga_3pt
      assert_in_delta 0.40, stat.pct_pts_2pt
      assert_in_delta 0.15, stat.pct_pts_2pt_mr
    end

    def test_team_stats_parses_scoring_percentages
      stub_scoring_v3_request

      stat = BoxScoreScoringV3.team_stats(game: "0022400001").first

      assert_in_delta 0.45, stat.pct_pts_3pt
      assert_in_delta 0.12, stat.pct_pts_fb
      assert_in_delta 0.03, stat.pct_pts_ft
      assert_in_delta 0.10, stat.pct_pts_off_tov
      assert_in_delta 0.30, stat.pct_pts_paint
    end

    def test_team_stats_parses_assist_percentages
      stub_scoring_v3_request

      stat = BoxScoreScoringV3.team_stats(game: "0022400001").first

      assert_in_delta 0.65, stat.pct_ast_2pm
      assert_in_delta 0.35, stat.pct_uast_2pm
      assert_in_delta 0.80, stat.pct_ast_3pm
      assert_in_delta 0.20, stat.pct_uast_3pm
    end

    def test_team_stats_parses_assist_field_goal_pct
      stub_scoring_v3_request

      stat = BoxScoreScoringV3.team_stats(game: "0022400001").first

      assert_in_delta 0.70, stat.pct_ast_fgm
      assert_in_delta 0.30, stat.pct_uast_fgm
    end

    private

    def stub_scoring_v3_request
      stub_request(:get, /boxscorescoringv3.*GameID=0022400001/)
        .to_return(body: scoring_v3_response.to_json)
    end
  end
end
