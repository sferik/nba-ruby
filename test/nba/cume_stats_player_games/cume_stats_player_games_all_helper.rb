require_relative "../../test_helper"

module NBA
  module CumeStatsPlayerGamesAllHelper
    HEADERS = %w[MATCHUP GAME_ID].freeze
    ROW = ["GSW vs. LAL", "0022400001"].freeze

    def response
      {resultSets: [{name: "CumeStatsPlayerGames", headers: HEADERS, rowSet: [ROW]}]}
    end
  end
end
