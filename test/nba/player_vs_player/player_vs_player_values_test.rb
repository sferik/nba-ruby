require_relative "../../test_helper"

module NBA
  class PlayerVsPlayerValuesTest < Minitest::Test
    cover PlayerVsPlayer

    def test_parses_player_id
      assert_equal 201_939, overall_stat.player_id
    end

    def test_parses_vs_player_id
      assert_equal 201_566, overall_stat.vs_player_id
    end

    def test_parses_court_status
      assert_equal "Overall", overall_stat.court_status
    end

    def test_parses_gp
      assert_equal 24, overall_stat.gp
    end

    def test_parses_min
      assert_in_delta 32.5, overall_stat.min
    end

    def test_parses_pts
      assert_in_delta 26.4, overall_stat.pts
    end

    def test_parses_reb
      assert_in_delta 5.7, overall_stat.reb
    end

    def test_parses_ast
      assert_in_delta 6.1, overall_stat.ast
    end

    def test_parses_stl
      assert_in_delta 1.2, overall_stat.stl
    end

    def test_parses_blk
      assert_in_delta 0.3, overall_stat.blk
    end

    def test_parses_tov
      assert_in_delta 3.1, overall_stat.tov
    end

    def test_parses_fg_pct
      assert_in_delta 0.467, overall_stat.fg_pct
    end

    def test_parses_plus_minus
      assert_in_delta 8.5, overall_stat.plus_minus
    end

    private

    def overall_stat
      stub_request(:get, /playervsplayer/).to_return(body: overall_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566).first
    end

    def overall_response
      {resultSets: [{name: "Overall", headers: headers,
                     rowSet: [[201_939, 201_566, "Overall", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]]}]}
    end

    def headers
      %w[PLAYER_ID VS_PLAYER_ID COURT_STATUS GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end
  end
end
