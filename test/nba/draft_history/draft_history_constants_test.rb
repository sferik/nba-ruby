require_relative "../../test_helper"

module NBA
  class DraftHistoryConstantsTest < Minitest::Test
    cover DraftHistory

    def test_draft_history_constant
      assert_equal "DraftHistory", DraftHistory::DRAFT_HISTORY
    end
  end
end
