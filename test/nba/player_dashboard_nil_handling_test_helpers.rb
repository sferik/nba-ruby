module NBA
  module PlayerDashboardNilHandlingTestHelpers
    def all_headers
      %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def build_response_without(key)
      headers = all_headers.reject { |h| h == key }
      row = build_row_without(key)
      {
        resultSets: [{
          name: "OverallPlayerDashboard",
          headers: headers,
          rowSet: [row]
        }]
      }
    end

    def build_row_without(key)
      full_row = ["Overall", 82, 50, 32, 0.610, 34.5, 10.5, 21.2, 0.495, 5.5, 11.8, 0.466,
        5.0, 5.5, 0.909, 0.5, 5.5, 6.0, 5.5, 2.5, 1.0, 0.5, 0.2, 2.0, 3.5, 31.5, 8.5]
      index = all_headers.index(key)
      return full_row unless index

      full_row[0...index] + full_row[(index + 1)..]
    end
  end
end
