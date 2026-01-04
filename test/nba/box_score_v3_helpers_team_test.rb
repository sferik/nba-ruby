require_relative "../test_helper"

module NBA
  class BoxScoreV3HelpersTeamTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_team_identity_with_all_keys
      team = {"teamId" => 1_610_612_744, "teamName" => "Warriors",
              "teamTricode" => "GSW", "teamCity" => "Golden State"}

      identity = BoxScoreV3Helpers.team_identity(team, "0022400001")

      assert_equal "0022400001", identity[:game_id]
      assert_equal 1_610_612_744, identity[:team_id]
      assert_equal "Warriors", identity[:team_name]
      assert_equal "GSW", identity[:team_abbreviation]
      assert_equal "Golden State", identity[:team_city]
    end

    def test_team_identity_with_missing_team_id_key
      identity = BoxScoreV3Helpers.team_identity({}, "0022400001")

      assert_nil identity[:team_id]
    end

    def test_team_identity_with_missing_team_name_key
      identity = BoxScoreV3Helpers.team_identity({}, "0022400001")

      assert_nil identity[:team_name]
    end

    def test_team_identity_with_missing_team_tricode_key
      identity = BoxScoreV3Helpers.team_identity({}, "0022400001")

      assert_nil identity[:team_abbreviation]
    end

    def test_team_identity_with_missing_team_city_key
      identity = BoxScoreV3Helpers.team_identity({}, "0022400001")

      assert_nil identity[:team_city]
    end
  end
end
