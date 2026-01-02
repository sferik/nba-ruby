require_relative "../test_helper"

module NBA
  class BoxScoreMiscTeamStatsBasicTest < Minitest::Test
    cover BoxScoreMisc

    def test_team_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreMisc.team_stats(game: "0022400001")
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreMisc.team_stats(game: "0022400001")

      assert_requested :get, /boxscoremiscv2.*GameID=0022400001/
    end

    def test_team_stats_parses_result_set_successfully
      stub_box_score_request

      stats = BoxScoreMisc.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoremiscv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PTS_OFF_TOV PTS_2ND_CHANCE
        PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        18, 14, 22, 48, 15, 12, 16, 40, 5, 3, 20, 22]
    end
  end
end
