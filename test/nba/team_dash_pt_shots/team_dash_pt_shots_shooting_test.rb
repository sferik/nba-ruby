require_relative "../../test_helper"

module NBA
  class TeamDashPtShotsShootingTest < Minitest::Test
    cover TeamDashPtShots

    def test_extracts_fg3a_frequency
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.55, result.fg3a_frequency
    end

    def test_extracts_fg3m
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 4.8, result.fg3m
    end

    def test_extracts_fg3a
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 11.2, result.fg3a
    end

    def test_extracts_fg3_pct
      stub_request(:get, /teamdashptshots/).to_return(body: response.to_json)

      result = TeamDashPtShots.general(team: 1_610_612_744).first

      assert_in_delta 0.428, result.fg3_pct
    end

    def test_shot_clock_returns_collection
      stub_request(:get, /teamdashptshots/).to_return(body: shot_clock_response.to_json)

      result = TeamDashPtShots.shot_clock(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_shot_clock_extracts_shot_type
      stub_request(:get, /teamdashptshots/).to_return(body: shot_clock_response.to_json)

      result = TeamDashPtShots.shot_clock(team: 1_610_612_744).first

      assert_equal "22-18 Very Early", result.shot_type
    end

    def test_dribble_returns_collection
      stub_request(:get, /teamdashptshots/).to_return(body: dribble_response.to_json)

      result = TeamDashPtShots.dribble(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_dribble_extracts_shot_type
      stub_request(:get, /teamdashptshots/).to_return(body: dribble_response.to_json)

      result = TeamDashPtShots.dribble(team: 1_610_612_744).first

      assert_equal "0 Dribbles", result.shot_type
    end

    private

    def response
      {resultSets: [{name: "GeneralShooting", headers: headers, rowSet: [row]}]}
    end

    def shot_clock_response
      {resultSets: [{name: "ShotClockShooting", headers: headers, rowSet: [shot_clock_row]}]}
    end

    def dribble_response
      {resultSets: [{name: "DribbleShooting", headers: headers, rowSet: [dribble_row]}]}
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

    def shot_clock_row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "22-18 Very Early", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end

    def dribble_row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "0 Dribbles", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end
  end
end
