require_relative "../test_helper"

module NBA
  class PlayByPlayConstantsTest < Minitest::Test
    cover PlayByPlay

    def test_result_set_name_constant
      assert_equal "PlayByPlay", PlayByPlay::RESULT_SET_NAME
    end
  end
end
