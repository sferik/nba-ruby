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

      assert_equal "Final", game.status
    end

    def test_returns_unknown_status_when_both_status_fields_missing
      response = response_with_missing_headers(%w[GAME_STATUS_ID GAME_STATUS_TEXT])
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_equal "Unknown", game.status
    end

    private

    def response_with_missing_header(header_to_remove)
      response_with_missing_headers([header_to_remove])
    end

    def response_with_missing_headers(headers_to_remove)
      headers = game_headers.reject { |h| headers_to_remove.include?(h) }
      row = game_row.dup
      headers_to_remove.sort_by { |h| game_headers.index(h) || 0 }.reverse_each do |header|
        idx = game_headers.index(header)
        row.delete_at(idx) if idx
      end
      {resultSets: [
        {name: "GameHeader", headers: headers, rowSet: [row]},
        line_score_data
      ]}
    end

    def line_score_data
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: line_score_rows}
    end

    def game_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID GAME_STATUS_TEXT VISITOR_TEAM_ID ARENA_NAME]
    def game_row = ["0022400001", "2024-10-22", Team::GSW, 3, "Final", Team::LAL, "Chase Center"]
    def line_score_rows = [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]
  end
end
