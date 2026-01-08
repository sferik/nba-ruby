require_relative "../test_helper"

module NBA
  class TeamDashPtShotsDefenderTest < Minitest::Test
    cover TeamDashPtShots

    def test_closest_defender_returns_collection
      stub_request(:get, /teamdashptshots/).to_return(body: closest_defender_response.to_json)

      result = TeamDashPtShots.closest_defender(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_closest_defender_extracts_shot_type
      stub_request(:get, /teamdashptshots/).to_return(body: closest_defender_response.to_json)

      result = TeamDashPtShots.closest_defender(team: 1_610_612_744).first

      assert_equal "0-2 Feet - Very Tight", result.shot_type
    end

    def test_closest_defender_10ft_returns_collection
      stub_request(:get, /teamdashptshots/).to_return(body: closest_defender_10ft_response.to_json)

      result = TeamDashPtShots.closest_defender_10ft(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_closest_defender_10ft_extracts_shot_type
      stub_request(:get, /teamdashptshots/).to_return(body: closest_defender_10ft_response.to_json)

      result = TeamDashPtShots.closest_defender_10ft(team: 1_610_612_744).first

      assert_equal "10+ Feet - Wide Open", result.shot_type
    end

    def test_touch_time_returns_collection
      stub_request(:get, /teamdashptshots/).to_return(body: touch_time_response.to_json)

      result = TeamDashPtShots.touch_time(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_touch_time_extracts_shot_type
      stub_request(:get, /teamdashptshots/).to_return(body: touch_time_response.to_json)

      result = TeamDashPtShots.touch_time(team: 1_610_612_744).first

      assert_equal "Touch < 2 Seconds", result.shot_type
    end

    def test_closest_defender_includes_correct_params
      stub_request(:get, /teamdashptshots/).to_return(body: closest_defender_response.to_json)

      TeamDashPtShots.closest_defender(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    def test_closest_defender_10ft_includes_correct_params
      stub_request(:get, /teamdashptshots/).to_return(body: closest_defender_10ft_response.to_json)

      TeamDashPtShots.closest_defender_10ft(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    def test_touch_time_includes_correct_params
      stub_request(:get, /teamdashptshots/).to_return(body: touch_time_response.to_json)

      TeamDashPtShots.touch_time(team: 1_610_612_744, season_type: "Playoffs", per_mode: "Totals")

      assert_requested :get, /SeasonType=Playoffs/
      assert_requested :get, /PerMode=Totals/
    end

    private

    def closest_defender_response
      {resultSets: [{name: "ClosestDefenderShooting", headers: headers, rowSet: [closest_defender_row]}]}
    end

    def closest_defender_10ft_response
      {resultSets: [{name: "ClosestDefender10ftPlusShooting", headers: headers, rowSet: [closest_defender_10ft_row]}]}
    end

    def touch_time_response
      {resultSets: [{name: "TouchTimeShooting", headers: headers, rowSet: [touch_time_row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION SORT_ORDER G SHOT_TYPE FGA_FREQUENCY
        FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def closest_defender_row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "0-2 Feet - Very Tight", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end

    def closest_defender_10ft_row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "10+ Feet - Wide Open", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end

    def touch_time_row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "Touch < 2 Seconds", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end
  end
end
