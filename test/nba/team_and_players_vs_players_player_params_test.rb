require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersPlayerParamsTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_player_params_include_exactly_five_player_ids
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PlayerID1=201939&PlayerID2=0&PlayerID3=0&PlayerID4=0&PlayerID5=0/)
    end

    def test_vs_player_params_include_exactly_five_vs_player_ids
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsPlayerID1=2544&VsPlayerID2=0&VsPlayerID3=0&VsPlayerID4=0&VsPlayerID5=0/)
    end

    def test_does_not_include_player_id_zero
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      refute_requested(:get, /PlayerID0=/)
    end

    def test_does_not_include_vs_player_id_zero
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      refute_requested(:get, /VsPlayerID0=/)
    end

    def test_does_not_include_player_id_six
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      refute_requested(:get, /PlayerID6=/)
    end

    def test_does_not_include_vs_player_id_six
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      refute_requested(:get, /VsPlayerID6=/)
    end

    private

    def response
      {resultSets: [{name: "PlayersVsPlayers", headers: [], rowSet: []}]}
    end
  end
end
