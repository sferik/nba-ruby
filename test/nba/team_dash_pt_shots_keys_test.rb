require_relative "../test_helper"

module NBA
  class TeamDashPtShotsKeysTest < Minitest::Test
    cover TeamDashPtShots

    def test_handles_missing_team_id_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("TEAM_ID").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.team_id
    end

    def test_handles_missing_team_name_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("TEAM_NAME").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.team_name
    end

    def test_handles_missing_team_abbreviation_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("TEAM_ABBREVIATION").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.team_abbreviation
    end

    def test_handles_missing_sort_order_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("SORT_ORDER").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.sort_order
    end

    def test_handles_missing_g_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("G").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.g
    end

    def test_handles_missing_shot_type_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("SHOT_TYPE").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.shot_type
    end

    def test_handles_missing_fga_frequency_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FGA_FREQUENCY").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fga_frequency
    end

    def test_handles_missing_fgm_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FGM").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fgm
    end

    def test_handles_missing_fga_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FGA").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fga
    end

    def test_handles_missing_fg_pct_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG_PCT").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg_pct
    end

    def test_handles_missing_efg_pct_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("EFG_PCT").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.efg_pct
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "GeneralShooting", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION SORT_ORDER G SHOT_TYPE FGA_FREQUENCY
        FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "Catch and Shoot", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end
  end
end
