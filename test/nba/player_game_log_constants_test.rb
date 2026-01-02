require_relative "../test_helper"

module NBA
  class PlayerGameLogConstantsTest < Minitest::Test
    cover PlayerGameLog

    def test_regular_season_constant
      assert_equal "Regular Season", PlayerGameLog::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", PlayerGameLog::PLAYOFFS
    end
  end
end
