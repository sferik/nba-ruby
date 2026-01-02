require_relative "../test_helper"

module NBA
  class BoxScorePlayerTrackTeamAttributeMappingTest < Minitest::Test
    cover BoxScorePlayerTrack

    def test_maps_team_identity_attributes
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "240:00", stat.min
    end

    def test_maps_tracking_stats
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_in_delta 4.25, stat.speed
      assert_in_delta 12.5, stat.distance
      assert_equal 320, stat.touches
    end

    def test_maps_rebound_chances
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_equal 15, stat.oreb_chances
      assert_equal 42, stat.dreb_chances
      assert_equal 57, stat.reb_chances
    end

    def test_maps_passing_stats
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_equal 12, stat.secondary_ast
      assert_equal 8, stat.ft_ast
      assert_equal 285, stat.passes
      assert_equal 28, stat.ast
    end

    def test_maps_contested_shooting
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_equal 32, stat.cfgm
      assert_equal 65, stat.cfga
      assert_in_delta 0.492, stat.cfg_pct
    end

    def test_maps_uncontested_shooting
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_equal 10, stat.ufgm
      assert_equal 18, stat.ufga
      assert_in_delta 0.556, stat.ufg_pct
    end

    def test_maps_defended_shooting
      stub_track_request
      stat = BoxScorePlayerTrack.team_stats(game: "0022400001").first

      assert_equal 22, stat.dfgm
      assert_equal 47, stat.dfga
      assert_in_delta 0.468, stat.dfg_pct
    end

    private

    def stub_track_request
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN
        SPD DIST ORBC DRBC RBC TCHS SAST FTAST PASS AST
        CFGM CFGA CFG_PCT UFGM UFGA UFG_PCT DFGM DFGA DFG_PCT]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        4.25, 12.5, 15, 42, 57, 320, 12, 8, 285, 28,
        32, 65, 0.492, 10, 18, 0.556, 22, 47, 0.468]
    end
  end
end
