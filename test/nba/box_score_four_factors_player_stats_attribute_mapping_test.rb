require_relative "../test_helper"

module NBA
  class BoxScoreFourFactorsPlayerStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_maps_player_game_and_team_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_identity_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "G", stat.start_position
      assert_equal "", stat.comment
      assert_equal "34:22", stat.min
    end

    def test_maps_player_four_factors_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.player_stats(game: "0022400001").first

      assert_in_delta 0.58, stat.efg_pct
      assert_in_delta 0.25, stat.fta_rate
      assert_in_delta 0.12, stat.tov_pct
      assert_in_delta 0.08, stat.oreb_pct
    end

    def test_maps_player_opponent_four_factors_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.player_stats(game: "0022400001").first

      assert_in_delta 0.52, stat.opp_efg_pct
      assert_in_delta 0.22, stat.opp_fta_rate
      assert_in_delta 0.14, stat.opp_tov_pct
      assert_in_delta 0.10, stat.opp_oreb_pct
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
