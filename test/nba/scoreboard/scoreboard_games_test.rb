require_relative "../../test_helper"

module NBA
  class ScoreboardGamesTest < Minitest::Test
    cover Scoreboard

    def test_games_returns_collection
      stub_scoreboard_request

      assert_instance_of Collection, Scoreboard.games
    end

    def test_games_parses_game_id_and_date
      stub_scoreboard_request

      game = Scoreboard.games.first

      assert_equal "0022400001", game.id
      assert_equal "2024-10-22", game.date
    end

    def test_games_parses_game_status_and_arena
      stub_scoreboard_request

      game = Scoreboard.games.first

      assert_equal "Final", game.status
      assert_equal "Chase Center", game.arena
    end

    def test_games_parses_team_data
      stub_scoreboard_request

      game = Scoreboard.games.first

      assert_instance_of Team, game.home_team
      assert_equal Team::GSW, game.home_team.id
      assert_instance_of Team, game.away_team
      assert_equal Team::LAL, game.away_team.id
    end

    def test_games_parses_scores
      stub_scoreboard_request

      game = Scoreboard.games.first

      assert_equal 112, game.home_score
      assert_equal 108, game.away_score
    end

    def test_games_with_custom_date
      stub_request(:get, /scoreboardv2.*GameDate=2024-01-15/).to_return(body: scoreboard_response.to_json)

      Scoreboard.games(date: Date.new(2024, 1, 15))

      assert_requested :get, /scoreboardv2.*GameDate=2024-01-15/
    end

    def test_games_deduplicates_by_game_id
      stub_request(:get, /scoreboardv2/).to_return(body: duplicate_games_response.to_json)

      games = Scoreboard.games

      assert_equal 1, games.size
      assert_equal "0022400001", games.first.id
    end

    def test_games_deduplicates_by_game_id_with_different_status
      stub_request(:get, /scoreboardv2/).to_return(body: duplicate_games_different_status_response.to_json)

      games = Scoreboard.games

      assert_equal 1, games.size
      assert_equal "0022400001", games.first.id
    end

    private

    def stub_scoreboard_request
      stub_request(:get, /scoreboardv2/).to_return(body: scoreboard_response.to_json)
    end

    def scoreboard_response
      {resultSets: [game_header_result_set, line_score_result_set]}
    end

    def game_header_result_set
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, 3, "Final", Team::LAL, "Chase Center"]]}
    end

    def line_score_result_set
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]}
    end

    def duplicate_games_response
      {resultSets: [duplicate_game_header_result_set, line_score_result_set]}
    end

    def duplicate_game_header_result_set
      {name: "GameHeader", headers: game_header_headers, rowSet: [
        ["0022400001", "2024-10-22", Team::GSW, 1, "7:30 pm ET", Team::LAL, "Chase Center"],
        ["0022400001", "2024-10-22", Team::GSW, 1, "7:30 pm ET", Team::LAL, "Chase Center"]
      ]}
    end

    def duplicate_games_different_status_response
      {resultSets: [duplicate_game_header_different_status_result_set, line_score_result_set]}
    end

    def duplicate_game_header_different_status_result_set
      {name: "GameHeader", headers: game_header_headers, rowSet: [
        ["0022400001", "2024-10-22", Team::GSW, 1, "7:30 pm ET", Team::LAL, "Chase Center"],
        ["0022400001", "2024-10-22", Team::GSW, 3, "Final", Team::LAL, "Chase Center"]
      ]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID GAME_STATUS_TEXT VISITOR_TEAM_ID ARENA_NAME]
  end
end
