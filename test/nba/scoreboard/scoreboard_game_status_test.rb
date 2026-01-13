require_relative "../../test_helper"

module NBA
  class ScoreboardGameStatusTest < Minitest::Test
    cover Scoreboard

    def test_game_status_uses_status_text_when_present
      stub_scoreboard_with(status_id: 1, status_text: "7:30 pm ET")

      assert_equal "7:30 pm ET", Scoreboard.games.first.status
    end

    def test_game_status_scheduled_when_no_status_text
      stub_scoreboard_with(status_id: 1, status_text: nil)

      assert_equal "Scheduled", Scoreboard.games.first.status
    end

    def test_game_status_in_progress_when_no_status_text
      stub_scoreboard_with(status_id: 2, status_text: nil)

      assert_equal "In Progress", Scoreboard.games.first.status
    end

    def test_game_status_final_when_no_status_text
      stub_scoreboard_with(status_id: 3, status_text: nil)

      assert_equal "Final", Scoreboard.games.first.status
    end

    def test_game_status_unknown_when_no_status_text
      stub_scoreboard_with(status_id: 99, status_text: nil)

      assert_equal "Unknown", Scoreboard.games.first.status
    end

    def test_games_handles_missing_score_data
      stub_scoreboard_with(status_id: 3, status_text: "Final", scores: [])

      game = Scoreboard.games.first

      assert_nil game.home_score
      assert_nil game.away_score
    end

    private

    def stub_scoreboard_with(status_id:, status_text: nil, scores: nil)
      stub_request(:get, /scoreboardv2/).to_return(body: {resultSets: [game_header(status_id, status_text), line_score(scores)]}.to_json)
    end

    def game_header(status_id, status_text)
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, status_id, status_text, Team::LAL, "Chase Center"]]}
    end

    def line_score(scores)
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: scores || [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID GAME_STATUS_TEXT VISITOR_TEAM_ID ARENA_NAME]
  end
end
