require_relative "../../test_helper"

module NBA
  class ScheduleByDateParameterPassingTest < Minitest::Test
    cover Schedule

    def test_by_date_passes_season_parameter
      stub_schedule_request

      Schedule.by_date(date: Date.new(2024, 10, 22), season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_by_date_passes_league_id_parameter
      stub_schedule_request

      Schedule.by_date(date: Date.new(2024, 10, 22), league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_by_date_uses_default_league_id
      stub_schedule_request

      Schedule.by_date(date: Date.new(2024, 10, 22))

      assert_requested :get, /LeagueID=00/
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: {leagueSchedule: {gameDates: []}}.to_json)
    end
  end
end
