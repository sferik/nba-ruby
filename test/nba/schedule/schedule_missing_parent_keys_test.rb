require_relative "../../test_helper"

module NBA
  class ScheduleMissingParentKeysTest < Minitest::Test
    cover Schedule

    def test_handles_missing_home_team_key
      game = {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
              awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.home_team_id
      assert_nil scheduled_game.home_team_name
    end

    def test_handles_nil_home_team_value
      game = {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
              homeTeam: nil,
              awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.home_team_id
      assert_nil scheduled_game.home_team_name
    end

    def test_handles_missing_away_team_key
      game = {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
              homeTeam: {teamId: Team::GSW, teamName: "Warriors"}}
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.away_team_id
      assert_nil scheduled_game.away_team_name
    end

    def test_handles_nil_away_team_value
      game = {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
              homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
              awayTeam: nil}
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.away_team_id
      assert_nil scheduled_game.away_team_name
    end

    def test_handles_missing_broadcasters_key
      game = {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
              homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
              awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.broadcasters
    end

    def test_handles_missing_games_key_in_date_entry
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22"}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      games = Schedule.all

      assert_equal 0, games.size
    end
  end
end
