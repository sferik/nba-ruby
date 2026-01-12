require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerPtShotShootingMappingTest < Minitest::Test
    cover LeagueDashPlayerPtShot

    def test_maps_fga_frequency
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 1.0, stat.fga_frequency
    end

    def test_maps_fgm
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 8.5, stat.fgm
    end

    def test_maps_fga
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 18.2, stat.fga
    end

    def test_maps_fg_pct
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 0.467, stat.fg_pct
    end

    def test_maps_efg_pct
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 0.563, stat.efg_pct
    end

    def test_maps_fg2a_frequency
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 0.45, stat.fg2a_frequency
    end

    def test_maps_fg2m
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 4.2, stat.fg2m
    end

    def test_maps_fg2a
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 8.1, stat.fg2a
    end

    def test_maps_fg2_pct
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 0.519, stat.fg2_pct
    end

    def test_maps_fg3a_frequency
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 0.55, stat.fg3a_frequency
    end

    def test_maps_fg3m
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 4.3, stat.fg3m
    end

    def test_maps_fg3a
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 10.1, stat.fg3a
    end

    def test_maps_fg3_pct
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 0.426, stat.fg3_pct
    end

    private

    def stub_pt_shot_request
      stub_request(:get, /leaguedashplayerptshot/).to_return(body: pt_shot_response.to_json)
    end

    def pt_shot_response
      {resultSets: [{name: "LeagueDashPTShots", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME PLAYER_LAST_TEAM_ID PLAYER_LAST_TEAM_ABBREVIATION AGE GP G
        FGA_FREQUENCY FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0, 74, 74, 1.0, 8.5, 18.2, 0.467, 0.563,
        0.45, 4.2, 8.1, 0.519, 0.55, 4.3, 10.1, 0.426]
    end
  end
end
