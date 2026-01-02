require_relative "../test_helper"

module NBA
  class LeagueDashTeamStatsDefaultParameterTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_all_uses_default_season_from_utils
      stub_team_stats_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      LeagueDashTeamStats.all

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_all_uses_default_season_type_when_no_params
      stub_team_stats_request

      LeagueDashTeamStats.all

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_default_per_mode_when_no_params
      stub_team_stats_request

      LeagueDashTeamStats.all

      assert_requested :get, /PerMode=PerGame/
    end

    def test_all_uses_default_season_type
      stub_team_stats_request

      LeagueDashTeamStats.all(season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_default_per_mode
      stub_team_stats_request

      LeagueDashTeamStats.all(season: 2024)

      assert_requested :get, /PerMode=PerGame/
    end

    private

    def stub_team_stats_request
      stub_request(:get, /leaguedashteamstats/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
