require_relative "../../test_helper"

module NBA
  class ScheduleClientPassThroughTest < Minitest::Test
    cover Schedule

    def test_by_team_passes_client_to_all
      mock_client = Minitest::Mock.new
      mock_client.expect :get, schedule_response.to_json, [String]

      Schedule.by_team(team: Team::GSW, client: mock_client)

      mock_client.verify
    end

    def test_by_date_passes_client_to_all
      mock_client = Minitest::Mock.new
      mock_client.expect :get, schedule_response.to_json, [String]

      Schedule.by_date(date: Date.new(2024, 10, 22), client: mock_client)

      mock_client.verify
    end

    private

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
