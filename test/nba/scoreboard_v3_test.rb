require_relative "../test_helper"

module NBA
  class ScoreboardV3Test < Minitest::Test
    cover ScoreboardV3

    def test_games_returns_collection
      stub_scoreboard_v3_request

      assert_instance_of Collection, ScoreboardV3.games
    end

    def test_games_parses_game_id
      stub_scoreboard_v3_request

      game = ScoreboardV3.games.first

      assert_equal "0022400001", game.id
    end

    def test_games_parses_game_date
      stub_scoreboard_v3_request

      game = ScoreboardV3.games.first

      assert_equal "2024-10-22T23:30:00Z", game.date
    end

    def test_games_parses_game_status_scheduled
      stub_scoreboard_v3_request(game_status: 1)

      game = ScoreboardV3.games.first

      assert_equal "Scheduled", game.status
    end

    def test_games_parses_game_status_in_progress
      stub_scoreboard_v3_request(game_status: 2)

      game = ScoreboardV3.games.first

      assert_equal "In Progress", game.status
    end

    def test_games_parses_game_status_final
      stub_scoreboard_v3_request(game_status: 3)

      game = ScoreboardV3.games.first

      assert_equal "Final", game.status
    end

    def test_games_parses_game_status_unknown
      stub_scoreboard_v3_request(game_status: 99)

      game = ScoreboardV3.games.first

      assert_equal "Unknown", game.status
    end

    def test_games_parses_home_score
      stub_scoreboard_v3_request

      game = ScoreboardV3.games.first

      assert_equal 110, game.home_score
    end

    def test_games_parses_away_score
      stub_scoreboard_v3_request

      game = ScoreboardV3.games.first

      assert_equal 105, game.away_score
    end

    def test_games_parses_arena
      stub_scoreboard_v3_request

      game = ScoreboardV3.games.first

      assert_equal "Crypto.com Arena", game.arena
    end

    private

    def stub_scoreboard_v3_request(game_status: 3)
      stub_request(:get, /scoreboardv3/).to_return(body: scoreboard_v3_response(game_status).to_json)
    end

    def scoreboard_v3_response(game_status)
      {scoreboard: {games: [game_data(game_status)]}}
    end

    def game_data(game_status)
      {gameId: "0022400001", gameTimeUTC: "2024-10-22T23:30:00Z", gameStatus: game_status,
       homeTeam: {teamId: Team::LAL, score: 110}, awayTeam: {teamId: Team::BOS, score: 105},
       arenaName: "Crypto.com Arena"}
    end
  end
end
