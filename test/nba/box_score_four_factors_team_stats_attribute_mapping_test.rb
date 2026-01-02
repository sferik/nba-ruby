require_relative "../test_helper"

module NBA
  class BoxScoreFourFactorsTeamStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_maps_team_game_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_maps_team_identity_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.team_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "240:00", stat.min
    end

    def test_maps_team_four_factors_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.team_stats(game: "0022400001").first

      assert_in_delta 0.56, stat.efg_pct
      assert_in_delta 0.28, stat.fta_rate
      assert_in_delta 0.11, stat.tov_pct
      assert_in_delta 0.25, stat.oreb_pct
    end

    def test_maps_team_opponent_four_factors_attributes
      stub_box_score_request
      stat = BoxScoreFourFactors.team_stats(game: "0022400001").first

      assert_in_delta 0.50, stat.opp_efg_pct
      assert_in_delta 0.24, stat.opp_fta_rate
      assert_in_delta 0.15, stat.opp_tov_pct
      assert_in_delta 0.22, stat.opp_oreb_pct
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN EFG_PCT FTA_RATE
        TM_TOV_PCT OREB_PCT OPP_EFG_PCT OPP_FTA_RATE OPP_TOV_PCT OPP_OREB_PCT]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        0.56, 0.28, 0.11, 0.25, 0.50, 0.24, 0.15, 0.22]
    end
  end
end
