require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersValuesTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def setup
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)
      @stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first
    end

    def test_extracts_team_id
      assert_equal 1_610_612_744, @stat.team_id
    end

    def test_extracts_player_id
      assert_equal 201_939, @stat.player_id
    end

    def test_extracts_vs_player_id
      assert_equal 2544, @stat.vs_player_id
    end

    def test_extracts_player_name
      assert_equal "Stephen Curry", @stat.player_name
    end

    def test_extracts_gp
      assert_equal 24, @stat.gp
    end

    def test_extracts_min
      assert_in_delta 32.5, @stat.min
    end

    def test_extracts_pts
      assert_in_delta 26.4, @stat.pts
    end

    def test_extracts_reb
      assert_in_delta 5.7, @stat.reb
    end

    def test_extracts_ast
      assert_in_delta 6.1, @stat.ast
    end

    def test_extracts_stl
      assert_in_delta 1.2, @stat.stl
    end

    def test_extracts_blk
      assert_in_delta 0.3, @stat.blk
    end

    def test_extracts_tov
      assert_in_delta 3.1, @stat.tov
    end

    def test_extracts_fg_pct
      assert_in_delta 0.467, @stat.fg_pct
    end

    def test_extracts_plus_minus
      assert_in_delta 8.5, @stat.plus_minus
    end

    private

    def response
      {resultSets: [{name: "PlayersVsPlayers", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID PLAYER_ID VS_PLAYER_ID PLAYER_NAME GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def row
      [1_610_612_744, 201_939, 2544, "Stephen Curry", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]
    end
  end
end
