require_relative "../test_helper"

module NBA
  class BoxScorePlayerTrackPlayerAttributeMappingTest < Minitest::Test
    cover BoxScorePlayerTrack

    def test_maps_team_attributes
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_attributes
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "G", stat.start_position
      assert_equal "", stat.comment
      assert_equal "34:22", stat.min
    end

    def test_maps_tracking_stats
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_in_delta 4.52, stat.speed
      assert_in_delta 2.85, stat.distance
      assert_equal 75, stat.touches
    end

    def test_maps_rebound_chances
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal 3, stat.oreb_chances
      assert_equal 8, stat.dreb_chances
      assert_equal 11, stat.reb_chances
    end

    def test_maps_passing_stats
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal 3, stat.secondary_ast
      assert_equal 2, stat.ft_ast
      assert_equal 48, stat.passes
      assert_equal 7, stat.ast
    end

    def test_maps_contested_shooting
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal 8, stat.cfgm
      assert_equal 15, stat.cfga
      assert_in_delta 0.533, stat.cfg_pct
    end

    def test_maps_uncontested_shooting
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal 3, stat.ufgm
      assert_equal 5, stat.ufga
      assert_in_delta 0.6, stat.ufg_pct
    end

    def test_maps_defended_shooting
      stub_track_request
      stat = BoxScorePlayerTrack.player_stats(game: "0022400001").first

      assert_equal 5, stat.dfgm
      assert_equal 12, stat.dfga
      assert_in_delta 0.417, stat.dfg_pct
    end

    private

    def stub_track_request
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MIN
        SPD DIST ORBC DRBC RBC TCHS SAST FTAST PASS AST
        CFGM CFGA CFG_PCT UFGM UFGA UFG_PCT DFGM DFGA DFG_PCT]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "", "34:22",
        4.52, 2.85, 3, 8, 11, 75, 3, 2, 48, 7,
        8, 15, 0.533, 3, 5, 0.6, 5, 12, 0.417]
    end
  end
end
