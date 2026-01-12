require_relative "../../test_helper"

module NBA
  class PlayerDashPtRebMissingKeysTest < Minitest::Test
    cover PlayerDashPtReb

    def test_handles_missing_player_id_key
      assert_nil stat_without_key("PLAYER_ID").player_id
    end

    def test_handles_missing_player_name_last_first_key
      assert_nil stat_without_key("PLAYER_NAME_LAST_FIRST").player_name_last_first
    end

    def test_handles_missing_sort_order_key
      assert_nil stat_without_key("SORT_ORDER").sort_order
    end

    def test_handles_missing_g_key
      assert_nil stat_without_key("G").g
    end

    def test_handles_missing_reb_num_contesting_range_key
      assert_nil stat_without_key("REB_NUM_CONTESTING_RANGE").reb_num_contesting_range
    end

    def test_handles_missing_reb_frequency_key
      assert_nil stat_without_key("REB_FREQUENCY").reb_frequency
    end

    def test_handles_missing_oreb_key
      assert_nil stat_without_key("OREB").oreb
    end

    def test_handles_missing_dreb_key
      assert_nil stat_without_key("DREB").dreb
    end

    def test_handles_missing_reb_key
      assert_nil stat_without_key("REB").reb
    end

    def test_handles_missing_c_oreb_key
      assert_nil stat_without_key("C_OREB").c_oreb
    end

    def test_handles_missing_c_dreb_key
      assert_nil stat_without_key("C_DREB").c_dreb
    end

    def test_handles_missing_c_reb_key
      assert_nil stat_without_key("C_REB").c_reb
    end

    def test_handles_missing_c_reb_pct_key
      assert_nil stat_without_key("C_REB_PCT").c_reb_pct
    end

    def test_handles_missing_uc_oreb_key
      assert_nil stat_without_key("UC_OREB").uc_oreb
    end

    def test_handles_missing_uc_dreb_key
      assert_nil stat_without_key("UC_DREB").uc_dreb
    end

    def test_handles_missing_uc_reb_key
      assert_nil stat_without_key("UC_REB").uc_reb
    end

    def test_handles_missing_uc_reb_pct_key
      assert_nil stat_without_key("UC_REB_PCT").uc_reb_pct
    end

    private

    def stat_without_key(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      row = all_values.except(*key).values
      response = {resultSets: [{name: "NumContestedRebounding", headers: headers, rowSet: [row]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)
      PlayerDashPtReb.num_contested(player: 201_939).first
    end

    def all_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def all_values
      {"PLAYER_ID" => 201_939, "PLAYER_NAME_LAST_FIRST" => "Curry, Stephen", "SORT_ORDER" => 1,
       "G" => 74, "REB_NUM_CONTESTING_RANGE" => "0 Contests", "REB_FREQUENCY" => 0.25,
       "OREB" => 1.2, "DREB" => 4.5, "REB" => 5.7, "C_OREB" => 0.8, "C_DREB" => 2.1,
       "C_REB" => 2.9, "C_REB_PCT" => 0.509, "UC_OREB" => 0.4, "UC_DREB" => 2.4,
       "UC_REB" => 2.8, "UC_REB_PCT" => 0.491}
    end
  end
end
