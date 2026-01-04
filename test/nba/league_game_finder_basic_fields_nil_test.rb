require_relative "../test_helper"

module NBA
  class LeagueGameFinderBasicFieldsNilTest < Minitest::Test
    cover LeagueGameFinder

    def test_handles_missing_season_id_key
      response = build_response_without("SEASON_ID")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.season_id
    end

    def test_handles_missing_team_id_key
      response = build_response_without("TEAM_ID")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.team_id
    end

    def test_handles_missing_team_abbreviation_key
      response = build_response_without("TEAM_ABBREVIATION")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.team_abbreviation
    end

    def test_handles_missing_team_name_key
      response = build_response_without("TEAM_NAME")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.team_name
    end

    def test_handles_missing_game_id_key
      response = build_response_without("GAME_ID")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.game_id
    end

    def test_handles_missing_game_date_key
      response = build_response_without("GAME_DATE")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.game_date
    end

    def test_handles_missing_matchup_key
      response = build_response_without("MATCHUP")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.matchup
    end

    def test_handles_missing_wl_key
      response = build_response_without("WL")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.wl
    end

    def test_handles_missing_min_key
      response = build_response_without("MIN")
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      game = LeagueGameFinder.by_team(team: Team::GSW).first

      assert_nil game.min
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
