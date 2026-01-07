require_relative "../test_helper"

module NBA
  class PlayerEstimatedMetricsMissingPctKeysTest < Minitest::Test
    cover PlayerEstimatedMetrics

    def test_handles_missing_e_oreb_pct
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_OREB_PCT").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_oreb_pct
    end

    def test_handles_missing_e_dreb_pct
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_DREB_PCT").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_dreb_pct
    end

    def test_handles_missing_e_reb_pct
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_REB_PCT").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_reb_pct
    end

    def test_handles_missing_e_tov_pct
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_TOV_PCT").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_tov_pct
    end

    def test_handles_missing_e_usg_pct
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_USG_PCT").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_usg_pct
    end

    def test_handles_missing_e_pace
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_PACE").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_pace
    end

    private

    def all_headers
      %w[PLAYER_ID PLAYER_NAME GP W L W_PCT MIN E_OFF_RATING E_DEF_RATING E_NET_RATING
        E_AST_RATIO E_OREB_PCT E_DREB_PCT E_REB_PCT E_TOV_PCT E_USG_PCT E_PACE]
    end

    def all_values
      [201_939, "Stephen Curry", 74, 46, 28, 0.622, 32.7, 117.5, 110.2, 7.3,
        25.5, 2.5, 15.5, 9.5, 11.5, 31.5, 101.5]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "PlayerEstimatedMetrics", headers: headers, rowSet: [values]}]}
    end
  end
end
