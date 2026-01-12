require_relative "../../test_helper"
require_relative "team_dashboard_nil_handling_test_helpers"

module NBA
  class TeamDashboardNilHandlingDefenseScoringTest < Minitest::Test
    include TeamDashboardNilHandlingTestHelpers

    cover TeamDashboard

    def test_handles_missing_stl_key
      response = build_response_without("STL")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.stl
    end

    def test_handles_missing_blk_key
      response = build_response_without("BLK")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.blk
    end

    def test_handles_missing_blka_key
      response = build_response_without("BLKA")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.blka
    end

    def test_handles_missing_pf_key
      response = build_response_without("PF")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.pf
    end

    def test_handles_missing_pfd_key
      response = build_response_without("PFD")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.pfd
    end

    def test_handles_missing_pts_key
      response = build_response_without("PTS")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.pts
    end

    def test_handles_missing_plus_minus_key
      response = build_response_without("PLUS_MINUS")
      stub_request(:get, /teamdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = TeamDashboard.general_splits(team: Team::GSW).first

      assert_nil stat.plus_minus
    end
  end
end
