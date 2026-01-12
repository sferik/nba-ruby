require_relative "../../test_helper"

module NBA
  class LeagueDashTeamClutchAllTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_all_returns_collection
      stub_clutch_request

      result = LeagueDashTeamClutch.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024)

      assert_requested :get, /leaguedashteamclutch.*Season=2024-25/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024, per_mode: LeagueDashTeamClutch::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_all_parses_clutch_stats_successfully
      stub_clutch_request

      stats = LeagueDashTeamClutch.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_all_sets_season_id_on_stats
      stub_clutch_request

      stats = LeagueDashTeamClutch.all(season: 2024)

      assert_equal "2024-25", stats.first.season_id
    end

    def test_all_accepts_season_type_parameter
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024, season_type: LeagueDashTeamClutch::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_accepts_clutch_time_parameter
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024, clutch_time: LeagueDashTeamClutch::LAST_2_MINUTES)

      assert_requested :get, /ClutchTime=Last%202%20Minutes/
    end

    def test_all_accepts_ahead_behind_parameter
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024, ahead_behind: LeagueDashTeamClutch::BEHIND_OR_TIED)

      assert_requested :get, /AheadBehind=Behind%20or%20Tied/
    end

    def test_all_accepts_point_diff_parameter
      stub_clutch_request

      LeagueDashTeamClutch.all(season: 2024, point_diff: 3)

      assert_requested :get, /PointDiff=3/
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, clutch_response.to_json, [String]

      LeagueDashTeamClutch.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def stub_clutch_request
      stub_request(:get, /leaguedashteamclutch/).to_return(body: clutch_response.to_json)
    end

    def clutch_response
      {resultSets: [{name: "LeagueDashTeamClutch", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 46, 36, 0.561, 5.0, 3.2, 7.5, 0.427, 1.2, 3.5, 0.343,
        2.0, 2.5, 0.800, 0.8, 2.2, 3.0, 1.8, 1.2, 0.6, 0.3, 1.5, 9.6, 0.8]
    end
  end
end
