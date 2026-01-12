require_relative "../../test_helper"

module NBA
  class LeagueDashTeamStatsAllTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_all_returns_collection
      stub_team_stats_request

      result = LeagueDashTeamStats.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_team_stats_request

      LeagueDashTeamStats.all(season: 2024)

      assert_requested :get, /leaguedashteamstats.*Season=2024-25/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_team_stats_request

      LeagueDashTeamStats.all(season: 2024, per_mode: LeagueDashTeamStats::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_all_parses_team_stats_successfully
      stub_team_stats_request

      stats = LeagueDashTeamStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_all_sets_season_id_on_stats
      stub_team_stats_request

      stats = LeagueDashTeamStats.all(season: 2024)

      assert_equal "2024-25", stats.first.season_id
    end

    def test_all_accepts_season_type_parameter
      stub_team_stats_request

      LeagueDashTeamStats.all(season: 2024, season_type: LeagueDashTeamStats::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_stats_response.to_json, [String]

      LeagueDashTeamStats.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def stub_team_stats_request
      stub_request(:get, /leaguedashteamstats/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "LeagueDashTeamStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK W_RANK PTS_RANK]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 53, 29, 0.646, 240.0, 42.3, 90.5, 0.467, 13.7, 38.2, 0.359,
        17.5, 22.3, 0.785, 10.2, 34.5, 44.7, 27.8, 13.2, 7.5, 5.2, 4.8, 18.5, 19.2, 115.8, 5.2, 1, 3, 5]
    end
  end
end
