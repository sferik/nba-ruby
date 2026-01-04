require_relative "../test_helper"

module NBA
  class LeagueGameFinderShootingStatsNilTest < Minitest::Test
    cover LeagueGameFinder

    def test_handles_missing_fgm_key
      response = build_response_without("FGM")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fgm
    end

    def test_handles_missing_fga_key
      response = build_response_without("FGA")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fga
    end

    def test_handles_missing_fg_pct_key
      response = build_response_without("FG_PCT")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fg_pct
    end

    def test_handles_missing_fg3m_key
      response = build_response_without("FG3M")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fg3m
    end

    def test_handles_missing_fg3a_key
      response = build_response_without("FG3A")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fg3a
    end

    def test_handles_missing_fg3_pct_key
      response = build_response_without("FG3_PCT")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fg3_pct
    end

    def test_handles_missing_ftm_key
      response = build_response_without("FTM")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.ftm
    end

    def test_handles_missing_fta_key
      response = build_response_without("FTA")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.fta
    end

    def test_handles_missing_ft_pct_key
      response = build_response_without("FT_PCT")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.ft_pct
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
