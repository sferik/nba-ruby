require_relative "../../test_helper"

module NBA
  class BoxScoreScoringPlayerMissingKeysTest < Minitest::Test
    cover BoxScoreScoring

    def test_missing_game_id
      assert_missing_key_returns_nil("GAME_ID", 0, :game_id)
    end

    def test_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 1, :team_id)
    end

    def test_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 2, :team_abbreviation)
    end

    def test_missing_team_city
      assert_missing_key_returns_nil("TEAM_CITY", 3, :team_city)
    end

    def test_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 4, :player_id)
    end

    def test_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 5, :player_name)
    end

    def test_missing_start_position
      assert_missing_key_returns_nil("START_POSITION", 6, :start_position)
    end

    def test_missing_comment
      assert_missing_key_returns_nil("COMMENT", 7, :comment)
    end

    def test_missing_min
      assert_missing_key_returns_nil("MIN", 8, :min)
    end

    def test_missing_pct_fga_2pt
      assert_missing_key_returns_nil("PCT_FGA_2PT", 9, :pct_fga_2pt)
    end

    def test_missing_pct_fga_3pt
      assert_missing_key_returns_nil("PCT_FGA_3PT", 10, :pct_fga_3pt)
    end

    def test_missing_pct_pts_2pt
      assert_missing_key_returns_nil("PCT_PTS_2PT", 11, :pct_pts_2pt)
    end

    def test_missing_pct_pts_2pt_mr
      assert_missing_key_returns_nil("PCT_PTS_2PT_MR", 12, :pct_pts_2pt_mr)
    end

    def test_missing_pct_pts_3pt
      assert_missing_key_returns_nil("PCT_PTS_3PT", 13, :pct_pts_3pt)
    end

    def test_missing_pct_pts_fb
      assert_missing_key_returns_nil("PCT_PTS_FB", 14, :pct_pts_fb)
    end

    def test_missing_pct_pts_ft
      assert_missing_key_returns_nil("PCT_PTS_FT", 15, :pct_pts_ft)
    end

    def test_missing_pct_pts_off_tov
      assert_missing_key_returns_nil("PCT_PTS_OFF_TOV", 16, :pct_pts_off_tov)
    end

    def test_missing_pct_pts_paint
      assert_missing_key_returns_nil("PCT_PTS_PAINT", 17, :pct_pts_paint)
    end

    def test_missing_pct_ast_2pm
      assert_missing_key_returns_nil("PCT_AST_2PM", 18, :pct_ast_2pm)
    end

    def test_missing_pct_uast_2pm
      assert_missing_key_returns_nil("PCT_UAST_2PM", 19, :pct_uast_2pm)
    end

    def test_missing_pct_ast_3pm
      assert_missing_key_returns_nil("PCT_AST_3PM", 20, :pct_ast_3pm)
    end

    def test_missing_pct_uast_3pm
      assert_missing_key_returns_nil("PCT_UAST_3PM", 21, :pct_uast_3pm)
    end

    def test_missing_pct_ast_fgm
      assert_missing_key_returns_nil("PCT_AST_FGM", 22, :pct_ast_fgm)
    end

    def test_missing_pct_uast_fgm
      assert_missing_key_returns_nil("PCT_UAST_FGM", 23, :pct_uast_fgm)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = player_headers.reject { |h| h == key }
      row = player_row[0...index] + player_row[(index + 1)..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)
      stat = BoxScoreScoring.player_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PCT_FGA_2PT PCT_FGA_3PT PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT
        PCT_PTS_OFF_TOV PCT_PTS_PAINT PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.4, 0.6, 0.2, 0.1, 0.5, 0.15, 0.1, 0.05, 0.25, 0.3, 0.7, 0.5, 0.5, 0.4, 0.6]
    end
  end
end
