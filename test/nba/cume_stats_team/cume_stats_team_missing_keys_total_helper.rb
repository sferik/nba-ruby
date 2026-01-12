require_relative "../../test_helper"

module NBA
  module CumeStatsTeamMissingKeysTotalHelper
    ALL_HEADERS = %w[TEAM_ID CITY NICKNAME GP GS W L W_HOME L_HOME W_ROAD L_ROAD
      TEAM_TURNOVERS TEAM_REBOUNDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
      OREB DREB TOT_REB AST PF STL TOV BLK PTS].freeze

    ALL_VALUES = {
      "TEAM_ID" => Team::GSW, "CITY" => "Golden State", "NICKNAME" => "Warriors",
      "GP" => 10, "GS" => 10, "W" => 8, "L" => 2, "W_HOME" => 5, "L_HOME" => 1,
      "W_ROAD" => 3, "L_ROAD" => 1, "TEAM_TURNOVERS" => 120, "TEAM_REBOUNDS" => 450,
      "FGM" => 400, "FGA" => 850, "FG_PCT" => 0.471, "FG3M" => 150, "FG3A" => 400,
      "FG3_PCT" => 0.375, "FTM" => 180, "FTA" => 220, "FT_PCT" => 0.818,
      "OREB" => 100, "DREB" => 350, "TOT_REB" => 450, "AST" => 250, "PF" => 180,
      "STL" => 80, "TOV" => 120, "BLK" => 45, "PTS" => 1130
    }.freeze

    def all_headers = ALL_HEADERS
    def all_values = ALL_VALUES

    def build_row_without(key)
      all_headers.reject { |h| h.eql?(key) }.map { |h| all_values[h] }
    end

    def build_response(headers, row)
      {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: headers, rowSet: [row]}
      ]}
    end

    def find_result
      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)
    end
  end
end
