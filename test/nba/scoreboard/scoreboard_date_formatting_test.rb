require_relative "../../test_helper"

module NBA
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
      {name: "GameHeader", headers: game_header_headers, rowSet: [["0022400001", "2024-10-22", Team::GSW, 3, "Final", Team::LAL, "Chase Center"]]}
    end

    def line_score
      {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: [["0022400001", Team::GSW, 112], ["0022400001", Team::LAL, 108]]}
    end

    def game_header_headers = %w[GAME_ID GAME_DATE_EST HOME_TEAM_ID GAME_STATUS_ID GAME_STATUS_TEXT VISITOR_TEAM_ID ARENA_NAME]
  end
end
