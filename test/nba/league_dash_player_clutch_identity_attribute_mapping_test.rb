require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchIdentityAttributeMappingTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_maps_player_id
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal 201_939, stat.player_id
    end

    def test_maps_player_name
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_team_id
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_abbreviation
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_age
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal 36, stat.age
    end

    def test_maps_season_id
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal "2024-25", stat.season_id
    end

    def test_maps_gp
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal 74, stat.gp
    end

    def test_maps_w
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal 46, stat.w
    end

    def test_maps_l
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_equal 28, stat.l
    end

    def test_maps_w_pct
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.622, stat.w_pct)
    end

    def test_maps_min
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(5.2, stat.min)
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
