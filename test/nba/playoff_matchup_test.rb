require_relative "../test_helper"

module NBA
  class PlayoffMatchupTest < Minitest::Test
    cover PlayoffMatchup

    def test_conference
      matchup = PlayoffMatchup.new(conference: "East")

      assert_equal "East", matchup.conference
    end

    def test_high_seed_rank
      matchup = PlayoffMatchup.new(high_seed_rank: 1)

      assert_equal 1, matchup.high_seed_rank
    end

    def test_high_seed_team
      matchup = PlayoffMatchup.new(high_seed_team: "Boston Celtics")

      assert_equal "Boston Celtics", matchup.high_seed_team
    end

    def test_high_seed_team_id
      matchup = PlayoffMatchup.new(high_seed_team_id: Team::BOS)

      assert_equal Team::BOS, matchup.high_seed_team_id
    end

    def test_low_seed_rank
      matchup = PlayoffMatchup.new(low_seed_rank: 8)

      assert_equal 8, matchup.low_seed_rank
    end

    def test_low_seed_team
      matchup = PlayoffMatchup.new(low_seed_team: "Miami Heat")

      assert_equal "Miami Heat", matchup.low_seed_team
    end

    def test_low_seed_team_id
      matchup = PlayoffMatchup.new(low_seed_team_id: Team::MIA)

      assert_equal Team::MIA, matchup.low_seed_team_id
    end

    def test_high_seed_series_wins
      matchup = PlayoffMatchup.new(high_seed_series_wins: 4)

      assert_equal 4, matchup.high_seed_series_wins
    end

    def test_low_seed_series_wins
      matchup = PlayoffMatchup.new(low_seed_series_wins: 1)

      assert_equal 1, matchup.low_seed_series_wins
    end

    def test_series_status
      matchup = PlayoffMatchup.new(series_status: "Celtics lead 4-1")

      assert_equal "Celtics lead 4-1", matchup.series_status
    end

    def test_equality_with_same_attributes
      matchup1 = PlayoffMatchup.new(conference: "East", high_seed_team_id: Team::BOS, low_seed_team_id: Team::MIA)
      matchup2 = PlayoffMatchup.new(conference: "East", high_seed_team_id: Team::BOS, low_seed_team_id: Team::MIA)

      assert_equal matchup1, matchup2
    end

    def test_equality_with_different_conference
      matchup1 = PlayoffMatchup.new(conference: "East", high_seed_team_id: Team::BOS, low_seed_team_id: Team::MIA)
      matchup2 = PlayoffMatchup.new(conference: "West", high_seed_team_id: Team::BOS, low_seed_team_id: Team::MIA)

      refute_equal matchup1, matchup2
    end

    def test_equality_with_different_high_seed
      matchup1 = PlayoffMatchup.new(conference: "East", high_seed_team_id: Team::BOS, low_seed_team_id: Team::MIA)
      matchup2 = PlayoffMatchup.new(conference: "East", high_seed_team_id: Team::NYK, low_seed_team_id: Team::MIA)

      refute_equal matchup1, matchup2
    end
  end
end
