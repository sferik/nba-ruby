require_relative "../../test_helper"

module NBA
  class TeamAndPlayersVsPlayersParams2Test < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: team, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /TeamID=1610612744/)
    end

    def test_extracts_id_from_vs_team_object
      stub_request(:get, /VsTeamID=1610612747/).to_return(body: response.to_json)
      vs_team = Team.new(id: 1_610_612_747)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: vs_team, players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /VsTeamID=1610612747/)
    end

    def test_extracts_id_from_player_objects
      stub_request(:get, /PlayerID1=201939/).to_return(body: response.to_json)
      player = Player.new(id: 201_939)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [player], vs_players: [2544]
      )

      assert_requested(:get, /PlayerID1=201939/)
    end

    def test_extracts_id_from_vs_player_objects
      stub_request(:get, /VsPlayerID1=2544/).to_return(body: response.to_json)
      vs_player = Player.new(id: 2544)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [vs_player]
      )

      assert_requested(:get, /VsPlayerID1=2544/)
    end

    def test_includes_multiple_player_ids
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747,
        players: [201_939, 201_142, 203_110], vs_players: [2544]
      )

      assert_requested(:get, /PlayerID1=201939/)
      assert_requested(:get, /PlayerID2=201142/)
      assert_requested(:get, /PlayerID3=203110/)
    end

    def test_includes_multiple_vs_player_ids
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747,
        players: [201_939], vs_players: [2544, 201_566, 203_507]
      )

      assert_requested(:get, /VsPlayerID1=2544/)
      assert_requested(:get, /VsPlayerID2=201566/)
      assert_requested(:get, /VsPlayerID3=203507/)
    end

    def test_pads_missing_player_ids_with_zero
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: response.to_json)

      TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747,
        players: [201_939], vs_players: [2544]
      )

      assert_requested(:get, /PlayerID2=0/)
      assert_requested(:get, /PlayerID3=0/)
      assert_requested(:get, /PlayerID4=0/)
      assert_requested(:get, /PlayerID5=0/)
    end

    private

    def response
      {resultSets: [{name: "PlayersVsPlayers", headers: [], rowSet: []}]}
    end
  end
end
