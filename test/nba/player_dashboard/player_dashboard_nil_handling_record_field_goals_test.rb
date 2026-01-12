require_relative "../../test_helper"
require_relative "player_dashboard_nil_handling_test_helpers"

module NBA
  class PlayerDashboardNilHandlingRecordFieldGoalsTest < Minitest::Test
    include PlayerDashboardNilHandlingTestHelpers

    cover PlayerDashboard

    def test_handles_missing_group_value_key
      response = build_response_without("GROUP_VALUE")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.group_value
    end

    def test_handles_missing_gp_key
      response = build_response_without("GP")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.gp
    end

    def test_handles_missing_min_key
      response = build_response_without("MIN")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.min
    end

    def test_handles_missing_w_key
      response = build_response_without("W")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.w
    end

    def test_handles_missing_l_key
      response = build_response_without("L")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.l
    end

    def test_handles_missing_w_pct_key
      response = build_response_without("W_PCT")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.w_pct
    end

    def test_handles_missing_fgm_key
      response = build_response_without("FGM")
      stub_request(:get, /playerdashboardbygeneralsplits/).to_return(body: response.to_json)

      stat = PlayerDashboard.general_splits(player: 201_939).first

      assert_nil stat.fgm
    end
  end
end
