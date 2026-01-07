require_relative "../test_helper"

module NBA
  class PlayerEstimatedMetricsMissingKeysTest < Minitest::Test
    cover PlayerEstimatedMetrics

    def test_handles_missing_player_id
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("PLAYER_ID").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.player_id
    end

    def test_handles_missing_player_name
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("PLAYER_NAME").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.player_name
    end

    def test_handles_missing_gp
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("GP").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.gp
    end

    def test_handles_missing_w
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("W").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.w
    end

    def test_handles_missing_l
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("L").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.l
    end

    def test_handles_missing_w_pct
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("W_PCT").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.w_pct
    end

    def test_handles_missing_min
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("MIN").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.min
    end

    def test_handles_missing_e_off_rating
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_OFF_RATING").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_off_rating
    end

    def test_handles_missing_e_def_rating
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_DEF_RATING").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_def_rating
    end

    def test_handles_missing_e_net_rating
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_NET_RATING").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_net_rating
    end

    def test_handles_missing_e_ast_ratio
      stub_request(:get, /playerestimatedmetrics/).to_return(body: response_without("E_AST_RATIO").to_json)

      stat = PlayerEstimatedMetrics.all.first

      assert_nil stat.e_ast_ratio
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
