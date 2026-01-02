require_relative "../test_helper"

module NBA
  class LeagueDashPlayerStatsAllTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_all_returns_collection
      stub_player_stats_request

      result = LeagueDashPlayerStats.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_player_stats_request

      LeagueDashPlayerStats.all(season: 2024)

      assert_requested :get, /leaguedashplayerstats.*Season=2024-25/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_player_stats_request

      LeagueDashPlayerStats.all(season: 2024, per_mode: LeagueDashPlayerStats::PER_36)

      assert_requested :get, /PerMode=Per36/
    end

    def test_all_parses_player_stats_successfully
      stub_player_stats_request

      stats = LeagueDashPlayerStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_all_sets_season_id_on_stats
      stub_player_stats_request

      stats = LeagueDashPlayerStats.all(season: 2024)

      assert_equal "2024-25", stats.first.season_id
    end

    def test_all_accepts_season_type_parameter
      stub_player_stats_request

      LeagueDashPlayerStats.all(season: 2024, season_type: LeagueDashPlayerStats::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    private

    def stub_player_stats_request
      stub_request(:get, /leaguedashplayerstats/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "LeagueDashPlayerStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS
        PLUS_MINUS NBA_FANTASY_PTS DD2 TD3]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 72, 46, 26, 0.639, 34.5, 9.2, 19.8, 0.465,
        4.8, 11.2, 0.429, 5.1, 5.5, 0.927, 0.5, 4.3, 4.8, 5.1, 3.2, 0.9, 0.4, 0.3, 2.1, 4.2, 28.3,
        5.2, 45.6, 12, 0]
    end
  end
end
