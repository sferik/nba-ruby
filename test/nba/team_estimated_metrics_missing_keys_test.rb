require_relative "../test_helper"

module NBA
  class TeamEstimatedMetricsMissingKeysTest < Minitest::Test
    cover TeamEstimatedMetrics

    def test_handles_missing_team_id_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("TEAM_ID").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.team_id
    end

    def test_handles_missing_team_name_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("TEAM_NAME").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.team_name
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("GP").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.gp
    end

    def test_handles_missing_w_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("W").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.w
    end

    def test_handles_missing_l_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("L").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.l
    end

    def test_handles_missing_w_pct_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("W_PCT").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.w_pct
    end

    def test_handles_missing_min_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("MIN").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.min
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
