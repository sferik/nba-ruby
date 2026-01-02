require_relative "../test_helper"

module NBA
  class GameRotationConstantsTest < Minitest::Test
    cover GameRotation

    def test_home_team_constant
      assert_equal "HomeTeam", GameRotation::HOME_TEAM
    end

    def test_away_team_constant
      assert_equal "AwayTeam", GameRotation::AWAY_TEAM
    end
  end
end
