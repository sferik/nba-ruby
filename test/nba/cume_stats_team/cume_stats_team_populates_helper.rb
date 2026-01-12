require_relative "../../test_helper"

module NBA
  module CumeStatsTeamPopulatesHelper
    GAME_BY_GAME_HEADERS = %w[
      PERSON_ID PLAYER_NAME JERSEY_NUM TEAM_ID GP GS ACTUAL_MINUTES ACTUAL_SECONDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
      OREB DREB TOT_REB AST PF STL TOV BLK PTS
      AVG_MINUTES FGM_PG FGA_PG FG3M_PG FG3A_PG FTM_PG FTA_PG
      OREB_PG DREB_PG REB_PG AST_PG PF_PG STL_PG TOV_PG BLK_PG PTS_PG
      FGM_PER_MIN FGA_PER_MIN FG3M_PER_MIN FG3A_PER_MIN FTM_PER_MIN FTA_PER_MIN
      OREB_PER_MIN DREB_PER_MIN REB_PER_MIN AST_PER_MIN PF_PER_MIN STL_PER_MIN
      TOV_PER_MIN BLK_PER_MIN PTS_PER_MIN
    ].freeze

    GAME_BY_GAME_ROW = [
      201_939, "Stephen Curry", "30", Team::GSW, 10, 10, 350, 21_000,
      100, 200, 0.500, 40, 100, 0.400, 80, 90, 0.889,
      10, 50, 60, 70, 20, 15, 25, 5, 280,
      35.0, 10.0, 20.0, 4.0, 10.0, 8.0, 9.0,
      1.0, 5.0, 6.0, 7.0, 2.0, 1.5, 2.5, 0.5, 28.0,
      0.286, 0.571, 0.114, 0.286, 0.229, 0.257,
      0.029, 0.143, 0.171, 0.200, 0.057, 0.043,
      0.071, 0.014, 0.800
    ].freeze

    TOTAL_TEAM_HEADERS = %w[
      TEAM_ID CITY NICKNAME GP GS W L W_HOME L_HOME W_ROAD L_ROAD
      TEAM_TURNOVERS TEAM_REBOUNDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
      OREB DREB TOT_REB AST PF STL TOV BLK PTS
    ].freeze

    TOTAL_TEAM_ROW = [
      Team::GSW, "Golden State", "Warriors", 10, 10, 8, 2, 5, 1, 3, 1,
      120, 450,
      400, 850, 0.471, 150, 400, 0.375, 180, 220, 0.818,
      100, 350, 450, 250, 180, 80, 120, 45, 1130
    ].freeze

    def response
      {resultSets: [
        {name: "GameByGameStats", headers: GAME_BY_GAME_HEADERS, rowSet: [GAME_BY_GAME_ROW]},
        {name: "TotalTeamStats", headers: TOTAL_TEAM_HEADERS, rowSet: [TOTAL_TEAM_ROW]}
      ]}
    end

    def find_result
      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)
    end
  end
end
