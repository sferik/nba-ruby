require_relative "../test_helper"

module NBA
  class ScheduleInternationalParametersTest < Minitest::Test
    cover ScheduleInternational

    def test_all_with_custom_season
      stub_request(:get, /scheduleleaguev2int.*Season=2022-23/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.all(season: 2022)

      assert_requested :get, /scheduleleaguev2int.*Season=2022-23/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /scheduleleaguev2int.*LeagueID=00/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.all(league: league)

      assert_requested :get, /scheduleleaguev2int.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /scheduleleaguev2int.*LeagueID=00/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.all(league: "00")

      assert_requested :get, /scheduleleaguev2int.*LeagueID=00/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /scheduleleaguev2int.*LeagueID=00/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.all

      assert_requested :get, /scheduleleaguev2int.*LeagueID=00/
    end

    private

    def schedule_international_response
      {leagueSchedule: {gameDates: [{games: [game_data]}]}}
    end

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State",
                  teamTricode: "GSW", wins: 0, losses: 0, score: nil},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles",
                  teamTricode: "LAL", wins: 0, losses: 0, score: nil},
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}]}}
    end
  end
end
