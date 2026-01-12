require_relative "../../test_helper"

module NBA
  class TeamEstimatedMetricsPctKeysTest < Minitest::Test
    cover TeamEstimatedMetrics

    def test_handles_missing_e_oreb_pct_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_OREB_PCT").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_oreb_pct
    end

    def test_handles_missing_e_dreb_pct_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_DREB_PCT").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_dreb_pct
    end

    def test_handles_missing_e_reb_pct_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_REB_PCT").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_reb_pct
    end

    def test_handles_missing_e_tm_tov_pct_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_TM_TOV_PCT").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_tm_tov_pct
    end

    private

    def response_missing_key(key)
      headers = metrics_headers.reject { |h| h == key }
      row = metrics_row.each_with_index.reject { |_, i| metrics_headers[i] == key }.map(&:first)
      {resultSets: [{name: "TeamEstimatedMetrics", headers: headers, rowSet: [row]}]}
    end

    def metrics_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN E_OFF_RATING E_DEF_RATING E_NET_RATING
        E_PACE E_AST_RATIO E_OREB_PCT E_DREB_PCT E_REB_PCT E_TM_TOV_PCT]
    end

    def metrics_row
      [1_610_612_744, "Golden State Warriors", 82, 46, 36, 0.561, 48.0, 117.5, 110.2, 7.3,
        101.5, 18.5, 25.5, 75.5, 50.5, 11.5]
    end
  end
end
