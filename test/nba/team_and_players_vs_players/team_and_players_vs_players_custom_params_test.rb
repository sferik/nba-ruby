require_relative "../../test_helper"

module NBA
  class TeamAndPlayersVsPlayersCustomParamsTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_with_custom_season
      stub_request(:get, /Season=2023-24/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544],
        season: 2023
      )

      assert_requested(:get, /Season=2023-24/)
    end

    def test_with_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544],
        season_type: "Playoffs"
      )

      assert_requested(:get, /SeasonType=Playoffs/)
    end

    def test_with_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544],
        per_mode: "Totals"
      )

      assert_requested(:get, /PerMode=Totals/)
    end

    def test_team_players_off_uses_correct_result_set
      response = {resultSets: [{name: "TeamPlayersVsPlayersOff", headers: headers, rowSet: [row]}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
    end

    def test_team_players_on_uses_correct_result_set
      response = {resultSets: [{name: "TeamPlayersVsPlayersOn", headers: headers, rowSet: [row]}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
    end

    def test_team_vs_players_uses_correct_result_set
      response = {resultSets: [{name: "TeamVsPlayers", headers: headers, rowSet: [row]}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
    end

    private

    def response
      {resultSets: [{name: "PlayersVsPlayers", headers: [], rowSet: []}]}
    end

    def headers
      %w[TEAM_ID PLAYER_ID VS_PLAYER_ID PLAYER_NAME GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def row
      [1_610_612_744, 201_939, 2544, "Stephen Curry", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]
    end
  end
end
