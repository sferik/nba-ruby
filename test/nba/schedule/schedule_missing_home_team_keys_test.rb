require_relative "../../test_helper"

module NBA
  class ScheduleMissingHomeTeamKeysTest < Minitest::Test
    cover Schedule

    def test_handles_missing_home_team_id
      assert_missing_home_team_key_returns_nil("teamId", :home_team_id)
    end

    def test_handles_missing_home_team_name
      assert_missing_home_team_key_returns_nil("teamName", :home_team_name)
    end

    def test_handles_missing_home_team_city
      assert_missing_home_team_key_returns_nil("teamCity", :home_team_city)
    end

    def test_handles_missing_home_team_tricode
      assert_missing_home_team_key_returns_nil("teamTricode", :home_team_tricode)
    end

    def test_handles_missing_home_team_wins
      assert_missing_home_team_key_returns_nil("wins", :home_team_wins)
    end

    def test_handles_missing_home_team_losses
      assert_missing_home_team_key_returns_nil("losses", :home_team_losses)
    end

    def test_handles_missing_home_team_score
      assert_missing_home_team_key_returns_nil("score", :home_team_score)
    end

    private

    def assert_missing_home_team_key_returns_nil(key, attribute)
      home_team = full_home_team_data.dup
      home_team.delete(key.to_sym)
      game = base_game_data.merge(homeTeam: home_team)
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.send(attribute), "Expected #{attribute} to be nil when homeTeam.#{key} is missing"
    end

    def full_home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State", teamTricode: "GSW", wins: 46, losses: 36, score: 112}
    end

    def base_game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
       awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
    end
  end
end
