require_relative "../test_helper"

module NBA
  class FranchiseHistoryConstantsTest < Minitest::Test
    cover FranchiseHistory

    def test_franchise_history_constant
      assert_equal "FranchiseHistory", FranchiseHistory::FRANCHISE_HISTORY
    end

    def test_defunct_teams_constant
      assert_equal "DefunctTeams", FranchiseHistory::DEFUNCT_TEAMS
    end
  end
end
