require_relative "../../test_helper"

module NBA
  class BoxScoreHustlePlayerAttributeMappingTest < Minitest::Test
    cover BoxScoreHustle

    def test_maps_team_attributes
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_id
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_player_game_attributes
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal "G", stat.start_position
      assert_equal "DNP - Injury", stat.comment
      assert_equal "32:45", stat.min
      assert_equal 28, stat.pts
    end

    def test_maps_contested_shot_stats
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal 8, stat.contested_shots
      assert_equal 5, stat.contested_shots_2pt
      assert_equal 3, stat.contested_shots_3pt
    end

    def test_maps_hustle_stats
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal 4, stat.deflections
      assert_equal 1, stat.charges_drawn
      assert_equal 3, stat.screen_assists
      assert_equal 6, stat.screen_ast_pts
    end

    def test_maps_loose_ball_stats
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal 2, stat.loose_balls_recovered
      assert_equal 1, stat.off_loose_balls_recovered
      assert_equal 1, stat.def_loose_balls_recovered
    end

    def test_maps_box_out_stats
      stub_hustle_request
      stat = BoxScoreHustle.player_stats(game: "0022400001").first

      assert_equal 3, stat.box_outs
      assert_equal 1, stat.off_box_outs
      assert_equal 2, stat.def_box_outs
    end

    private

    def stub_hustle_request
      stub_request(:get, /boxscorehustlev2/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MIN PTS
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
        SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "DNP - Injury", "32:45", 28,
        8, 5, 3, 4, 1, 3, 6, 2, 1, 1, 3, 1, 2]
    end
  end
end
