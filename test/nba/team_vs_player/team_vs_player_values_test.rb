require_relative "../../test_helper"

module NBA
  class TeamVsPlayerValuesTest < Minitest::Test
    cover TeamVsPlayer

    def setup
      stub_request(:get, /teamvsplayer/).to_return(body: response.to_json)
      @stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first
    end

    def test_extracts_team_id
      assert_equal 1_610_612_744, @stat.team_id
    end

    def test_extracts_vs_player_id
      assert_equal 201_566, @stat.vs_player_id
    end

    def test_extracts_court_status
      assert_equal "Overall", @stat.court_status
    end

    def test_extracts_gp
      assert_equal 24, @stat.gp
    end

    def test_extracts_min
      assert_in_delta 32.5, @stat.min
    end

    def test_extracts_pts
      assert_in_delta 106.4, @stat.pts
    end

    def test_extracts_reb
      assert_in_delta 45.7, @stat.reb
    end

    def test_extracts_ast
      assert_in_delta 26.1, @stat.ast
    end

    def test_extracts_stl
      assert_in_delta 8.2, @stat.stl
    end

    def test_extracts_blk
      assert_in_delta 5.3, @stat.blk
    end

    def test_extracts_tov
      assert_in_delta 13.1, @stat.tov
    end

    def test_extracts_fg_pct
      assert_in_delta 0.467, @stat.fg_pct
    end

    def test_extracts_plus_minus
      assert_in_delta 8.5, @stat.plus_minus
    end

    private

    def response
      {resultSets: [{name: "Overall", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID VS_PLAYER_ID COURT_STATUS GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def row
      [1_610_612_744, 201_566, "Overall", 24, 32.5, 106.4, 45.7, 26.1, 8.2, 5.3, 13.1, 0.467, 8.5]
    end
  end
end
