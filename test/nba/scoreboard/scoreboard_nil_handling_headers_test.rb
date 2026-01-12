require_relative "../../test_helper"

module NBA
  class ScoreboardNilHandlingHeadersTest < Minitest::Test
    cover Scoreboard

    def test_returns_nil_for_missing_game_id
      response = response_with_missing_header("GAME_ID")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.id
    end

    def test_returns_nil_for_missing_game_date_est
      response = response_with_missing_header("GAME_DATE_EST")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.date
    end

    def test_returns_nil_for_missing_home_team_id
      response = response_with_missing_header("HOME_TEAM_ID")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.home_team
    end

    def test_returns_nil_for_missing_visitor_team_id
      response = response_with_missing_header("VISITOR_TEAM_ID")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.away_team
    end

    def test_returns_nil_for_missing_arena_name
      response = response_with_missing_header("ARENA_NAME")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.arena
    end

    def test_returns_nil_for_missing_game_status_id
      response = response_with_missing_header("GAME_STATUS_ID")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_equal "Unknown", game.status
    end

    private

    def response_with_missing_header(header_to_remove)
      headers = game_headers.reject { |h| h == header_to_remove }
      row = game_row.dup
      idx = game_headers.index(header_to_remove)
      row.delete_at(idx) if idx
      {resultSets: [
        {name: "GameHeader", headers: headers, rowSet: [row]},
        line_score_data
      ]}
    end

    def line_score_data
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: line_score_rows}
    end

    def game_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID VISITOR_TEAM_ID ARENA_NAME]
    def game_row = ["0022400001", "2024-10-22", Team::GSW, 3, Team::LAL, "Chase Center"]
    def line_score_rows = [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]
  end
end
