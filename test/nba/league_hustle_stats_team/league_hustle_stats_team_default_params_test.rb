require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsTeamDefaultParamsTest < Minitest::Test
    cover LeagueHustleStatsTeam

    def test_all_uses_default_season_from_utils
      stub_hustle_stats_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      LeagueHustleStatsTeam.all

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_all_uses_default_season_type
      stub_hustle_stats_request

      LeagueHustleStatsTeam.all(season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_default_per_mode
      stub_hustle_stats_request

      LeagueHustleStatsTeam.all(season: 2024)

      assert_requested :get, /PerMode=PerGame/
    end

    private

    def stub_hustle_stats_request
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
