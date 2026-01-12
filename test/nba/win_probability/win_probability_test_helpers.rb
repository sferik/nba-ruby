module NBA
  module WinProbabilityTestHelpers
    def win_prob_headers
      %w[EVENT_NUM PERIOD SECONDS_REMAINING LOCATION
        HOME_PCT VISITOR_PCT HOME_PTS VISITOR_PTS HOME_SCORE_BY VISITOR_SCORE_BY
        HOME_DESCRIPTION NEUTRAL_DESCRIPTION VISITOR_DESCRIPTION]
    end

    def win_prob_default_data
      default_game_data.merge(default_score_data).merge(default_description_data)
    end

    def default_game_data
      {"EVENT_NUM" => 42, "PERIOD" => 4, "SECONDS_REMAINING" => 120, "LOCATION" => "GSW"}
    end

    def default_score_data
      {
        "HOME_PCT" => 0.75, "VISITOR_PCT" => 0.25, "HOME_PTS" => 100,
        "VISITOR_PTS" => 95, "HOME_SCORE_BY" => 3, "VISITOR_SCORE_BY" => 0
      }
    end

    def default_description_data
      {"HOME_DESCRIPTION" => "Curry 3PT Shot", "NEUTRAL_DESCRIPTION" => nil, "VISITOR_DESCRIPTION" => nil}
    end

    def win_prob_row
      [42, 4, 120, "GSW",
        0.75, 0.25, 100, 95, 3, 0,
        "Curry 3PT Shot", nil, nil]
    end

    def build_win_prob_response(headers, row)
      {
        resultSets: [{
          name: "WinProbPBP",
          headers: headers,
          rowSet: [row]
        }]
      }
    end

    def build_response_with_values(overrides = {})
      data = win_prob_default_data.merge(overrides)
      headers = win_prob_headers
      row = headers.map { |h| data[h] }

      build_win_prob_response(headers, row)
    end

    def build_row_without(excluded_key)
      win_prob_headers.reject { |h| h.eql?(excluded_key) }.map { |h| win_prob_default_data[h] }
    end

    def build_row_with_nil(key_with_nil_value)
      data = win_prob_default_data.dup
      data[key_with_nil_value] = nil
      win_prob_headers.map { |h| data[h] }
    end
  end
end
