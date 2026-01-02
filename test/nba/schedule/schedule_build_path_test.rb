require_relative "../../test_helper"

module NBA
  class ScheduleBuildPathTest < Minitest::Test
    cover Schedule

    def test_builds_correct_path_with_season_format
      stub_schedule_request

      Schedule.all(season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_builds_correct_path_with_league_id
      stub_schedule_request

      Schedule.all(league: "10")

      assert_requested :get, /LeagueID=10/
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: {leagueSchedule: {gameDates: []}}.to_json)
    end
  end
end
