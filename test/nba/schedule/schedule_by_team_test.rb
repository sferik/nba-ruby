require_relative "../../test_helper"

module NBA
  class ScheduleByTeamTest < Minitest::Test
    cover Schedule

    def test_by_team_returns_collection
      stub_schedule_request

      assert_instance_of Collection, Schedule.by_team(team: Team::GSW)
    end

    def test_by_team_filters_by_team_id
      stub_schedule_request

      games = Schedule.by_team(team: Team::GSW)

      assert_equal 1, games.size
    end

    def test_by_team_returns_empty_for_non_matching_team
      stub_schedule_request

      games = Schedule.by_team(team: Team::BOS)

      assert_equal 0, games.size
    end

    def test_by_team_accepts_team_object
      stub_schedule_request
      team = Team.new(id: Team::GSW)

      games = Schedule.by_team(team: team)

      assert_equal 1, games.size
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: schedule_response.to_json)
    end

    def schedule_response
      {leagueSchedule: {gameDates: [
        {gameDate: "2024-10-22", games: [game_data]}
      ]}}
    end

    def game_data
      {
        gameDateTimeUTC: "2024-10-22T19:00:00Z",
        gameId: "0022400001",
        homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
        awayTeam: {teamId: Team::LAL, teamName: "Lakers"}
      }
    end
  end
end
