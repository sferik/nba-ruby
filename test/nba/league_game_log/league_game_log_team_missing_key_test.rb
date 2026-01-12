require_relative "../../test_helper"

module NBA
  class LeagueGameLogTeamMissingKeyTest < Minitest::Test
    cover LeagueGameLog

    def test_team_logs_returns_empty_when_name_key_missing
      response = {resultSets: [{headers: team_log_headers, rowSet: [team_log_row]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end

    def test_team_logs_raises_key_error_when_team_id_missing
      headers = %w[GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
      row = ["0022400001", "2024-10-22", "GSW vs. LAL", "W", 240, 44, 88, 0.500,
        16, 40, 0.400, 18, 22, 0.818, 10, 35, 45, 30, 8, 5, 12, 20, 122, 12]
      response = {resultSets: [{name: "LeagueGameLog", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_raises(KeyError) { LeagueGameLog.team_logs(season: 2024) }
    end

    private

    def team_log_headers
      %w[TEAM_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def team_log_row
      [Team::GSW, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 240, 44, 88, 0.500,
        16, 40, 0.400, 18, 22, 0.818, 10, 35, 45, 30, 8, 5, 12, 20, 122, 12]
    end
  end
end
