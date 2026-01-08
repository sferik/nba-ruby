require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersDefaultsTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_team_players_vs_players_off_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response_off.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /SeasonType=Regular%20Season/)
    end

    def test_team_players_vs_players_off_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: response_off.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PerMode=PerGame/)
    end

    def test_team_players_vs_players_on_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response_on.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /SeasonType=Regular%20Season/)
    end

    def test_team_players_vs_players_on_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: response_on.to_json)

      TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PerMode=PerGame/)
    end

    def test_team_vs_players_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response_team.to_json)

      TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /SeasonType=Regular%20Season/)
    end

    def test_team_vs_players_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: response_team.to_json)

      TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PerMode=PerGame/)
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
