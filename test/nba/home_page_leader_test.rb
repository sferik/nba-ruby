require_relative "../test_helper"

module NBA
  class HomePageLeaderTest < Minitest::Test
    cover HomePageLeader

    def test_rank
      leader = HomePageLeader.new(rank: 1)

      assert_equal 1, leader.rank
    end

    def test_player_id
      leader = HomePageLeader.new(player_id: 201_566)

      assert_equal 201_566, leader.player_id
    end

    def test_player
      leader = HomePageLeader.new(player: "Russell Westbrook")

      assert_equal "Russell Westbrook", leader.player
    end

    def test_team_id
      leader = HomePageLeader.new(team_id: Team::LAC)

      assert_equal Team::LAC, leader.team_id
    end

    def test_team_abbreviation
      leader = HomePageLeader.new(team_abbreviation: "LAC")

      assert_equal "LAC", leader.team_abbreviation
    end

    def test_pts
      leader = HomePageLeader.new(pts: 25.5)

      assert_in_delta 25.5, leader.pts
    end

    def test_fg_pct
      leader = HomePageLeader.new(fg_pct: 0.475)

      assert_in_delta 0.475, leader.fg_pct
    end

    def test_equality
      leader1 = HomePageLeader.new(player_id: 201_566, team_id: Team::LAC, rank: 1)
      leader2 = HomePageLeader.new(player_id: 201_566, team_id: Team::LAC, rank: 1)

      assert_equal leader1, leader2
    end

    def test_inequality_different_rank
      leader1 = HomePageLeader.new(player_id: 201_566, team_id: Team::LAC, rank: 1)
      leader2 = HomePageLeader.new(player_id: 201_566, team_id: Team::LAC, rank: 2)

      refute_equal leader1, leader2
    end
  end
end
