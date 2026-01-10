module NBA
  module CumeStatsTeamGamesTestHelper
    HEADERS = %w[MATCHUP GAME_ID].freeze
    ROW = ["LAL @ DEN", 22_300_001].freeze

    private

    def response
      {resultSets: [{name: "CumeStatsTeamGames", headers: HEADERS, rowSet: [ROW]}]}
    end
  end
end
