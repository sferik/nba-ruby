require_relative "../test_helper"

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

    private

    def stub_scoreboard_request
      stub_request(:get, /scoreboardv2/).to_return(body: scoreboard_response.to_json)
    end

    def scoreboard_response
      {resultSets: [game_header_result_set, line_score_result_set]}
    end

    def game_header_result_set
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, 3, Team::LAL, "Chase Center"]]}
    end

    def line_score_result_set
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID VISITOR_TEAM_ID ARENA_NAME]
  end

  class ScoreboardEmptyResponseTest < Minitest::Test
    cover Scoreboard

    def test_games_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Scoreboard.games(client: mock_client).size
      mock_client.verify
    end

    def test_games_returns_empty_collection_when_no_game_header
      response = {resultSets: [{name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: []}]}
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_games_returns_empty_collection_when_no_result_sets
      stub_request(:get, /scoreboardv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_games_returns_empty_collection_when_no_line_score
      response = {resultSets: [{name: "GameHeader", headers: %w[GAME_ID], rowSet: [["0022400001"]]}]}
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_games_returns_empty_when_no_header_rows
      stub_request(:get, /scoreboardv2/).to_return(body: no_header_rows_response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_parse_result_set_requires_both_headers_and_rows
      stub_request(:get, /scoreboardv2/).to_return(body: mixed_nil_response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    private

    def no_header_rows_response
      {resultSets: [
        {name: "GameHeader", headers: nil, rowSet: [["0022400001", "2024-10-22", Team::GSW, 3, Team::LAL, "Arena"]]},
        {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: []}
      ]}
    end

    def mixed_nil_response
      {resultSets: [
        {name: "GameHeader", headers: %w[GAME_ID], rowSet: nil},
        {name: "LineScore", headers: nil, rowSet: [["0022400001", Team::GSW, 100]]}
      ]}
    end
  end

  class ScoreboardGameStatusTest < Minitest::Test
    cover Scoreboard

    def test_game_status_scheduled
      stub_scoreboard_with(status_id: 1)

      assert_equal "Scheduled", Scoreboard.games.first.status
    end

    def test_game_status_in_progress
      stub_scoreboard_with(status_id: 2)

      assert_equal "In Progress", Scoreboard.games.first.status
    end

    def test_game_status_unknown
      stub_scoreboard_with(status_id: 99)

      assert_equal "Unknown", Scoreboard.games.first.status
    end

    def test_games_handles_missing_score_data
      stub_scoreboard_with(status_id: 3, scores: [])

      game = Scoreboard.games.first

      assert_nil game.home_score
      assert_nil game.away_score
    end

    private

    def stub_scoreboard_with(status_id:, scores: nil)
      stub_request(:get, /scoreboardv2/).to_return(body: {resultSets: [game_header(status_id), line_score(scores)]}.to_json)
    end

    def game_header(status_id)
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, status_id, Team::LAL, "Chase Center"]]}
    end

    def line_score(scores)
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: scores || [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID VISITOR_TEAM_ID ARENA_NAME]
  end

  class ScoreboardDateFormattingTest < Minitest::Test
    cover Scoreboard

    def test_games_default_date_is_today
      today = Date.today.strftime("%Y-%m-%d")
      stub_request(:get, /scoreboardv2.*GameDate=#{today}/).to_return(body: full_scoreboard_response.to_json)

      Scoreboard.games

      assert_requested :get, /scoreboardv2.*GameDate=#{today}/
    end

    def test_games_formats_date_correctly
      stub_request(:get, /scoreboardv2.*GameDate=2024-03-15/).to_return(body: full_scoreboard_response.to_json)

      Scoreboard.games(date: Date.new(2024, 3, 15))

      assert_requested :get, /scoreboardv2.*GameDate=2024-03-15/
    end

    private

    def full_scoreboard_response
      {resultSets: [game_header, line_score]}
    end

    def game_header
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, 3, Team::LAL, "Chase Center"]]}
    end

    def line_score
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID VISITOR_TEAM_ID ARENA_NAME]
  end

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

    def game1_row = ["GAME1", "2024-10-22", Team::GSW, 3, Team::LAL, "Chase Center"]

    def game2_row = ["GAME2", "2024-10-22", Team::BOS, 3, Team::GSW, "TD Garden"]

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
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, 1, Team::LAL, "Chase Center"]]}
    end

    def nil_scores
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: [["0022400001", Team::GSW, nil], ["0022400001", Team::LAL, nil]]}
    end

    def scores_without_pts
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID], rowSet: [["0022400001", Team::GSW], ["0022400001", Team::LAL]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID VISITOR_TEAM_ID ARENA_NAME]
  end
end
