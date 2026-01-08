require_relative "../test_helper"

module NBA
  class TeamAndPlayersVsPlayersResultSetTest < Minitest::Test
    cover TeamAndPlayersVsPlayers

    def test_finds_correct_result_set_with_multiple_present
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: multi_response.to_json)

      result = TeamAndPlayersVsPlayers.players_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
      assert_equal 201_939, result.first.player_id
    end

    def test_team_players_off_finds_correct_result_set_with_multiple_present
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: multi_response.to_json)

      result = TeamAndPlayersVsPlayers.team_players_vs_players_off(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
      assert_equal 201_142, result.first.player_id
    end

    def test_team_players_on_finds_correct_result_set_with_multiple_present
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: multi_response.to_json)

      result = TeamAndPlayersVsPlayers.team_players_vs_players_on(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
      assert_equal 203_110, result.first.player_id
    end

    def test_team_vs_players_finds_correct_result_set_with_multiple_present
      stub_request(:get, /teamandplayersvsplayers/).to_return(body: multi_response.to_json)

      result = TeamAndPlayersVsPlayers.team_vs_players(
        team: 1_610_612_744, vs_team: 1_610_612_747, players: [201_939], vs_players: [2544]
      )

      assert_equal 1, result.size
      assert_equal 203_507, result.first.player_id
    end

    private

    def multi_response
      {resultSets: [
        {name: "PlayersVsPlayers", headers: headers, rowSet: [row(201_939)]},
        {name: "TeamPlayersVsPlayersOff", headers: headers, rowSet: [row(201_142)]},
        {name: "TeamPlayersVsPlayersOn", headers: headers, rowSet: [row(203_110)]},
        {name: "TeamVsPlayers", headers: headers, rowSet: [row(203_507)]}
      ]}
    end

    def row(player_id)
      [1_610_612_744, player_id, 2544, "P1", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]
    end

    def headers
      %w[TEAM_ID PLAYER_ID VS_PLAYER_ID PLAYER_NAME GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end
  end
end
