require_relative "../test_helper"

module NBA
  class TeamDashPtShotsMoreParamsTest < Minitest::Test
    cover TeamDashPtShots

    def test_shot_clock_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: shot_clock_response.to_json)

      TeamDashPtShots.shot_clock(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_shot_clock_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: shot_clock_response.to_json)

      TeamDashPtShots.shot_clock(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_dribble_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: dribble_response.to_json)

      TeamDashPtShots.dribble(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_dribble_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: dribble_response.to_json)

      TeamDashPtShots.dribble(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_closest_defender_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: closest_defender_response.to_json)

      TeamDashPtShots.closest_defender(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_closest_defender_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: closest_defender_response.to_json)

      TeamDashPtShots.closest_defender(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_closest_defender_10ft_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: closest_defender_10ft_response.to_json)

      TeamDashPtShots.closest_defender_10ft(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_closest_defender_10ft_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: closest_defender_10ft_response.to_json)

      TeamDashPtShots.closest_defender_10ft(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_touch_time_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: touch_time_response.to_json)

      TeamDashPtShots.touch_time(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_touch_time_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: touch_time_response.to_json)

      TeamDashPtShots.touch_time(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    private

    def headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION SORT_ORDER G SHOT_TYPE FGA_FREQUENCY
        FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "Catch and Shoot", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end

    def shot_clock_response
      {resultSets: [{name: "ShotClockShooting", headers: headers, rowSet: [row]}]}
    end

    def dribble_response
      {resultSets: [{name: "DribbleShooting", headers: headers, rowSet: [row]}]}
    end

    def closest_defender_response
      {resultSets: [{name: "ClosestDefenderShooting", headers: headers, rowSet: [row]}]}
    end

    def closest_defender_10ft_response
      {resultSets: [{name: "ClosestDefender10ftPlusShooting", headers: headers, rowSet: [row]}]}
    end

    def touch_time_response
      {resultSets: [{name: "TouchTimeShooting", headers: headers, rowSet: [row]}]}
    end
  end
end
