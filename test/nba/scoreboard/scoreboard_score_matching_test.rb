require_relative "../../test_helper"

module NBA
  class ScoreboardScoreMatchingTest < Minitest::Test
    cover Scoreboard

    def test_games_matches_scores_by_game_id
      stub_request(:get, /scoreboardv2/).to_return(body: multi_game_response.to_json)

      games = Scoreboard.games

      assert_equal 2, games.size
      assert_scores games.first, home: 112, away: 108
      assert_scores games.last, home: 99, away: 95
    end

    def test_games_handles_nil_pts
      stub_request(:get, /scoreboardv2/).to_return(body: nil_pts_response.to_json)

      game = Scoreboard.games.first

      assert_nil game.home_score
      assert_nil game.away_score
    end

    def test_games_handles_missing_pts_key
      stub_request(:get, /scoreboardv2/).to_return(body: missing_pts_response.to_json)

      game = Scoreboard.games.first

      assert_nil game.home_score
      assert_nil game.away_score
    end

    private

    def assert_scores(game, home:, away:)
      assert_equal home, game.home_score
      assert_equal away, game.away_score
    end

    def multi_game_response
      {resultSets: [multi_game_header, multi_game_scores]}
    end

    def multi_game_header
      {name: "GameHeader", headers: game_header_headers, rowSet: [game1_row, game2_row]}
    end

    def game1_row = ["GAME1", "2024-10-22", Team::GSW, 3, "Final", Team::LAL, "Chase Center"]

    def game2_row = ["GAME2", "2024-10-22", Team::BOS, 3, "Final", Team::GSW, "TD Garden"]

    def multi_game_scores
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS],
       rowSet: [["GAME1", Team::GSW, 112], ["GAME1", Team::LAL, 108], ["GAME2", Team::BOS, 99], ["GAME2", Team::GSW, 95]]}
    end

    def nil_pts_response
      {resultSets: [scheduled_game_header, nil_scores]}
    end

    def missing_pts_response
      {resultSets: [scheduled_game_header, scores_without_pts]}
    end

    def scheduled_game_header
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, 1, "7:30 pm ET", Team::LAL, "Chase Center"]]}
    end

    def nil_scores
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: [["0022400001", Team::GSW, nil], ["0022400001", Team::LAL, nil]]}
    end

    def scores_without_pts
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID], rowSet: [["0022400001", Team::GSW], ["0022400001", Team::LAL]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID GAME_STATUS_TEXT VISITOR_TEAM_ID ARENA_NAME]
  end
end
