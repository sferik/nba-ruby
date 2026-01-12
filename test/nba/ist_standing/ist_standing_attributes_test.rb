require_relative "../../test_helper"

module NBA
  class IstStandingTest < Minitest::Test
    cover IstStanding

    def test_season_id_attribute
      standing = IstStanding.new(season_id: "2023-24")

      assert_equal "2023-24", standing.season_id
    end

    def test_team_id_attribute
      standing = IstStanding.new(team_id: Team::LAL)

      assert_equal Team::LAL, standing.team_id
    end

    def test_team_city_attribute
      standing = IstStanding.new(team_city: "Los Angeles")

      assert_equal "Los Angeles", standing.team_city
    end

    def test_team_name_attribute
      standing = IstStanding.new(team_name: "Lakers")

      assert_equal "Lakers", standing.team_name
    end

    def test_team_abbreviation_attribute
      standing = IstStanding.new(team_abbreviation: "LAL")

      assert_equal "LAL", standing.team_abbreviation
    end

    def test_team_slug_attribute
      standing = IstStanding.new(team_slug: "lakers")

      assert_equal "lakers", standing.team_slug
    end

    def test_conference_attribute
      standing = IstStanding.new(conference: "West")

      assert_equal "West", standing.conference
    end

    def test_ist_group_attribute
      standing = IstStanding.new(ist_group: "West Group A")

      assert_equal "West Group A", standing.ist_group
    end

    def test_ist_group_rank_attribute
      standing = IstStanding.new(ist_group_rank: 1)

      assert_equal 1, standing.ist_group_rank
    end

    def test_wins_attribute
      standing = IstStanding.new(wins: 3)

      assert_equal 3, standing.wins
    end

    def test_losses_attribute
      standing = IstStanding.new(losses: 1)

      assert_equal 1, standing.losses
    end

    def test_win_pct_attribute
      standing = IstStanding.new(win_pct: 0.750)

      assert_in_delta 0.750, standing.win_pct
    end

    def test_pts_for_attribute
      standing = IstStanding.new(pts_for: 450)

      assert_equal 450, standing.pts_for
    end

    def test_pts_against_attribute
      standing = IstStanding.new(pts_against: 420)

      assert_equal 420, standing.pts_against
    end

    def test_pts_diff_attribute
      standing = IstStanding.new(pts_diff: 30)

      assert_equal 30, standing.pts_diff
    end

    def test_clinch_indicator_attribute
      standing = IstStanding.new(clinch_indicator: "z")

      assert_equal "z", standing.clinch_indicator
    end

    def test_equality_based_on_team_id_and_season_id
      standing1 = IstStanding.new(team_id: Team::LAL, season_id: "2023-24")
      standing2 = IstStanding.new(team_id: Team::LAL, season_id: "2023-24")

      assert_equal standing1, standing2
    end

    def test_inequality_when_different_team_id
      standing1 = IstStanding.new(team_id: Team::LAL, season_id: "2023-24")
      standing2 = IstStanding.new(team_id: Team::BOS, season_id: "2023-24")

      refute_equal standing1, standing2
    end

    def test_inequality_when_different_season_id
      standing1 = IstStanding.new(team_id: Team::LAL, season_id: "2023-24")
      standing2 = IstStanding.new(team_id: Team::LAL, season_id: "2024-25")

      refute_equal standing1, standing2
    end
  end
end
