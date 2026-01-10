require_relative "../test_helper"

module NBA
  class LeadersTileTest < Minitest::Test
    cover LeadersTile

    def test_rank
      tile = LeadersTile.new(rank: 1)

      assert_equal 1, tile.rank
    end

    def test_team_id
      tile = LeadersTile.new(team_id: Team::BOS)

      assert_equal Team::BOS, tile.team_id
    end

    def test_team_abbreviation
      tile = LeadersTile.new(team_abbreviation: "BOS")

      assert_equal "BOS", tile.team_abbreviation
    end

    def test_team_name
      tile = LeadersTile.new(team_name: "Boston Celtics")

      assert_equal "Boston Celtics", tile.team_name
    end

    def test_pts
      tile = LeadersTile.new(pts: 120.5)

      assert_in_delta 120.5, tile.pts
    end

    def test_season_year
      tile = LeadersTile.new(season_year: "2023-24")

      assert_equal "2023-24", tile.season_year
    end

    def test_equality
      tile1 = LeadersTile.new(rank: 1, team_id: Team::BOS)
      tile2 = LeadersTile.new(rank: 1, team_id: Team::BOS)

      assert_equal tile1, tile2
    end

    def test_inequality_different_rank
      tile1 = LeadersTile.new(rank: 1, team_id: Team::BOS)
      tile2 = LeadersTile.new(rank: 2, team_id: Team::BOS)

      refute_equal tile1, tile2
    end
  end
end
