require_relative "../../test_helper"

module NBA
  class TeamAndPlayersVsPlayersMethodParamsTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_team_players_vs_players_off_includes_team_id
      stub_request(:get, /TeamID=1610612744/).to_return(body: response_off.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /TeamID=1610612744/)
    end

    def test_team_players_vs_players_off_includes_vs_team_id
      stub_request(:get, /VsTeamID=1610612747/).to_return(body: response_off.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsTeamID=1610612747/)
    end

    def test_team_players_vs_players_on_includes_team_id
      stub_request(:get, /TeamID=1610612744/).to_return(body: response_on.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /TeamID=1610612744/)
    end

    def test_team_players_vs_players_on_includes_vs_team_id
      stub_request(:get, /VsTeamID=1610612747/).to_return(body: response_on.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsTeamID=1610612747/)
    end

    def test_team_vs_players_includes_team_id
      stub_request(:get, /TeamID=1610612744/).to_return(body: response_team.to_json)

      TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /TeamID=1610612744/)
    end

    def test_team_vs_players_includes_vs_team_id
      stub_request(:get, /VsTeamID=1610612747/).to_return(body: response_team.to_json)

      TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsTeamID=1610612747/)
    end

    private

    def response_off
      {resultSets: [{name: "TeamPlayersVsPlayersOff", headers: [], rowSet: []}]}
    end

    def response_on
      {resultSets: [{name: "TeamPlayersVsPlayersOn", headers: [], rowSet: []}]}
    end

    def response_team
      {resultSets: [{name: "TeamVsPlayers", headers: [], rowSet: []}]}
    end
  end
end
