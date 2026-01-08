require_relative "../test_helper"

module NBA
  class LeagueDashTeamPtShotAllTest < Minitest::Test
    cover LeagueDashTeamPtShot

    def test_all_returns_collection
      stub_request(:get, /leaguedashteamptshot/).to_return(body: pt_shot_response.to_json)

      assert_instance_of Collection, LeagueDashTeamPtShot.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashteamptshot/).to_return(body: pt_shot_response.to_json)

      result = LeagueDashTeamPtShot.all(season: 2024)

      assert_equal Team::GSW, result.first.team_id
    end

    def test_all_with_season_type_parameter
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: pt_shot_response.to_json)

      LeagueDashTeamPtShot.all(season: 2024, season_type: LeagueDashTeamPtShot::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_parameter
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: pt_shot_response.to_json)

      LeagueDashTeamPtShot.all(season: 2024, per_mode: LeagueDashTeamPtShot::TOTALS)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, pt_shot_response.to_json, [String]

      LeagueDashTeamPtShot.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

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
