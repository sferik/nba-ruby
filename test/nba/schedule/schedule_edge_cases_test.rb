require_relative "../../test_helper"

module NBA
  class ScheduleEdgeCasesTest < Minitest::Test
    cover Schedule

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Schedule.all(client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_game_dates
      stub_request(:get, /scheduleleaguev2/).to_return(body: {leagueSchedule: {gameDates: nil}}.to_json)

      assert_equal 0, Schedule.all.size
    end

    def test_returns_empty_when_league_schedule_missing
      stub_request(:get, /scheduleleaguev2/).to_return(body: {}.to_json)

      assert_equal 0, Schedule.all.size
    end

    def test_handles_date_entry_with_no_games
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: nil}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      assert_equal 0, Schedule.all.size
    end

    def test_by_date_handles_nil_game_date
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_with_nil_date]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      games = Schedule.by_date(date: Date.new(2024, 10, 22))

      assert_equal 0, games.size
    end

    def test_handles_empty_broadcasters
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_with_empty_broadcasters]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      games = Schedule.all

      assert_equal 1, games.size
      assert_nil games.first.broadcasters
    end

    def test_handles_nil_national_tv_broadcasters
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_with_nil_national_broadcasters]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      games = Schedule.all

      assert_equal 1, games.size
      assert_nil games.first.broadcasters
    end

    private

    def game_with_nil_date
      {
        gameDateTimeUTC: nil,
        gameId: "0022400001",
        homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
        awayTeam: {teamId: Team::LAL, teamName: "Lakers"}
      }
    end

    def game_with_empty_broadcasters
      {
        gameDateTimeUTC: "2024-10-22T19:00:00Z",
        gameId: "0022400001",
        homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
        awayTeam: {teamId: Team::LAL, teamName: "Lakers"},
        broadcasters: {nationalTvBroadcasters: []}
      }
    end

    def game_with_nil_national_broadcasters
      {
        gameDateTimeUTC: "2024-10-22T19:00:00Z",
        gameId: "0022400001",
        homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
        awayTeam: {teamId: Team::LAL, teamName: "Lakers"},
        broadcasters: {nationalTvBroadcasters: nil}
      }
    end
  end
end
