require_relative "../test_helper"

module NBA
  class BoxScorePlayerTrackTeamStatsTest < Minitest::Test
    cover BoxScorePlayerTrack

    def test_team_stats_returns_collection
      stub_player_track_request

      result = BoxScorePlayerTrack.team_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_player_track_request

      BoxScorePlayerTrack.team_stats(game: "0022400001")

      assert_requested :get, /boxscoreplayertrackv3\?GameID=0022400001/
    end

    def test_team_stats_parses_successfully
      stub_player_track_request

      stats = BoxScorePlayerTrack.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_sets_game_id
      stub_player_track_request

      stats = BoxScorePlayerTrack.team_stats(game: "0022400001")

      assert_equal "0022400001", stats.first.game_id
    end

    def test_team_stats_accepts_game_object
      stub_player_track_request
      game = Game.new(id: "0022400001")

      BoxScorePlayerTrack.team_stats(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_team_stats_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_stats_response.to_json, [String]

      BoxScorePlayerTrack.team_stats(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

    def stub_player_track_request
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN SPD DIST ORBC DRBC RBC TCHS
        SAST FTAST PASS AST CFGM CFGA CFG_PCT UFGM UFGA UFG_PCT DFGM DFGA DFG_PCT]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 4.38, 24.5, 35, 45, 80, 350,
        12, 5, 285, 28, 18, 45, 0.400, 24, 35, 0.686, 25, 55, 0.455]
    end
  end
end
