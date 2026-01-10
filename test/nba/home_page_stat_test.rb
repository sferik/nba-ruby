require_relative "../test_helper"

module NBA
  class HomePageStatTest < Minitest::Test
    cover HomePageStat

    def test_rank
      stat = HomePageStat.new(rank: 1)

      assert_equal 1, stat.rank
    end

    def test_team_id
      stat = HomePageStat.new(team_id: Team::BOS)

      assert_equal Team::BOS, stat.team_id
    end

    def test_team_abbreviation
      stat = HomePageStat.new(team_abbreviation: "BOS")

      assert_equal "BOS", stat.team_abbreviation
    end

    def test_team_name
      stat = HomePageStat.new(team_name: "Boston Celtics")

      assert_equal "Boston Celtics", stat.team_name
    end

    def test_value
      stat = HomePageStat.new(value: 120.5)

      assert_in_delta 120.5, stat.value
    end

    def test_stat_name
      stat = HomePageStat.new(stat_name: "pts")

      assert_equal "pts", stat.stat_name
    end

    def test_equality
      stat1 = HomePageStat.new(rank: 1, team_id: Team::BOS)
      stat2 = HomePageStat.new(rank: 1, team_id: Team::BOS)

      assert_equal stat1, stat2
    end

    def test_inequality_different_rank
      stat1 = HomePageStat.new(rank: 1, team_id: Team::BOS)
      stat2 = HomePageStat.new(rank: 2, team_id: Team::BOS)

      refute_equal stat1, stat2
    end
  end
end
