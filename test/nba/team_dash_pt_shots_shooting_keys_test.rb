require_relative "../test_helper"

module NBA
  class TeamDashPtShotsShootingKeysTest < Minitest::Test
    cover TeamDashPtShots

    def test_handles_missing_fg2a_frequency_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG2A_FREQUENCY").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg2a_frequency
    end

    def test_handles_missing_fg2m_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG2M").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg2m
    end

    def test_handles_missing_fg2a_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG2A").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg2a
    end

    def test_handles_missing_fg2_pct_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG2_PCT").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg2_pct
    end

    def test_handles_missing_fg3a_frequency_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG3A_FREQUENCY").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg3a_frequency
    end

    def test_handles_missing_fg3m_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG3M").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg3m
    end

    def test_handles_missing_fg3a_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG3A").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_request(:get, /teamdashptshots/).to_return(body: response_missing_key("FG3_PCT").to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_nil result.fg3_pct
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
