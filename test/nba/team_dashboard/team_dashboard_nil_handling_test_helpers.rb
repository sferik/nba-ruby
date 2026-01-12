module NBA
  module TeamDashboardNilHandlingTestHelpers
    def all_headers
      %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def build_response_without(key)
      headers = all_headers.reject { |h| h == key }
      row = build_row_without(key)
      {
        resultSets: [{
          name: "OverallTeamDashboard",
          headers: headers,
          rowSet: [row]
        }]
      }
    end

    def build_row_without(key)
      full_row = ["Overall", 82, 50, 32, 0.610, 48.0, 42.5, 88.2, 0.482, 14.5, 38.8, 0.374,
        18.0, 22.5, 0.800, 10.5, 35.5, 46.0, 28.5, 13.5, 8.0, 5.5, 4.0, 19.0, 21.0, 117.5, 5.5]
      index = all_headers.index(key)
      return full_row unless index

      full_row[0...index] + full_row[(index + 1)..]
    end
  end
end
