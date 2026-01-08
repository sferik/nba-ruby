require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_players_vs_players_returns_collection
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_instance_of Collection, result
    end

    def test_team_players_vs_players_off_returns_collection
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: off_court_response.to_json)

      result = TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_instance_of Collection, result
    end

    def test_team_players_vs_players_on_returns_collection
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: on_court_response.to_json)

      result = TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_instance_of Collection, result
    end

    def test_team_vs_players_returns_collection
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: team_vs_response.to_json)

      result = TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_instance_of Collection, result
    end

    def test_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544],
        client: mock_client
      )

      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544],
        client: mock_client
      )

      assert_empty result
      mock_client.verify
    end

    private

    def response
      {resultSets: [{name: "PlayersVsPlayers", headers: headers, rowSet: [row]}]}
    end

    def off_court_response
      {resultSets: [{name: "TeamPlayersVsPlayersOff", headers: headers, rowSet: [row]}]}
    end

    def on_court_response
      {resultSets: [{name: "TeamPlayersVsPlayersOn", headers: headers, rowSet: [row]}]}
    end

    def team_vs_response
      {resultSets: [{name: "TeamVsPlayers", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID PLAYER_ID VS_PLAYER_ID PLAYER_NAME GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def row
      [1_610_612_744, 201_939, 2544, "Stephen Curry", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]
    end
  end
end
