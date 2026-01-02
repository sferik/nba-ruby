require_relative "../../test_helper"

module NBA
  class ScheduleMissingVenueKeysTest < Minitest::Test
    cover Schedule

    def test_handles_missing_arena_name
      assert_missing_venue_key_returns_nil("arenaName", :arena_name)
    end

    def test_handles_missing_arena_city
      assert_missing_venue_key_returns_nil("arenaCity", :arena_city)
    end

    def test_handles_missing_arena_state
      assert_missing_venue_key_returns_nil("arenaState", :arena_state)
    end

    private

    def assert_missing_venue_key_returns_nil(key, attribute)
      game = full_game_data.dup
      game.delete(key.to_sym)
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def full_game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers"},
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA"}
    end
  end
end
