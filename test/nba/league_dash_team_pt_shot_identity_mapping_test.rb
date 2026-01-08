require_relative "../test_helper"

module NBA
  class LeagueDashTeamPtShotIdentityMappingTest < Minitest::Test
    cover LeagueDashTeamPtShot

    def test_maps_team_id
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_name
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_maps_team_abbreviation
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_gp
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_equal 82, stat.gp
    end

    def test_maps_g
      stub_pt_shot_request

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_equal 82, stat.g
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
