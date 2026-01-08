require_relative "../test_helper"

module NBA
  class TeamEstimatedMetricsConstantsTest < Minitest::Test
    cover TeamEstimatedMetrics

    def test_regular_season_constant
      assert_equal "Regular Season", TeamEstimatedMetrics::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", TeamEstimatedMetrics::PLAYOFFS
    end

    def test_result_set_name_constant
      assert_equal "TeamEstimatedMetrics", TeamEstimatedMetrics::RESULT_SET_NAME
    end

    def test_all_uses_default_season
      expected_season = Utils.format_season(Utils.current_season)
      stub_request(:get, /Season=#{expected_season}/).to_return(body: metrics_response.to_json)

      TeamEstimatedMetrics.all

      assert_requested :get, /Season=#{expected_season}/
    end

    private

    def metrics_response
      {resultSets: [{name: "TeamEstimatedMetrics", headers: metrics_headers, rowSet: [metrics_row]}]}
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
