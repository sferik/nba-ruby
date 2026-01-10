module NBA
  module TeamGameLogsTestHelper
    def stat_headers
      %w[SEASON_YEAR TEAM_ID TEAM_ABBREVIATION TEAM_NAME GAME_ID GAME_DATE MATCHUP WL MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def stat_row
      ["2024-25", Team::GSW, "GSW", "Warriors", "0022400001", "2024-10-22T00:00:00", "GSW vs. LAL", "W", 240,
        42, 88, 0.477, 15, 38, 0.395, 19, 22, 0.864, 10, 35, 45, 28, 9, 6, 14, 20, 118, 9]
    end

    def build_response_without_key(key)
      headers = stat_headers.reject { |h| h.eql?(key) }
      row_data = stat_headers.zip(stat_row).to_h
      row_data.delete(key)
      row = headers.map { |h| row_data[h] }
      {resultSets: [{name: "TeamGameLogs", headers: headers, rowSet: [row]}]}
    end

    def team_game_logs_response
      {resultSets: [{name: "TeamGameLogs", headers: stat_headers, rowSet: [stat_row]}]}
    end
  end
end
