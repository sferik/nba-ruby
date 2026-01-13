require_relative "../../test_helper"

module NBA
  class ScoreboardNilHandlingScoresTest < Minitest::Test
    cover Scoreboard

    def test_returns_nil_for_missing_pts_in_line_score
      response = response_with_missing_score_header("PTS")
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.home_score
      assert_nil game.away_score
    end

    def test_returns_nil_score_when_team_not_found
      response = response_with_mismatched_team_id
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      game = Scoreboard.games.first

      assert_nil game.home_score
    end

    def test_returns_empty_when_headers_missing_in_game_header
      stub_and_verify_empty({resultSets: [{name: "GameHeader", rowSet: []}, line_score_data]})
    end

    def test_returns_empty_when_row_set_missing_in_game_header
      stub_and_verify_empty({resultSets: [{name: "GameHeader", headers: game_headers}, line_score_data]})
    end

    def test_finds_correct_result_set_among_multiple
      response = {resultSets: [
        {name: "Other", headers: ["X"], rowSet: [["Y"]]},
        game_header_data,
        line_score_data
      ]}
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)
      games = Scoreboard.games

      assert_equal 1, games.size
      assert_equal "0022400001", games.first.id
    end

    def test_returns_empty_when_result_set_name_missing
      stub_and_verify_empty({resultSets: [{headers: game_headers, rowSet: [game_row]}, line_score_data]})
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_and_verify_empty({})
    end

    def test_handles_missing_game_id_in_line_score
      line_score = {name: "LineScore", headers: %w[TEAM_ID PTS], rowSet: [[Team::GSW, 112], [Team::LAL, 108]]}
      stub_request(:get, /scoreboardv2/).to_return(body: {resultSets: [game_header_data, line_score]}.to_json)
      game = Scoreboard.games.first

      assert_nil game.home_score
      assert_nil game.away_score
    end

    def test_handles_missing_team_id_in_line_score
      line_score = {name: "LineScore", headers: %w[GAME_ID PTS], rowSet: [["0022400001", 112], ["0022400001", 108]]}
      stub_request(:get, /scoreboardv2/).to_return(body: {resultSets: [game_header_data, line_score]}.to_json)
      game = Scoreboard.games.first

      assert_nil game.home_score
    end

    private

    def stub_and_verify_empty(response)
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def response_with_missing_score_header(header_to_remove)
      headers = score_headers.reject { |h| h == header_to_remove }
      idx = score_headers.index(header_to_remove)
      rows = line_score_rows.map { |row| r = row.dup; r.delete_at(idx) if idx; r } # rubocop:disable Style/Semicolon
      {resultSets: [game_header_data, {name: "LineScore", headers: headers, rowSet: rows}]}
    end

    def response_with_mismatched_team_id
      rows = [["0022400001", 99_999, 112], ["0022400001", Team::LAL, 108]]
      {resultSets: [game_header_data, {name: "LineScore", headers: score_headers, rowSet: rows}]}
    end

    def game_header_data = {name: "GameHeader", headers: game_headers, rowSet: [game_row]}
    def line_score_data = {name: "LineScore", headers: score_headers, rowSet: line_score_rows}
    def score_headers = %w[GAME_ID TEAM_ID PTS]
    def game_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID GAME_STATUS_TEXT VISITOR_TEAM_ID ARENA_NAME]
    def game_row = ["0022400001", "2024-10-22", Team::GSW, 3, "Final", Team::LAL, "Chase Center"]
    def line_score_rows = [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]
  end
end
