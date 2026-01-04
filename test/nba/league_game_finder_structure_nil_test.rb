require_relative "../test_helper"

module NBA
  class LeagueGameFinderStructureNilTest < Minitest::Test
    cover LeagueGameFinder

    def test_handles_missing_headers_key
      response = {resultSets: [{name: "TeamGameFinderResults", rowSet: [all_values]}]}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_handles_missing_rowset_key
      response = {resultSets: [{name: "TeamGameFinderResults", headers: all_headers}]}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_handles_missing_name_key_in_result_set
      response = {resultSets: [{headers: all_headers, rowSet: [all_values]}]}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_handles_missing_result_sets_key
      response = {otherKey: "value"}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    private

    def all_headers
      %w[SEASON_ID TEAM_ID TEAM_ABBREVIATION TEAM_NAME GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA
        FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def all_values
      ["22024", Team::GSW, "GSW", "Warriors", "0022400001", "2024-10-22", "GSW vs. LAL", "W", 240, 42,
        88, 0.477, 15, 38, 0.395, 13, 16, 0.813, 10, 35, 45, 28, 8, 5, 12, 18, 112, 4]
    end
  end
end
