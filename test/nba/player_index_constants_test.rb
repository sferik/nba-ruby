require_relative "../test_helper"

module NBA
  class PlayerIndexConstantsTest < Minitest::Test
    cover PlayerIndex

    def test_result_set_name_constant
      assert_equal "PlayerIndex", PlayerIndex::RESULT_SET_NAME
    end

    def test_historical_constant
      assert_equal 1, PlayerIndex::HISTORICAL
    end

    def test_current_constant
      assert_equal 0, PlayerIndex::CURRENT
    end
  end
end
