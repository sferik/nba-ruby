require_relative "../../test_helper"

module NBA
  class ScheduleMissingAwayTeamKeysTest < Minitest::Test
    cover Schedule

    def test_handles_missing_away_team_id
      assert_missing_away_team_key_returns_nil("teamId", :away_team_id)
    end

    def test_handles_missing_away_team_name
      assert_missing_away_team_key_returns_nil("teamName", :away_team_name)
    end

    def test_handles_missing_away_team_city
      assert_missing_away_team_key_returns_nil("teamCity", :away_team_city)
    end

    def test_handles_missing_away_team_tricode
      assert_missing_away_team_key_returns_nil("teamTricode", :away_team_tricode)
    end

    def test_handles_missing_away_team_wins
      assert_missing_away_team_key_returns_nil("wins", :away_team_wins)
    end

    def test_handles_missing_away_team_losses
      assert_missing_away_team_key_returns_nil("losses", :away_team_losses)
    end

    def test_handles_missing_away_team_score
      assert_missing_away_team_key_returns_nil("score", :away_team_score)
    end

    private

    def assert_missing_away_team_key_returns_nil(key, attribute)
      away_team = full_away_team_data.dup
      away_team.delete(key.to_sym)
      game = base_game_data.merge(awayTeam: away_team)
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.send(attribute), "Expected #{attribute} to be nil when awayTeam.#{key} is missing"
    end

    def full_away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles", teamTricode: "LAL", wins: 43, losses: 39, score: 108}
    end

    def base_game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors"}}
    end
  end
end
