require_relative "../../test_helper"

module NBA
  class BoxScoreDefensiveV2TeamStatsTest < Minitest::Test
    cover BoxScoreDefensiveV2

    def test_team_stats_returns_collection
      stub_defensive_request

      result = BoxScoreDefensiveV2.team_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_defensive_request

      BoxScoreDefensiveV2.team_stats(game: "0022400001")

      assert_requested :get, /boxscoredefensivev2\?GameID=0022400001/
    end

    def test_team_stats_parses_successfully
      stub_defensive_request

      stats = BoxScoreDefensiveV2.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_sets_game_id
      stub_defensive_request

      stats = BoxScoreDefensiveV2.team_stats(game: "0022400001")

      assert_equal "0022400001", stats.first.game_id
    end

    def test_team_stats_accepts_game_object
      stub_defensive_request
      game = Game.new(id: "0022400001")

      BoxScoreDefensiveV2.team_stats(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_team_stats_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_stats_response.to_json, [String]

      BoxScoreDefensiveV2.team_stats(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    private

    def stub_defensive_request
      stub_request(:get, /boxscoredefensivev2/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[gameId teamId teamCity teamName teamTricode teamSlug minutes]
    end

    def team_row
      ["0022400001", Team::GSW, "Golden State", "Warriors", "GSW", "warriors", "240:00"]
    end
  end
end
