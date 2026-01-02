require_relative "../test_helper"

module NBA
  class BoxScoreHustleTeamAttributeMappingTest < Minitest::Test
    cover BoxScoreHustle

    def test_maps_team_identity_attributes
      stub_hustle_request
      stat = BoxScoreHustle.team_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_team_game_attributes
      stub_hustle_request
      stat = BoxScoreHustle.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
      assert_equal 118, stat.pts
    end

    def test_maps_contested_shot_stats
      stub_hustle_request
      stat = BoxScoreHustle.team_stats(game: "0022400001").first

      assert_equal 42, stat.contested_shots
      assert_equal 28, stat.contested_shots_2pt
      assert_equal 14, stat.contested_shots_3pt
    end

    def test_maps_hustle_stats
      stub_hustle_request
      stat = BoxScoreHustle.team_stats(game: "0022400001").first

      assert_equal 15, stat.deflections
      assert_equal 2, stat.charges_drawn
      assert_equal 18, stat.screen_assists
      assert_equal 36, stat.screen_ast_pts
    end

    def test_maps_loose_ball_stats
      stub_hustle_request
      stat = BoxScoreHustle.team_stats(game: "0022400001").first

      assert_equal 8, stat.loose_balls_recovered
      assert_equal 3, stat.off_loose_balls_recovered
      assert_equal 5, stat.def_loose_balls_recovered
    end

    def test_maps_box_out_stats
      stub_hustle_request
      stat = BoxScoreHustle.team_stats(game: "0022400001").first

      assert_equal 25, stat.box_outs
      assert_equal 8, stat.off_box_outs
      assert_equal 17, stat.def_box_outs
    end

    private

    def stub_hustle_request
      stub_request(:get, /boxscorehustlev2/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PTS
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
        SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 118,
        42, 28, 14, 15, 2, 18, 36, 8, 3, 5, 25, 8, 17]
    end
  end
end
