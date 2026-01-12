require_relative "../../test_helper"

module NBA
  class DunkScoreLeaderTest < Minitest::Test
    cover DunkScoreLeader

    def test_equality_based_on_player_id_and_rank
      leader1 = DunkScoreLeader.new(player_id: 1_631_094, rank: 1)
      leader2 = DunkScoreLeader.new(player_id: 1_631_094, rank: 1)

      assert_equal leader1, leader2
    end

    def test_inequality_when_player_id_differs
      leader1 = DunkScoreLeader.new(player_id: 1_631_094, rank: 1)
      leader2 = DunkScoreLeader.new(player_id: 1_631_095, rank: 1)

      refute_equal leader1, leader2
    end

    def test_inequality_when_rank_differs
      leader1 = DunkScoreLeader.new(player_id: 1_631_094, rank: 1)
      leader2 = DunkScoreLeader.new(player_id: 1_631_094, rank: 2)

      refute_equal leader1, leader2
    end

    def test_player_id_attribute
      leader = DunkScoreLeader.new(player_id: 1_631_094)

      assert_equal 1_631_094, leader.player_id
    end

    def test_player_name_attribute
      leader = DunkScoreLeader.new(player_name: "Paolo Banchero")

      assert_equal "Paolo Banchero", leader.player_name
    end

    def test_team_id_attribute
      leader = DunkScoreLeader.new(team_id: Team::ORL)

      assert_equal Team::ORL, leader.team_id
    end

    def test_team_abbreviation_attribute
      leader = DunkScoreLeader.new(team_abbreviation: "ORL")

      assert_equal "ORL", leader.team_abbreviation
    end

    def test_rank_attribute
      leader = DunkScoreLeader.new(rank: 1)

      assert_equal 1, leader.rank
    end

    def test_dunk_score_attribute
      leader = DunkScoreLeader.new(dunk_score: 85.5)

      assert_in_delta 85.5, leader.dunk_score
    end
  end
end
