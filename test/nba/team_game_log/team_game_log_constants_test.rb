require_relative "../../test_helper"

module NBA
  class TeamGameLogConstantsTest < Minitest::Test
    cover TeamGameLog

    def test_regular_season_constant
      assert_equal "Regular Season", TeamGameLog::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", TeamGameLog::PLAYOFFS
    end
  end
end
