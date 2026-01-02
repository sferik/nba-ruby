require_relative "../test_helper"

module NBA
  class TeamDetailsConstantsTest < Minitest::Test
    cover TeamDetails

    def test_team_background_constant
      assert_equal "TeamBackground", TeamDetails::TEAM_BACKGROUND
    end

    def test_team_history_constant
      assert_equal "TeamHistory", TeamDetails::TEAM_HISTORY
    end
  end
end
