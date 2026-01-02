require_relative "../test_helper"

module NBA
  class BoxScoreMiscTeamStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreMisc

    def test_maps_team_game_attributes
      stub_box_score_request
      stat = BoxScoreMisc.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_maps_team_identity_attributes
      stub_box_score_request
      stat = BoxScoreMisc.team_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "240:00", stat.min
    end

    def test_maps_team_misc_attributes
      stub_box_score_request
      stat = BoxScoreMisc.team_stats(game: "0022400001").first

      assert_equal 18, stat.pts_off_tov
      assert_equal 14, stat.pts_2nd_chance
      assert_equal 22, stat.pts_fb
      assert_equal 48, stat.pts_paint
    end

    def test_maps_team_opponent_misc_attributes
      stub_box_score_request
      stat = BoxScoreMisc.team_stats(game: "0022400001").first

      assert_equal 15, stat.opp_pts_off_tov
      assert_equal 12, stat.opp_pts_2nd_chance
      assert_equal 16, stat.opp_pts_fb
      assert_equal 40, stat.opp_pts_paint
    end

    def test_maps_team_defense_attributes
      stub_box_score_request
      stat = BoxScoreMisc.team_stats(game: "0022400001").first

      assert_equal 5, stat.blk
      assert_equal 3, stat.blka
      assert_equal 20, stat.pf
      assert_equal 22, stat.pfd
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoremiscv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
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
