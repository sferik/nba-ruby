require_relative "../test_helper"

module NBA
  class TeamGameLogParseGameInfoTest < Minitest::Test
    cover TeamGameLog

    def test_find_parses_team_id
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal Team::GSW, log.team_id
    end

    def test_find_parses_game_id
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal "0022400001", log.game_id
    end

    def test_find_parses_game_date
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal "OCT 22, 2024", log.game_date
    end

    def test_find_parses_matchup
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal "GSW vs. LAL", log.matchup
    end

    def test_find_parses_win_loss
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal "W", log.wl
    end

    def test_find_parses_minutes
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 240, log.min
    end

    private

    def stub_team_game_log_request
      stub_request(:get, /teamgamelog/).to_return(body: team_game_log_response.to_json)
    end

    def team_game_log_response
      {resultSets: [{headers: team_game_log_headers, rowSet: [team_game_log_row]}]}
    end

    def team_game_log_headers
      %w[Team_ID Game_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def team_game_log_row
      [Team::GSW, "0022400001", "OCT 22, 2024", "GSW vs. LAL", "W", 240, 42, 88, 0.477, 15, 40, 0.375, 20, 25, 0.8,
        10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
    end
  end
end
