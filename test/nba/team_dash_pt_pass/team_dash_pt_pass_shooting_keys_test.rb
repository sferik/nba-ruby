require_relative "../../test_helper"

module NBA
  class TeamDashPtPassShootingKeysTest < Minitest::Test
    cover TeamDashPtPass

    def test_handles_missing_fgm_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FGM").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fgm
    end

    def test_handles_missing_fga_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FGA").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fga
    end

    def test_handles_missing_fg_pct_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG_PCT").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg_pct
    end

    def test_handles_missing_fg2m_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG2M").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg2m
    end

    def test_handles_missing_fg2a_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG2A").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg2a
    end

    def test_handles_missing_fg2_pct_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG2_PCT").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg2_pct
    end

    def test_handles_missing_fg3m_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG3M").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg3m
    end

    def test_handles_missing_fg3a_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG3A").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FG3_PCT").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.fg3_pct
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "PassesMade", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_FROM PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "Made", 82, "Stephen Curry", 201_939, 0.15, 5.2, 2.1,
        3.5, 7.2, 0.486, 1.5, 3.0, 0.5, 2.0, 4.2, 0.476]
    end
  end
end
