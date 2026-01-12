require_relative "../../test_helper"

module NBA
  module BoxScoreSummaryV3GameAttrsHelper
    def full_response
      {boxScoreSummary: {gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3, gameStatusText: "Final",
                         period: 4, gameClock: "PT00M00.00S", gameTimeUTC: "2024-10-23T02:00:00Z",
                         gameEt: "2024-10-22T22:00:00", duration: 138, attendance: 18_064, sellout: "1",
                         homeTeam: {}, awayTeam: {}, officials: []}}
    end
  end
end
