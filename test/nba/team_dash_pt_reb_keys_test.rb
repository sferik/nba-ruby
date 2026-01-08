require_relative "../test_helper"

module NBA
  class TeamDashPtRebKeysTest < Minitest::Test
    cover TeamDashPtReb

    def test_handles_missing_team_id_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("TEAM_ID").to_json)
      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.team_id
    end

    def test_handles_missing_team_name_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("TEAM_NAME").to_json)
      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.team_name
    end

    def test_handles_missing_sort_order_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("SORT_ORDER").to_json)
      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.sort_order
    end

    def test_handles_missing_g_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("G").to_json)
      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.g
    end

    def test_handles_missing_reb_num_contesting_range_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("REB_NUM_CONTESTING_RANGE").to_json)
      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.reb_num_contesting_range
    end

    def test_handles_missing_reb_frequency_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("REB_FREQUENCY").to_json)
      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.reb_frequency
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "NumContestedRebounding", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
