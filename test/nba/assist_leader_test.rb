require_relative "../test_helper"

module NBA
  class AssistLeaderTest < Minitest::Test
    cover AssistLeader

    def test_player_id_attribute
      leader = AssistLeader.new(player_id: 201_566)

      assert_equal 201_566, leader.player_id
    end

    def test_player_name_attribute
      leader = AssistLeader.new(player_name: "Russell Westbrook")

      assert_equal "Russell Westbrook", leader.player_name
    end

    def test_team_id_attribute
      leader = AssistLeader.new(team_id: Team::LAC)

      assert_equal Team::LAC, leader.team_id
    end

    def test_team_abbreviation_attribute
      leader = AssistLeader.new(team_abbreviation: "LAC")

      assert_equal "LAC", leader.team_abbreviation
    end

    def test_rank_attribute
      leader = AssistLeader.new(rank: 1)

      assert_equal 1, leader.rank
    end

    def test_ast_attribute
      leader = AssistLeader.new(ast: 654)

      assert_equal 654, leader.ast
    end

    def test_equality_based_on_player_id_and_rank
      leader1 = AssistLeader.new(player_id: 201_566, rank: 1)
      leader2 = AssistLeader.new(player_id: 201_566, rank: 1)

      assert_equal leader1, leader2
    end

    def test_inequality_when_different_player_id
      leader1 = AssistLeader.new(player_id: 201_566, rank: 1)
      leader2 = AssistLeader.new(player_id: 201_939, rank: 1)

      refute_equal leader1, leader2
    end

    def test_inequality_when_different_rank
      leader1 = AssistLeader.new(player_id: 201_566, rank: 1)
      leader2 = AssistLeader.new(player_id: 201_566, rank: 2)

      refute_equal leader1, leader2
    end
  end
end
