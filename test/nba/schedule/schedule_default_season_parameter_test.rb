require_relative "../../test_helper"

module NBA
  class ScheduleDefaultSeasonParameterTest < Minitest::Test
    cover Schedule

    def test_by_team_uses_default_season_from_utils
      stub_schedule_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      Schedule.by_team(team: Team::GSW)

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_by_date_uses_default_season_from_utils
      stub_schedule_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      Schedule.by_date(date: Date.new(2024, 10, 22))

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_all_uses_default_season_from_utils
      stub_schedule_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      Schedule.all

      assert_requested :get, /Season=#{expected_str}/
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: {leagueSchedule: {gameDates: []}}.to_json)
    end
  end
end
