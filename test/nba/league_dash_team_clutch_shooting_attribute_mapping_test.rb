require_relative "../test_helper"

module NBA
  class LeagueDashTeamClutchShootingAttributeMappingTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_maps_fgm
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(3.2, stat.fgm)
    end

    def test_maps_fga
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(7.5, stat.fga)
    end

    def test_maps_fg_pct
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.427, stat.fg_pct)
    end

    def test_maps_fg3m
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(1.2, stat.fg3m)
    end

    def test_maps_fg3a
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(3.5, stat.fg3a)
    end

    def test_maps_fg3_pct
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.343, stat.fg3_pct)
    end

    def test_maps_ftm
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(2.0, stat.ftm)
    end

    def test_maps_fta
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(2.5, stat.fta)
    end

    def test_maps_ft_pct
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.800, stat.ft_pct)
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
