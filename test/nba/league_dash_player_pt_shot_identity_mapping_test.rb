require_relative "../test_helper"

module NBA
  class LeagueDashPlayerPtShotIdentityMappingTest < Minitest::Test
    cover LeagueDashPlayerPtShot

    def test_maps_player_id
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_equal 201_939, stat.player_id
    end

    def test_maps_player_name
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_player_last_team_id
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_equal Team::GSW, stat.player_last_team_id
    end

    def test_maps_player_last_team_abbreviation
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_equal "GSW", stat.player_last_team_abbreviation
    end

    def test_maps_age
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_in_delta 36.0, stat.age
    end

    def test_maps_gp
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_equal 74, stat.gp
    end

    def test_maps_g
      stub_pt_shot_request

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_equal 74, stat.g
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
