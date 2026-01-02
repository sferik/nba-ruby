require_relative "../test_helper"

module NBA
  class BoxScoreMiscPlayerStatsBasicTest < Minitest::Test
    cover BoxScoreMisc

    def test_player_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreMisc.player_stats(game: "0022400001")
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreMisc.player_stats(game: "0022400001")

      assert_requested :get, /boxscoremiscv2.*GameID=0022400001/
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoremiscv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "TeamStats", headers: team_headers, rowSet: []}
      ]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PTS_OFF_TOV PTS_2ND_CHANCE PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE
        OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 5, 4, 8, 12, 6, 3, 4, 10, 0, 1, 2, 3]
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PTS_OFF_TOV PTS_2ND_CHANCE
        PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end
  end
end
