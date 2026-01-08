require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchShootingAttributeMappingTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_maps_fgm
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(1.2, stat.fgm)
    end

    def test_maps_fga
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(2.8, stat.fga)
    end

    def test_maps_fg_pct
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.429, stat.fg_pct)
    end

    def test_maps_fg3m
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.5, stat.fg3m)
    end

    def test_maps_fg3a
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(1.4, stat.fg3a)
    end

    def test_maps_fg3_pct
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.357, stat.fg3_pct)
    end

    def test_maps_ftm
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.8, stat.ftm)
    end

    def test_maps_fta
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.9, stat.fta)
    end

    def test_maps_ft_pct
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.889, stat.ft_pct)
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
