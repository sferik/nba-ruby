require_relative "../../test_helper"

module NBA
  class ScheduleByDateFilteringTest < Minitest::Test
    cover Schedule

    def test_by_date_filters_by_date_string_start_with
      stub_schedule_request

      games = Schedule.by_date(date: Date.new(2024, 10, 22))

      assert_equal 1, games.size
    end

    def test_by_date_returns_empty_when_no_matching_date
      stub_schedule_request

      games = Schedule.by_date(date: Date.new(2024, 10, 23))

      assert_equal 0, games.size
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: schedule_response.to_json)
    end

    def schedule_response
      {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_data]}]}}
    end

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
    end
  end
end
