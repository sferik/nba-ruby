require_relative "../../test_helper"

module NBA
  class TeamEstimatedMetricsTest < Minitest::Test
    cover TeamEstimatedMetrics

    def test_all_returns_collection
      stub_metrics_request

      result = TeamEstimatedMetrics.all

      assert_instance_of Collection, result
    end

    def test_all_sends_correct_endpoint
      stub_request(:get, /teamestimatedmetrics/).to_return(body: metrics_response.to_json)

      TeamEstimatedMetrics.all

      assert_requested :get, /teamestimatedmetrics/
    end

    def test_all_parses_identity_info
      stub_metrics_request

      stat = TeamEstimatedMetrics.all.first

      assert_equal 1_610_612_744, stat.team_id
      assert_equal "Golden State Warriors", stat.team_name
      assert_equal 82, stat.gp
      assert_equal 46, stat.w
      assert_equal 36, stat.l
    end

    def test_all_parses_record_info
      stub_metrics_request

      stat = TeamEstimatedMetrics.all.first

      assert_in_delta 0.561, stat.w_pct
      assert_in_delta 48.0, stat.min
    end

    def test_all_parses_rating_info
      stub_metrics_request

      stat = TeamEstimatedMetrics.all.first

      assert_in_delta 117.5, stat.e_off_rating
      assert_in_delta 110.2, stat.e_def_rating
      assert_in_delta 7.3, stat.e_net_rating
      assert_in_delta 101.5, stat.e_pace
      assert_in_delta 18.5, stat.e_ast_ratio
    end

    def test_all_parses_rebound_percentages
      stub_metrics_request

      stat = TeamEstimatedMetrics.all.first

      assert_in_delta 25.5, stat.e_oreb_pct
      assert_in_delta 75.5, stat.e_dreb_pct
      assert_in_delta 50.5, stat.e_reb_pct
      assert_in_delta 11.5, stat.e_tm_tov_pct
    end

    def test_all_with_season_param
      stub_request(:get, /Season=2023-24/).to_return(body: metrics_response.to_json)

      TeamEstimatedMetrics.all(season: 2023)

      assert_requested :get, /Season=2023-24/
    end

    def test_all_with_season_type_param
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: metrics_response.to_json)

      TeamEstimatedMetrics.all(season_type: TeamEstimatedMetrics::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_defaults_to_regular_season
      stub_request(:get, /SeasonType=Regular(%20|\+)Season/).to_return(body: metrics_response.to_json)

      TeamEstimatedMetrics.all

      assert_requested :get, /SeasonType=Regular(%20|\+)Season/
    end

    def test_all_returns_empty_collection_for_nil_response
      stub_request(:get, /teamestimatedmetrics/).to_return(body: nil)

      result = TeamEstimatedMetrics.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_parses_from_correct_result_set
      stub_request(:get, /teamestimatedmetrics/).to_return(body: multi_result_response.to_json)

      stat = TeamEstimatedMetrics.all.first

      assert_equal 1_610_612_744, stat.team_id
    end

    private

    def multi_result_response
      {resultSets: [
        {name: "OtherResultSet", headers: ["TEAM_ID"], rowSet: [[12_345]]},
        {name: "TeamEstimatedMetrics", headers: metrics_headers, rowSet: [metrics_row]}
      ]}
    end

    def stub_metrics_request
      stub_request(:get, /teamestimatedmetrics/).to_return(body: metrics_response.to_json)
    end

    def metrics_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN E_OFF_RATING E_DEF_RATING E_NET_RATING
        E_PACE E_AST_RATIO E_OREB_PCT E_DREB_PCT E_REB_PCT E_TM_TOV_PCT]
    end

    def metrics_response
      {resultSets: [{name: "TeamEstimatedMetrics", headers: metrics_headers, rowSet: [metrics_row]}]}
    end

    def metrics_row
      [1_610_612_744, "Golden State Warriors", 82, 46, 36, 0.561, 48.0, 117.5, 110.2, 7.3,
        101.5, 18.5, 25.5, 75.5, 50.5, 11.5]
    end
  end
end
