require_relative "../../test_helper"

module NBA
  class BoxScoreFourFactorsPlayerStatsBasicTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_player_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreFourFactors.player_stats(game: "0022400001")
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreFourFactors.player_stats(game: "0022400001")

      assert_requested :get, /boxscorefourfactorsv2.*GameID=0022400001/
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN EFG_PCT FTA_RATE TM_TOV_PCT OREB_PCT OPP_EFG_PCT OPP_FTA_RATE OPP_TOV_PCT OPP_OREB_PCT]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.58, 0.25, 0.12, 0.08, 0.52, 0.22, 0.14, 0.10]
    end
  end
end
