require_relative "../../test_helper"

module NBA
  class ScheduleDateFormatTest < Minitest::Test
    cover Schedule

    def test_by_date_uses_specific_date_format
      # Date.strftime without arguments returns different format than "%Y-%m-%d"
      # Default strftime returns "2024-10-22" but we need to ensure exact format is used
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_data]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      # The game date "2024-10-22T19:00:00Z" should match date 2024-10-22
      games = Schedule.by_date(date: Date.new(2024, 10, 22))

      assert_equal 1, games.size
    end

    def test_by_date_format_matches_game_date_prefix
      # Test that the YYYY-MM-DD format is correctly matching game dates
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_data]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      # This should NOT match because date is different
      games = Schedule.by_date(date: Date.new(2024, 10, 23))

      assert_equal 0, games.size
    end

    private

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
    end
  end
end
