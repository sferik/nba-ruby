require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersMissingKeys2Test < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_handles_missing_reb_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("REB").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.reb
    end

    def test_handles_missing_ast_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("AST").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.ast
    end

    def test_handles_missing_stl_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("STL").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.stl
    end

    def test_handles_missing_blk_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("BLK").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.blk
    end

    def test_handles_missing_tov_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("TOV").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.tov
    end

    def test_handles_missing_fg_pct_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("FG_PCT").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.fg_pct
    end

    def test_handles_missing_plus_minus_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("PLUS_MINUS").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.plus_minus
    end

    private

    def response_missing(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "PlayersVsPlayers", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[TEAM_ID PLAYER_ID VS_PLAYER_ID PLAYER_NAME GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def row
      [1_610_612_744, 201_939, 2544, "Stephen Curry", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]
    end
  end
end
