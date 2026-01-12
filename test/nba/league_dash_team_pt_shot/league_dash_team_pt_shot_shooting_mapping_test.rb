require_relative "../../test_helper"

module NBA
  class LeagueDashTeamPtShotShootingMappingTest < Minitest::Test
    cover LeagueDashTeamPtShot

    def test_maps_fga_frequency
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 1.0, stat.fga_frequency
    end

    def test_maps_fgm
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 42.5, stat.fgm
    end

    def test_maps_fga
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 89.2, stat.fga
    end

    def test_maps_fg_pct
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 0.477, stat.fg_pct
    end

    def test_maps_efg_pct
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 0.563, stat.efg_pct
    end

    def test_maps_fg2a_frequency
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 0.45, stat.fg2a_frequency
    end

    def test_maps_fg2m
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 20.2, stat.fg2m
    end

    def test_maps_fg2a
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 41.1, stat.fg2a
    end

    def test_maps_fg2_pct
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 0.492, stat.fg2_pct
    end

    def test_maps_fg3a_frequency
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 0.55, stat.fg3a_frequency
    end

    def test_maps_fg3m
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 15.3, stat.fg3m
    end

    def test_maps_fg3a
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 40.1, stat.fg3a
    end

    def test_maps_fg3_pct
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_in_delta 0.382, stat.fg3_pct
    end

    private

    def stub_pt_shot_request
      stub_request(:get, /leaguedashteamptshot/).to_return(body: pt_shot_response.to_json)
    end

    def pt_shot_response
      {resultSets: [{name: "LeagueDashPTShots", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION GP G FGA_FREQUENCY FGM FGA FG_PCT EFG_PCT
        FG2A_FREQUENCY FG2M FG2A FG2_PCT FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", "GSW", 82, 82, 1.0, 42.5, 89.2, 0.477, 0.563,
        0.45, 20.2, 41.1, 0.492, 0.55, 15.3, 40.1, 0.382]
    end
  end
end
