require_relative "../test_helper"

module NBA
  class LeagueGameLogPlayerMissingKeyTest < Minitest::Test
    cover LeagueGameLog

    def test_player_logs_raises_key_error_when_name_key_missing
      response = {resultSets: [{headers: player_log_headers, rowSet: [player_log_row]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_raises(KeyError) { LeagueGameLog.player_logs(season: 2024) }
    end

    def test_player_logs_raises_key_error_when_season_id_missing
      headers = %w[PLAYER_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A
        FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
      row = [201_939, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 34, 11, 22, 0.500,
        5, 12, 0.417, 6, 6, 1.0, 0, 5, 5, 7, 2, 0, 3, 2, 33, 15]
      response = {resultSets: [{name: "LeagueGameLog", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_raises(KeyError) { LeagueGameLog.player_logs(season: 2024) }
    end

    private

    def player_log_headers
      %w[SEASON_ID PLAYER_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A
        FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def player_log_row
      ["22024", 201_939, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 34, 11, 22, 0.500,
        5, 12, 0.417, 6, 6, 1.0, 0, 5, 5, 7, 2, 0, 3, 2, 33, 15]
    end
  end
end
