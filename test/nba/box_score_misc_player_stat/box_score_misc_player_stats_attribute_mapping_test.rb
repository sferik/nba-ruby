require_relative "../../test_helper"

module NBA
  class BoxScoreMiscPlayerStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreMisc

    def test_maps_player_game_and_team_attributes
      stub_box_score_request
      stat = BoxScoreMisc.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_identity_attributes
      stub_box_score_request
      stat = BoxScoreMisc.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "G", stat.start_position
      assert_equal "", stat.comment
      assert_equal "34:22", stat.min
    end

    def test_maps_player_misc_attributes
      stub_box_score_request
      stat = BoxScoreMisc.player_stats(game: "0022400001").first

      assert_equal 5, stat.pts_off_tov
      assert_equal 4, stat.pts_2nd_chance
      assert_equal 8, stat.pts_fb
      assert_equal 12, stat.pts_paint
    end

    def test_maps_player_opponent_misc_attributes
      stub_box_score_request
      stat = BoxScoreMisc.player_stats(game: "0022400001").first

      assert_equal 6, stat.opp_pts_off_tov
      assert_equal 3, stat.opp_pts_2nd_chance
      assert_equal 4, stat.opp_pts_fb
      assert_equal 10, stat.opp_pts_paint
    end

    def test_maps_player_defense_attributes
      stub_box_score_request
      stat = BoxScoreMisc.player_stats(game: "0022400001").first

      assert_equal 0, stat.blk
      assert_equal 1, stat.blka
      assert_equal 2, stat.pf
      assert_equal 3, stat.pfd
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoremiscv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
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
  end
end
