require_relative "../../test_helper"

module NBA
  class LeagueDashTeamClutchDefaultParameterTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_default_season_uses_current_season
      stub_clutch_request

      LeagueDashTeamClutch.all

      season = Utils.current_season
      expected = "#{season}-#{(season + 1).to_s[-2..]}"

      assert_requested :get, /Season=#{expected}/
    end

    def test_default_season_type_is_regular_season
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_default_clutch_time_is_last_five_minutes
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024)

      assert_requested :get, /ClutchTime=Last%205%20Minutes/
    end

    def test_default_ahead_behind_is_ahead_or_behind
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024)

      assert_requested :get, /AheadBehind=Ahead%20or%20Behind/
    end

    def test_default_point_diff_is_five
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024)

      assert_requested :get, /PointDiff=5/
    end

    def test_default_per_mode_is_per_game
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024)

      assert_requested :get, /PerMode=PerGame/
    end

    private

    def stub_clutch_request
      stub_request(:get, /leaguedashteamclutch/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
