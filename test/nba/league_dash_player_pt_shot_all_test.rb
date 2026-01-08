require_relative "../test_helper"

module NBA
  class LeagueDashPlayerPtShotAllTest < Minitest::Test
    cover LeagueDashPlayerPtShot

    def test_all_returns_collection
      stub_request(:get, /leaguedashplayerptshot/).to_return(body: pt_shot_response.to_json)

      assert_instance_of Collection, LeagueDashPlayerPtShot.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashplayerptshot/).to_return(body: pt_shot_response.to_json)

      result = LeagueDashPlayerPtShot.all(season: 2024)

      assert_equal 201_939, result.first.player_id
    end

    def test_all_with_season_type_parameter
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: pt_shot_response.to_json)

      LeagueDashPlayerPtShot.all(season: 2024, season_type: LeagueDashPlayerPtShot::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_parameter
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: pt_shot_response.to_json)

      LeagueDashPlayerPtShot.all(season: 2024, per_mode: LeagueDashPlayerPtShot::TOTALS)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, pt_shot_response.to_json, [String]

      LeagueDashPlayerPtShot.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

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
