require_relative "../test_helper"

module NBA
  class LeagueTest < Minitest::Test
    cover League

    def test_nba_constant
      assert_equal "00", League::NBA
    end

    def test_wnba_constant
      assert_equal "10", League::WNBA
    end

    def test_g_league_constant
      assert_equal "20", League::G_LEAGUE
    end

    def test_league_has_id
      league = League.new(id: "00", name: "NBA")

      assert_equal "00", league.id
    end

    def test_league_has_name
      league = League.new(id: "00", name: "NBA")

      assert_equal "NBA", league.name
    end

    def test_league_equality_based_on_id
      league1 = League.new(id: "00", name: "NBA")
      league2 = League.new(id: "00", name: "Different Name")

      assert_equal league1, league2
    end

    def test_league_inequality_with_different_id
      league1 = League.new(id: "00", name: "NBA")
      league2 = League.new(id: "10", name: "NBA")

      refute_equal league1, league2
    end
  end
end
