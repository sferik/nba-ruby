require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerClutchAllTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_all_returns_collection
      stub_clutch_request

      result = LeagueDashPlayerClutch.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_clutch_request

      LeagueDashPlayerClutch.all(season: 2024)

      assert_requested :get, /leaguedashplayerclutch.*Season=2024-25/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_clutch_request

      LeagueDashPlayerClutch.all(season: 2024, per_mode: LeagueDashPlayerClutch::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_all_parses_clutch_stats_successfully
      stub_clutch_request

      stats = LeagueDashPlayerClutch.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_all_sets_season_id_on_stats
      stub_clutch_request

      stats = LeagueDashPlayerClutch.all(season: 2024)

      assert_equal "2024-25", stats.first.season_id
    end

    def test_all_accepts_season_type_parameter
      stub_clutch_request

      LeagueDashPlayerClutch.all(season: 2024, season_type: LeagueDashPlayerClutch::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_accepts_clutch_time_parameter
      stub_clutch_request

      LeagueDashPlayerClutch.all(season: 2024, clutch_time: LeagueDashPlayerClutch::LAST_2_MINUTES)

      assert_requested :get, /ClutchTime=Last%202%20Minutes/
    end

    def test_all_accepts_ahead_behind_parameter
      stub_clutch_request

      LeagueDashPlayerClutch.all(season: 2024, ahead_behind: LeagueDashPlayerClutch::BEHIND_OR_TIED)

      assert_requested :get, /AheadBehind=Behind%20or%20Tied/
    end

    def test_all_accepts_point_diff_parameter
      stub_clutch_request

      LeagueDashPlayerClutch.all(season: 2024, point_diff: 3)

      assert_requested :get, /PointDiff=3/
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, clutch_response.to_json, [String]

      LeagueDashPlayerClutch.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def stub_clutch_request
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: clutch_response.to_json)
    end

    def clutch_response
      {resultSets: [{name: "LeagueDashPlayerClutch", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 74, 46, 28, 0.622, 5.2,
        1.2, 2.8, 0.429, 0.5, 1.4, 0.357, 0.8, 0.9, 0.889,
        0.1, 0.5, 0.6, 1.0, 0.4, 0.2, 0.1, 0.3, 3.7, 1.2]
    end
  end
end
