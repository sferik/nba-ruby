require_relative "../../test_helper"

module NBA
  class ScoreboardV3EdgeCasesTest < Minitest::Test
    cover ScoreboardV3

    def test_games_handles_missing_scoreboard
      stub_request(:get, /scoreboardv3/).to_return(body: {}.to_json)

      result = ScoreboardV3.games

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_games_handles_missing_games
      stub_request(:get, /scoreboardv3/).to_return(body: {scoreboard: {}}.to_json)

      result = ScoreboardV3.games

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_games_handles_empty_games
      stub_request(:get, /scoreboardv3/).to_return(body: {scoreboard: {games: []}}.to_json)

      result = ScoreboardV3.games

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_games_handles_missing_game_id
      response = {scoreboard: {games: [{gameStatus: 3, homeTeam: {teamId: Team::LAL, score: 110}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_nil game.id
      assert_equal "Final", game.status
    end

    def test_games_handles_missing_game_time
      response = {scoreboard: {games: [{gameId: "0022400001", gameStatus: 3}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_equal "0022400001", game.id
      assert_nil game.date
    end

    def test_games_handles_missing_game_status
      response = {scoreboard: {games: [{gameId: "0022400001"}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_equal "0022400001", game.id
      assert_equal "Unknown", game.status
    end

    def test_games_handles_missing_home_team
      response = {scoreboard: {games: [{gameId: "0022400001", awayTeam: {teamId: Team::BOS, score: 105}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_equal "0022400001", game.id
      assert_nil game.home_team
      assert_nil game.home_score
    end

    def test_games_handles_missing_away_team
      response = {scoreboard: {games: [{gameId: "0022400001", homeTeam: {teamId: Team::LAL, score: 110}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_equal "0022400001", game.id
      assert_nil game.away_team
      assert_nil game.away_score
    end

    def test_games_handles_missing_arena
      response = {scoreboard: {games: [{gameId: "0022400001", gameStatus: 3}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_equal "0022400001", game.id
      assert_nil game.arena
    end

    def test_games_handles_empty_response_string
      stub_request(:get, /scoreboardv3/).to_return(body: "")

      result = ScoreboardV3.games

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_games_handles_nil_response
      client = Minitest::Mock.new
      client.expect :get, nil, [String]

      result = ScoreboardV3.games(client: client)

      assert_instance_of Collection, result
      assert_empty result
      client.verify
    end
  end
end
