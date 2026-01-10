require_relative "../test_helper"

module NBA
  class HustleStatsBoxScorePlayerStatsTest < Minitest::Test
    cover HustleStatsBoxScore

    def test_player_stats_returns_collection
      stub_hustle_request

      result = HustleStatsBoxScore.player_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_hustle_request

      HustleStatsBoxScore.player_stats(game: "0022400001")

      assert_requested :get, /hustlestatsboxscore\?GameID=0022400001/
    end

    def test_player_stats_parses_successfully
      stub_hustle_request

      stats = HustleStatsBoxScore.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_player_stats_sets_game_id
      stub_hustle_request

      stats = HustleStatsBoxScore.player_stats(game: "0022400001")

      assert_equal "0022400001", stats.first.game_id
    end

    def test_player_stats_accepts_game_object
      stub_hustle_request
      game = Game.new(id: "0022400001")

      HustleStatsBoxScore.player_stats(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_player_stats_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, player_stats_response.to_json, [String]

      HustleStatsBoxScore.player_stats(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

    def stub_hustle_request
      stub_request(:get, /hustlestatsboxscore/).to_return(body: player_stats_response.to_json)
    end

    def player_stats_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MINUTES PTS
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
        SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOXOUTS DEF_BOXOUTS]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "", "32:45", 28,
        8, 5, 3, 4, 1, 3, 6, 2, 1, 1, 3, 1, 2]
    end
  end
end
