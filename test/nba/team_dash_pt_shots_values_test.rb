require_relative "../test_helper"

module NBA
  class TeamDashPtShotsValuesTest < Minitest::Test
    cover TeamDashPtShots

    def test_extracts_fga_frequency
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.35, result.fga_frequency
    end

    def test_extracts_fgm
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 7.2, result.fgm
    end

    def test_extracts_fga
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 15.3, result.fga
    end

    def test_extracts_fg_pct
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.472, result.fg_pct
    end

    def test_extracts_efg_pct
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.561, result.efg_pct
    end

    def test_extracts_fg2a_frequency
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.45, result.fg2a_frequency
    end

    def test_extracts_fg2m
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 4.1, result.fg2m
    end

    def test_extracts_fg2a
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 7.8, result.fg2a
    end

    def test_extracts_fg2_pct
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.526, result.fg2_pct
    end

    private

    def response
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
