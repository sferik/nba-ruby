require_relative "../../test_helper"

module NBA
  class TeamDashPtShotsTest < Minitest::Test
    cover TeamDashPtShots

    def test_general_returns_collection
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_general_extracts_team_id
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_equal 1_610_612_744, result.team_id
    end

    def test_general_extracts_team_name
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_equal "Golden State Warriors", result.team_name
    end

    def test_general_extracts_team_abbreviation
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_equal "GSW", result.team_abbreviation
    end

    def test_general_extracts_sort_order
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_equal 1, result.sort_order
    end

    def test_general_extracts_g
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_equal 82, result.g
    end

    def test_general_extracts_shot_type
      stub_request(:get, /teamdashptshots/).to_return(body: general_response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_equal "Catch and Shoot", result.shot_type
    end

    private

    def general_response
      {resultSets: [{name: "GeneralShooting", headers: headers, rowSet: [row]}]}
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
