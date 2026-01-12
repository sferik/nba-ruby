require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerStatsPlayerAttributeMappingTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_maps_player_id
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_equal 201_939, stat.player_id
    end

    def test_maps_player_name
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_age
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_equal 36, stat.age
    end

    def test_maps_season_id
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_equal "2024-25", stat.season_id
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
