require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersMissingKeysTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_handles_missing_team_id_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("TEAM_ID").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.team_id
    end

    def test_handles_missing_player_id_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("PLAYER_ID").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.player_id
    end

    def test_handles_missing_vs_player_id_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("VS_PLAYER_ID").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.vs_player_id
    end

    def test_handles_missing_player_name_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("PLAYER_NAME").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.player_name
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("GP").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.gp
    end

    def test_handles_missing_min_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("MIN").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.min
    end

    def test_handles_missing_pts_key
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response_missing("PTS").to_json)
      stat = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      ).first

      assert_nil stat.pts
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
