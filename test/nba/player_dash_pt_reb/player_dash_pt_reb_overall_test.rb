require_relative "../../test_helper"

module NBA
  class PlayerDashPtRebOverallTest < Minitest::Test
    cover PlayerDashPtReb

    def test_overall_parses_identity_values
      stub_request(:get, /playerdashptreb/).to_return(body: overall_response.to_json)
      stat = PlayerDashPtReb.overall(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal "Curry, Stephen", stat.player_name_last_first
      assert_nil stat.sort_order
      assert_equal 74, stat.g
      assert_equal "Overall", stat.overall
    end

    def test_overall_parses_rebound_values
      stub_request(:get, /playerdashptreb/).to_return(body: overall_response.to_json)
      stat = PlayerDashPtReb.overall(player: 201_939).first

      assert_in_delta 0.25, stat.reb_frequency
      assert_in_delta 1.2, stat.oreb
      assert_in_delta 4.5, stat.dreb
      assert_in_delta 5.7, stat.reb
    end

    def test_overall_parses_contested_values
      stub_request(:get, /playerdashptreb/).to_return(body: overall_response.to_json)
      stat = PlayerDashPtReb.overall(player: 201_939).first

      assert_in_delta 0.8, stat.c_oreb
      assert_in_delta 2.1, stat.c_dreb
      assert_in_delta 2.9, stat.c_reb
      assert_in_delta 0.509, stat.c_reb_pct
    end

    def test_overall_parses_uncontested_values
      stub_request(:get, /playerdashptreb/).to_return(body: overall_response.to_json)
      stat = PlayerDashPtReb.overall(player: 201_939).first

      assert_in_delta 0.4, stat.uc_oreb
      assert_in_delta 2.4, stat.uc_dreb
      assert_in_delta 2.8, stat.uc_reb
      assert_in_delta 0.491, stat.uc_reb_pct
    end

    private

    def overall_response
      {resultSets: [{
        name: "OverallRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST G OVERALL REB_FREQUENCY
          OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT],
        rowSet: [[201_939, "Curry, Stephen", 74, "Overall", 0.25, 1.2, 4.5, 5.7,
          0.8, 2.1, 2.9, 0.509, 0.4, 2.4, 2.8, 0.491]]
      }]}
    end
  end
end
