require_relative "../../test_helper"
require_relative "player_dashboard_nil_handling_test_helpers"

module NBA
  class PlayerDashboardNilHandlingShootingTest < Minitest::Test
    include PlayerDashboardNilHandlingTestHelpers

    cover PlayerDashboard

    def test_handles_missing_fga_key
      response = build_response_without("FGA")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.fga
    end

    def test_handles_missing_fg_pct_key
      response = build_response_without("FG_PCT")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.fg_pct
    end

    def test_handles_missing_fg3m_key
      response = build_response_without("FG3M")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.fg3m
    end

    def test_handles_missing_fg3a_key
      response = build_response_without("FG3A")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.fg3a
    end

    def test_handles_missing_fg3_pct_key
      response = build_response_without("FG3_PCT")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.fg3_pct
    end

    def test_handles_missing_ftm_key
      response = build_response_without("FTM")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.ftm
    end
  end
end
