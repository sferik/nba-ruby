require_relative "../test_helper"

module NBA
  class FantasyWidgetPlayerTest < Minitest::Test
    cover FantasyWidgetPlayer

    def test_player_id
      player = FantasyWidgetPlayer.new(player_id: 201_939)

      assert_equal 201_939, player.player_id
    end

    def test_player_name
      player = FantasyWidgetPlayer.new(player_name: "Stephen Curry")

      assert_equal "Stephen Curry", player.player_name
    end

    def test_player_position
      player = FantasyWidgetPlayer.new(player_position: "G")

      assert_equal "G", player.player_position
    end

    def test_team_id
      player = FantasyWidgetPlayer.new(team_id: Team::GSW)

      assert_equal Team::GSW, player.team_id
    end

    def test_team_abbreviation
      player = FantasyWidgetPlayer.new(team_abbreviation: "GSW")

      assert_equal "GSW", player.team_abbreviation
    end

    def test_fan_duel_pts
      player = FantasyWidgetPlayer.new(fan_duel_pts: 45.2)

      assert_in_delta 45.2, player.fan_duel_pts
    end

    def test_nba_fantasy_pts
      player = FantasyWidgetPlayer.new(nba_fantasy_pts: 52.8)

      assert_in_delta 52.8, player.nba_fantasy_pts
    end

    def test_equality
      player1 = FantasyWidgetPlayer.new(player_id: 201_939)
      player2 = FantasyWidgetPlayer.new(player_id: 201_939)

      assert_equal player1, player2
    end

    def test_inequality
      player1 = FantasyWidgetPlayer.new(player_id: 201_939)
      player2 = FantasyWidgetPlayer.new(player_id: 201_566)

      refute_equal player1, player2
    end
  end
end
