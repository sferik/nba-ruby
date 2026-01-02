require_relative "../test_helper"

module NBA
  class BoxScorePlayerTrackPlayerStatsTest < Minitest::Test
    cover BoxScorePlayerTrack

    def test_player_stats_returns_collection
      stub_player_track_request

      result = BoxScorePlayerTrack.player_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_player_track_request

      BoxScorePlayerTrack.player_stats(game: "0022400001")

      assert_requested :get, /boxscoreplayertrackv3\?GameID=0022400001/
    end

    def test_player_stats_parses_successfully
      stub_player_track_request

      stats = BoxScorePlayerTrack.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_player_stats_sets_game_id
      stub_player_track_request

      stats = BoxScorePlayerTrack.player_stats(game: "0022400001")

      assert_equal "0022400001", stats.first.game_id
    end

    def test_player_stats_accepts_game_object
      stub_player_track_request
      game = Game.new(id: "0022400001")

      BoxScorePlayerTrack.player_stats(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_player_stats_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, player_stats_response.to_json, [String]

      BoxScorePlayerTrack.player_stats(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

    def stub_player_track_request
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MIN
        SPD DIST ORBC DRBC RBC TCHS SAST FTAST PASS AST CFGM CFGA CFG_PCT UFGM UFGA UFG_PCT
        DFGM DFGA DFG_PCT]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "", "32:45",
        4.52, 2.67, 5, 12, 17, 65, 2, 1, 42, 8, 3, 8, 0.375, 5, 6, 0.833, 4, 10, 0.400]
    end
  end
end
