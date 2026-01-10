require_relative "../test_helper"

module NBA
  class ScheduleInternationalScoreTest < Minitest::Test
    cover ScheduleInternational

    def test_all_parses_away_team_score
      response_with_score = {leagueSchedule: {gameDates: [{games: [game_data_with_score]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response_with_score.to_json)

      game = ScheduleInternational.all.first

      assert_equal 105, game.away_team_score
    end

    def test_all_parses_home_team_score
      response_with_score = {leagueSchedule: {gameDates: [{games: [game_data_with_score]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response_with_score.to_json)

      game = ScheduleInternational.all.first

      assert_equal 110, game.home_team_score
    end

    def test_all_parses_multiple_broadcasters
      response_with_broadcasters = {leagueSchedule: {gameDates: [{games: [game_data_with_multiple_broadcasters]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response_with_broadcasters.to_json)

      game = ScheduleInternational.all.first

      assert_equal "TNT, ESPN", game.broadcasters
    end

    private

    def game_data_with_score
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 3, gameStatusText: "Final",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State",
                  teamTricode: "GSW", wins: 1, losses: 0, score: 110},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles",
                  teamTricode: "LAL", wins: 0, losses: 1, score: 105},
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}]}}
    end

    def game_data_with_multiple_broadcasters
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State",
                  teamTricode: "GSW", wins: 0, losses: 0, score: nil},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles",
                  teamTricode: "LAL", wins: 0, losses: 0, score: nil},
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}, {broadcasterDisplay: "ESPN"}]}}
    end
  end
end
