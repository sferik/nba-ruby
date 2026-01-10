require_relative "../test_helper"

module NBA
  module BoxScoreSummaryV3BaseTestHelpers
    private

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State", teamTricode: "GSW", teamSlug: "warriors",
       teamWins: 1, teamLosses: 0, score: 118, periods: [{period: 1, score: 28}, {period: 2, score: 32},
         {period: 3, score: 25}, {period: 4, score: 33}]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles", teamTricode: "LAL", teamSlug: "lakers",
       teamWins: 0, teamLosses: 1, score: 109, periods: [{period: 1, score: 25}, {period: 2, score: 28},
         {period: 3, score: 30}, {period: 4, score: 26}]}
    end

    def arena_data
      {arenaId: 10, arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       arenaCountry: "US", arenaTimezone: "America/Los_Angeles"}
    end

    def base_response
      {boxScoreSummary: {gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3, gameStatusText: "Final",
                         period: 4, gameClock: "PT00M00.00S", gameTimeUTC: "2024-10-23T02:00:00Z",
                         gameEt: "2024-10-22T22:00:00", duration: 138, attendance: 18_064, sellout: "1",
                         arena: arena_data, homeTeam: home_team_data, awayTeam: away_team_data,
                         leadChanges: 12, timesTied: 8, largestLead: 15, officials: []}}
    end
  end
end
