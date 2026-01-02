require_relative "../test_helper"

module NBA
  class LeagueDashPlayerStatsFreeThrowAttributeMappingTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_maps_free_throws_made
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_in_delta 5.1, stat.ftm
    end

    def test_maps_free_throws_attempted
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_in_delta 5.5, stat.fta
    end

    def test_maps_free_throw_percentage
      stub_player_stats_request

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_in_delta 0.927, stat.ft_pct
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
