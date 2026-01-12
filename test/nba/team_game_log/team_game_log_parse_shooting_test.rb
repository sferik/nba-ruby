require_relative "../../test_helper"

module NBA
  class TeamGameLogParseShootingTest < Minitest::Test
    cover TeamGameLog

    def test_find_parses_field_goal_stats
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 42, log.fgm
      assert_equal 88, log.fga
      assert_in_delta 0.477, log.fg_pct
    end

    def test_find_parses_three_point_stats
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 15, log.fg3m
      assert_equal 40, log.fg3a
      assert_in_delta 0.375, log.fg3_pct
    end

    def test_find_parses_free_throw_stats
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 20, log.ftm
      assert_equal 25, log.fta
      assert_in_delta 0.8, log.ft_pct
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
