require_relative "../../test_helper"

module NBA
  class TeamAndPlayersVsPlayersParamsTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /TeamID=1610612744/)
    end

    def test_includes_vs_team_id_in_path
      stub_request(:get, /VsTeamID=1610612747/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsTeamID=1610612747/)
    end

    def test_includes_player_ids_in_path
      stub_request(:get, /PlayerID1=201939/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PlayerID1=201939/)
    end

    def test_includes_vs_player_ids_in_path
      stub_request(:get, /VsPlayerID1=2544/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsPlayerID1=2544/)
    end

    def test_includes_season_in_path
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /Season=2025-26/)
    end

    def test_includes_season_type_in_path
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /SeasonType=Regular%20Season/)
    end

    def test_includes_per_mode_in_path
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PerMode=PerGame/)
    end

    def test_includes_league_id_in_path
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /LeagueID=00/)
    end

    private

    def response
      {resultSets: [{name: "PlayersVsPlayers", headers: [], rowSet: []}]}
    end
  end
end
