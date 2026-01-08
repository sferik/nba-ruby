require_relative "../test_helper"

module NBA
  class TeamEstimatedMetricsRatingKeysTest < Minitest::Test
    cover TeamEstimatedMetrics

    def test_handles_missing_e_off_rating_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_OFF_RATING").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_off_rating
    end

    def test_handles_missing_e_def_rating_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_DEF_RATING").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_def_rating
    end

    def test_handles_missing_e_net_rating_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_NET_RATING").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_net_rating
    end

    def test_handles_missing_e_pace_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_PACE").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_pace
    end

    def test_handles_missing_e_ast_ratio_key
      stub_request(:get, /teamestimatedmetrics/).to_return(body: response_missing_key("E_AST_RATIO").to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_nil stat.e_ast_ratio
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
