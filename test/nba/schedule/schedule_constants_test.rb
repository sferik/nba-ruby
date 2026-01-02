require_relative "../../test_helper"

module NBA
  class ScheduleConstantsTest < Minitest::Test
    cover Schedule

    def test_league_schedule_constant
      assert_equal "LeagueSchedule", Schedule::LEAGUE_SCHEDULE
    end
  end
end
