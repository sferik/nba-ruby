require_relative "../test_helper"
require_relative "team_dashboard_nil_handling_test_helpers"

module NBA
  class TeamDashboardNilHandlingShootingTest < Minitest::Test
    include TeamDashboardNilHandlingTestHelpers

    cover TeamDashboard

    def test_handles_missing_fga_key
      response = build_response_without("FGA")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.fga
    end

    def test_handles_missing_fg_pct_key
      response = build_response_without("FG_PCT")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.fg_pct
    end

    def test_handles_missing_fg3m_key
      response = build_response_without("FG3M")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.fg3m
    end

    def test_handles_missing_fg3a_key
      response = build_response_without("FG3A")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.fg3a
    end

    def test_handles_missing_fg3_pct_key
      response = build_response_without("FG3_PCT")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.fg3_pct
    end

    def test_handles_missing_ftm_key
      response = build_response_without("FTM")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.ftm
    end
  end
end
