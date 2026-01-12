require_relative "../../test_helper"

module NBA
  class TeamDashPtRebReboundKeysTest < Minitest::Test
    cover TeamDashPtReb

    def test_handles_missing_oreb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("OREB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.oreb
    end

    def test_handles_missing_dreb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("DREB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.dreb
    end

    def test_handles_missing_reb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("REB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.reb
    end

    def test_handles_missing_c_oreb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("C_OREB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.c_oreb
    end

    def test_handles_missing_c_dreb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("C_DREB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.c_dreb
    end

    def test_handles_missing_c_reb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("C_REB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.c_reb
    end

    def test_handles_missing_c_reb_pct_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("C_REB_PCT").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.c_reb_pct
    end

    def test_handles_missing_uc_oreb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("UC_OREB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.uc_oreb
    end

    def test_handles_missing_uc_dreb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("UC_DREB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.uc_dreb
    end

    def test_handles_missing_uc_reb_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("UC_REB").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.uc_reb
    end

    def test_handles_missing_uc_reb_pct_key
      stub_request(:get, /teamdashptreb/).to_return(body: response_missing_key("UC_REB_PCT").to_json)

      result = TeamDashPtReb.num_contested(team: 1_610_612_744).first

      assert_nil result.uc_reb_pct
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
