require_relative "../../test_helper"

module NBA
  class BoxScoreFourFactorsTeamStatsBasicTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_team_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreFourFactors.team_stats(game: "0022400001")
    end

    def test_team_stats_parses_result_set_successfully
      stub_box_score_request

      stats = BoxScoreFourFactors.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreFourFactors.team_stats(game: "0022400001")

      assert_requested :get, /boxscorefourfactorsv2.*GameID=0022400001/
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
