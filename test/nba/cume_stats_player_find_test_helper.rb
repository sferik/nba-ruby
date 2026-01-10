module NBA
  # Shared test data for CumeStatsPlayerFind tests
  module CumeStatsPlayerFindTestHelper
    GAME_BY_GAME_STATS = CumeStatsPlayer::GAME_BY_GAME_STATS
    TOTAL_PLAYER_STATS = CumeStatsPlayer::TOTAL_PLAYER_STATS

    module_function

    def cume_stats_player_response
      {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row, second_game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
    end

    def game_headers
      %w[GAME_ID MATCHUP GAME_DATE VS_TEAM_ID VS_TEAM_CITY VS_TEAM_NAME MIN SEC
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS]
    end

    def game_row
      ["0022400001", "GSW vs. LAL", "2024-10-22", 1_610_612_747, "Los Angeles", "Lakers",
        35, 42, 10, 20, 0.500, 3, 8, 0.375, 7, 8, 0.875, 2, 6, 8, 5, 3, 2, 3, 1, 30]
    end

    def second_game_row
      ["0022400002", "GSW @ PHX", "2024-10-24", 1_610_612_756, "Phoenix", "Suns",
        32, 15, 8, 18, 0.444, 2, 7, 0.286, 5, 6, 0.833, 1, 5, 6, 7, 2, 1, 2, 0, 23]
    end

    def total_headers
      %w[PLAYER_ID PLAYER_NAME JERSEY_NUM SEASON GP GS ACTUAL_MINUTES ACTUAL_SECONDS
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB TOT_REB AST PF STL TOV BLK PTS
        AVG_MIN AVG_SEC AVG_FGM AVG_FGA AVG_FG3M AVG_FG3A AVG_FTM AVG_FTA AVG_OREB AVG_DREB
        AVG_TOT_REB AVG_AST AVG_PF AVG_STL AVG_TOV AVG_BLK AVG_PTS
        MAX_MIN MAX_FGM MAX_FGA MAX_FG3M MAX_FG3A MAX_FTM MAX_FTA MAX_OREB MAX_DREB MAX_REB
        MAX_AST MAX_PF MAX_STL MAX_TOV MAX_BLK MAX_PTS]
    end

    def total_row
      [201_939, "Stephen Curry", "30", "2024-25", 2, 2, 67, 57,
        18, 38, 0.474, 5, 15, 0.333, 12, 14, 0.857, 3, 11, 14, 12, 5, 3, 5, 1, 53,
        33.5, 28.5, 9.0, 19.0, 2.5, 7.5, 6.0, 7.0, 1.5, 5.5,
        7.0, 6.0, 2.5, 1.5, 2.5, 0.5, 26.5,
        35, 10, 20, 3, 8, 7, 8, 2, 6, 8,
        7, 3, 2, 3, 1, 30]
    end
  end
end
