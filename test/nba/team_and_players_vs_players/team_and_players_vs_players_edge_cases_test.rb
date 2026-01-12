require_relative "../../test_helper"

module NBA
  class TeamAndPlayersVsPlayersEdgeCasesTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_handles_missing_result_sets
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: {}.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end

    def test_handles_missing_result_set
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: {resultSets: []}.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end

    def test_handles_missing_headers
      response = {resultSets: [{name: "PlayersVsPlayers", rowSet: []}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end

    def test_handles_missing_row_set
      response = {resultSets: [{name: "PlayersVsPlayers", headers: []}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end

    def test_handles_wrong_result_set_name
      response = {resultSets: [{name: "WrongName", headers: [], rowSet: []}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end

    def test_handles_nil_headers_with_rows_present
      response = {resultSets: [{name: "PlayersVsPlayers", headers: nil, rowSet: [[1, 2]]}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end

    def test_handles_result_set_without_name_key
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_empty result
    end
  end
end
