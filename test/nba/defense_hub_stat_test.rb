require_relative "../test_helper"

module NBA
  class DefenseHubStatTest < Minitest::Test
    cover DefenseHubStat

    def test_rank
      stat = DefenseHubStat.new(rank: 1)

      assert_equal 1, stat.rank
    end

    def test_team_id
      stat = DefenseHubStat.new(team_id: Team::BOS)

      assert_equal Team::BOS, stat.team_id
    end

    def test_team_abbreviation
      stat = DefenseHubStat.new(team_abbreviation: "BOS")

      assert_equal "BOS", stat.team_abbreviation
    end

    def test_team_name
      stat = DefenseHubStat.new(team_name: "Boston Celtics")

      assert_equal "Boston Celtics", stat.team_name
    end

    def test_value
      stat = DefenseHubStat.new(value: 47.8)

      assert_in_delta 47.8, stat.value
    end

    def test_stat_name
      stat = DefenseHubStat.new(stat_name: "dreb")

      assert_equal "dreb", stat.stat_name
    end

    def test_equality
      stat1 = DefenseHubStat.new(rank: 1, team_id: Team::BOS)
      stat2 = DefenseHubStat.new(rank: 1, team_id: Team::BOS)

      assert_equal stat1, stat2
    end

    def test_inequality_different_rank
      stat1 = DefenseHubStat.new(rank: 1, team_id: Team::BOS)
      stat2 = DefenseHubStat.new(rank: 2, team_id: Team::BOS)

      refute_equal stat1, stat2
    end

    def test_inequality_different_team
      stat1 = DefenseHubStat.new(rank: 1, team_id: Team::BOS)
      stat2 = DefenseHubStat.new(rank: 1, team_id: Team::LAL)

      refute_equal stat1, stat2
    end
  end
end
