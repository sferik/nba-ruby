require_relative "../test_helper"

module NBA
  class TeamGameLogParseCountingTest < Minitest::Test
    cover TeamGameLog

    def test_find_parses_rebound_stats
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 10, log.oreb
      assert_equal 35, log.dreb
      assert_equal 45, log.reb
    end

    def test_find_parses_playmaking_stats
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 28, log.ast
      assert_equal 8, log.stl
      assert_equal 5, log.blk
    end

    def test_find_parses_other_stats
      stub_team_game_log_request

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal 12, log.tov
      assert_equal 18, log.pf
      assert_equal 119, log.pts
      assert_equal 12, log.plus_minus
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
