require_relative "../test_helper"

module NBA
  class LeagueGameFinderReboundStatsNilTest < Minitest::Test
    cover LeagueGameFinder

    def test_handles_missing_oreb_key
      response = build_response_without("OREB")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.oreb
    end

    def test_handles_missing_dreb_key
      response = build_response_without("DREB")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.dreb
    end

    def test_handles_missing_reb_key
      response = build_response_without("REB")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.reb
    end

    def test_handles_missing_ast_key
      response = build_response_without("AST")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.ast
    end

    def test_handles_missing_stl_key
      response = build_response_without("STL")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.stl
    end

    def test_handles_missing_blk_key
      response = build_response_without("BLK")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.blk
    end

    def test_handles_missing_tov_key
      response = build_response_without("TOV")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.tov
    end

    def test_handles_missing_pf_key
      response = build_response_without("PF")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.pf
    end

    def test_handles_missing_pts_key
      response = build_response_without("PTS")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.pts
    end

    def test_handles_missing_plus_minus_key
      response = build_response_without("PLUS_MINUS")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.plus_minus
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

    def build_response_without(excluded_key)
      headers = all_headers.reject { |h| h == excluded_key }
      values = all_headers.zip(all_values).reject { |h, _v| h == excluded_key }.map(&:last)
      {resultSets: [{name: "TeamGameFinderResults", headers: headers, rowSet: [values]}]}
    end
  end
end
