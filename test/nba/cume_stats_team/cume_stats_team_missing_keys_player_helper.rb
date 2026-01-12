require_relative "../../test_helper"

module NBA
  module CumeStatsTeamMissingKeysPlayerHelper
    ALL_HEADERS = %w[PERSON_ID PLAYER_NAME JERSEY_NUM TEAM_ID GP GS ACTUAL_MINUTES ACTUAL_SECONDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
      OREB DREB TOT_REB AST PF STL TOV BLK PTS
      AVG_MINUTES FGM_PG FGA_PG FG3M_PG FG3A_PG FTM_PG FTA_PG
      OREB_PG DREB_PG REB_PG AST_PG PF_PG STL_PG TOV_PG BLK_PG PTS_PG
      FGM_PER_MIN FGA_PER_MIN FG3M_PER_MIN FG3A_PER_MIN FTM_PER_MIN FTA_PER_MIN
      OREB_PER_MIN DREB_PER_MIN REB_PER_MIN AST_PER_MIN PF_PER_MIN STL_PER_MIN
      TOV_PER_MIN BLK_PER_MIN PTS_PER_MIN].freeze

    ALL_VALUES = {
      "PERSON_ID" => 201_939, "PLAYER_NAME" => "Stephen Curry", "JERSEY_NUM" => "30",
      "TEAM_ID" => Team::GSW, "GP" => 10, "GS" => 10, "ACTUAL_MINUTES" => 350, "ACTUAL_SECONDS" => 21_000,
      "FGM" => 100, "FGA" => 200, "FG_PCT" => 0.500, "FG3M" => 40, "FG3A" => 100, "FG3_PCT" => 0.400,
      "FTM" => 80, "FTA" => 90, "FT_PCT" => 0.889, "OREB" => 10, "DREB" => 50, "TOT_REB" => 60,
      "AST" => 70, "PF" => 20, "STL" => 15, "TOV" => 25, "BLK" => 5, "PTS" => 280,
      "AVG_MINUTES" => 35.0, "FGM_PG" => 10.0, "FGA_PG" => 20.0, "FG3M_PG" => 4.0, "FG3A_PG" => 10.0,
      "FTM_PG" => 8.0, "FTA_PG" => 9.0, "OREB_PG" => 1.0, "DREB_PG" => 5.0, "REB_PG" => 6.0,
      "AST_PG" => 7.0, "PF_PG" => 2.0, "STL_PG" => 1.5, "TOV_PG" => 2.5, "BLK_PG" => 0.5, "PTS_PG" => 28.0,
      "FGM_PER_MIN" => 0.286, "FGA_PER_MIN" => 0.571, "FG3M_PER_MIN" => 0.114, "FG3A_PER_MIN" => 0.286,
      "FTM_PER_MIN" => 0.229, "FTA_PER_MIN" => 0.257, "OREB_PER_MIN" => 0.029, "DREB_PER_MIN" => 0.143,
      "REB_PER_MIN" => 0.171, "AST_PER_MIN" => 0.200, "PF_PER_MIN" => 0.057, "STL_PER_MIN" => 0.043,
      "TOV_PER_MIN" => 0.071, "BLK_PER_MIN" => 0.014, "PTS_PER_MIN" => 0.800
    }.freeze

    def all_headers = ALL_HEADERS
    def all_values = ALL_VALUES

    def build_row_without(key)
      all_headers.reject { |h| h.eql?(key) }.map { |h| all_values[h] }
    end

    def build_response(headers, row)
      {resultSets: [
        {name: "GameByGameStats", headers: headers, rowSet: [row]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: [[Team::GSW]]}
      ]}
    end

    def find_result
      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)
    end
  end
end
