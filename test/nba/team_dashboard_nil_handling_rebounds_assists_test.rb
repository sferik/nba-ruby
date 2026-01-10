require_relative "../test_helper"
require_relative "team_dashboard_nil_handling_test_helpers"

module NBA
  class TeamDashboardNilHandlingReboundsAssistsTest < Minitest::Test
    include TeamDashboardNilHandlingTestHelpers

    cover TeamDashboard

    def test_handles_missing_fta_key
      response = build_response_without("FTA")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.fta
    end

    def test_handles_missing_ft_pct_key
      response = build_response_without("FT_PCT")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.ft_pct
    end

    def test_handles_missing_oreb_key
      response = build_response_without("OREB")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.oreb
    end

    def test_handles_missing_dreb_key
      response = build_response_without("DREB")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.dreb
    end

    def test_handles_missing_reb_key
      response = build_response_without("REB")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.reb
    end

    def test_handles_missing_ast_key
      response = build_response_without("AST")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.ast
    end

    def test_handles_missing_tov_key
      response = build_response_without("TOV")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.tov
    end
  end
end
