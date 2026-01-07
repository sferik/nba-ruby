require_relative "../test_helper"

module NBA
  class PlayerEstimatedMetricsTest < Minitest::Test
    cover PlayerEstimatedMetrics

    def test_all_returns_collection
      stub_metrics_request

      result = PlayerEstimatedMetrics.all

      assert_instance_of Collection, result
    end

    def test_all_sends_correct_endpoint
      stub_request(:get, /playerestimatedmetrics/).to_return(body: metrics_response.to_json)

      PlayerEstimatedMetrics.all

      assert_requested :get, /playerestimatedmetrics/
    end

    def test_all_parses_identity_info
      stub_metrics_request

      stat = PlayerEstimatedMetrics.all.first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal 74, stat.gp
      assert_equal 46, stat.w
      assert_equal 28, stat.l
    end

    def test_all_parses_record_info
      stub_metrics_request

      stat = PlayerEstimatedMetrics.all.first

      assert_in_delta 0.622, stat.w_pct
      assert_in_delta 32.7, stat.min
    end

    def test_all_parses_rating_info
      stub_metrics_request

      stat = PlayerEstimatedMetrics.all.first

      assert_in_delta 117.5, stat.e_off_rating
      assert_in_delta 110.2, stat.e_def_rating
      assert_in_delta 7.3, stat.e_net_rating
      assert_in_delta 25.5, stat.e_ast_ratio
    end

    def test_all_parses_rebound_percentages
      stub_metrics_request

      stat = PlayerEstimatedMetrics.all.first

      assert_in_delta 2.5, stat.e_oreb_pct
      assert_in_delta 15.5, stat.e_dreb_pct
      assert_in_delta 9.5, stat.e_reb_pct
    end

    def test_all_parses_other_percentages
      stub_metrics_request

      stat = PlayerEstimatedMetrics.all.first

      assert_in_delta 11.5, stat.e_tov_pct
      assert_in_delta 31.5, stat.e_usg_pct
      assert_in_delta 101.5, stat.e_pace
    end

    def test_all_with_season_param
      stub_request(:get, /Season=2023-24/).to_return(body: metrics_response.to_json)

      PlayerEstimatedMetrics.all(season: 2023)

      assert_requested :get, /Season=2023-24/
    end

    def test_all_with_season_type_param
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: metrics_response.to_json)

      PlayerEstimatedMetrics.all(season_type: PlayerEstimatedMetrics::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_defaults_to_regular_season
      stub_request(:get, /SeasonType=Regular(%20|\+)Season/).to_return(body: metrics_response.to_json)

      PlayerEstimatedMetrics.all

      assert_requested :get, /SeasonType=Regular(%20|\+)Season/
    end

    def test_all_returns_empty_collection_for_nil_response
      stub_request(:get, /playerestimatedmetrics/).to_return(body: nil)

      result = PlayerEstimatedMetrics.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_parses_from_correct_result_set
      stub_request(:get, /playerestimatedmetrics/).to_return(body: multi_result_response.to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_equal 201_939, stat.player_id
    end

    private

    def multi_result_response
      {resultSets: [
        {name: "OtherResultSet", headers: ["PLAYER_ID"], rowSet: [[12_345]]},
        {name: "PlayerEstimatedMetrics", headers: metrics_headers, rowSet: [metrics_row]}
      ]}
    end

    def stub_metrics_request
      stub_request(:get, /playerestimatedmetrics/).to_return(body: metrics_response.to_json)
    end

    def metrics_headers
      %w[PLAYER_ID PLAYER_NAME GP W L W_PCT MIN E_OFF_RATING E_DEF_RATING E_NET_RATING
        E_AST_RATIO E_OREB_PCT E_DREB_PCT E_REB_PCT E_TOV_PCT E_USG_PCT E_PACE]
    end

    def metrics_response
      {resultSets: [{name: "PlayerEstimatedMetrics", headers: metrics_headers, rowSet: [metrics_row]}]}
    end

    def metrics_row
      [201_939, "Stephen Curry", 74, 46, 28, 0.622, 32.7, 117.5, 110.2, 7.3,
        25.5, 2.5, 15.5, 9.5, 11.5, 31.5, 101.5]
    end
  end
end
