require_relative "../test_helper"

module NBA
  class BoxScoreDefensiveV2PlayerStatsTest < Minitest::Test
    cover BoxScoreDefensiveV2

    def test_player_stats_returns_collection
      stub_defensive_request

      result = BoxScoreDefensiveV2.player_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_defensive_request

      BoxScoreDefensiveV2.player_stats(game: "0022400001")

      assert_requested :get, /boxscoredefensivev2\?GameID=0022400001/
    end

    def test_player_stats_parses_successfully
      stub_defensive_request

      stats = BoxScoreDefensiveV2.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.person_id
    end

    def test_player_stats_sets_game_id
      stub_defensive_request

      stats = BoxScoreDefensiveV2.player_stats(game: "0022400001")

      assert_equal "0022400001", stats.first.game_id
    end

    def test_player_stats_accepts_game_object
      stub_defensive_request
      game = Game.new(id: "0022400001")

      BoxScoreDefensiveV2.player_stats(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_player_stats_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, player_stats_response.to_json, [String]

      BoxScoreDefensiveV2.player_stats(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

    def stub_defensive_request
      stub_request(:get, /boxscoredefensivev2/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[gameId teamId teamCity teamName teamTricode teamSlug personId firstName familyName
        nameI playerSlug position comment jerseyNum matchupMinutes partialPossessions
        switchesOn playerPoints defensiveRebounds matchupAssists matchupTurnovers steals
        blocks matchupFieldGoalsMade matchupFieldGoalsAttempted matchupFieldGoalPercentage
        matchupThreePointersMade matchupThreePointersAttempted matchupThreePointerPercentage]
    end

    def player_row
      ["0022400001", Team::GSW, "Golden State", "Warriors", "GSW", "warriors", 201_939,
        "Stephen", "Curry", "S. Curry", "stephen-curry", "G", "", "30", 24.5, 15.2, 8,
        12, 5, 3, 2, 2, 1, 5, 12, 0.417, 2, 5, 0.4]
    end
  end
end
