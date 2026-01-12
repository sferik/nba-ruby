require_relative "../../test_helper"

module NBA
  class LeagueGameFinderTest < Minitest::Test
    cover LeagueGameFinder

    def test_by_team_returns_collection
      stub_team_game_finder_request

      assert_instance_of Collection, LeagueGameFinder.by_team(team: Team::GSW)
    end

    def test_by_team_parses_basic_identity_attributes
      stub_team_game_finder_request
      game = team_game

      assert_equal "22024", game.season_id
      assert_equal Team::GSW, game.team_id
      assert_equal "GSW", game.team_abbreviation
      assert_equal "Warriors", game.team_name
      assert_equal "0022400001", game.game_id
    end

    def test_by_team_parses_game_details
      stub_team_game_finder_request
      game = team_game

      assert_equal "2024-10-22", game.game_date
      assert_equal "GSW vs. LAL", game.matchup
      assert_equal "W", game.wl
      assert_equal 240, game.min
    end

    def test_by_team_parses_field_goal_attributes
      stub_team_game_finder_request
      game = team_game

      assert_equal 42, game.fgm
      assert_equal 88, game.fga
      assert_in_delta 0.477, game.fg_pct
      assert_equal 15, game.fg3m
      assert_equal 38, game.fg3a
    end

    def test_by_team_parses_free_throw_attributes
      stub_team_game_finder_request
      game = team_game

      assert_in_delta 0.395, game.fg3_pct
      assert_equal 13, game.ftm
      assert_equal 16, game.fta
      assert_in_delta 0.813, game.ft_pct
    end

    def test_by_team_parses_rebound_and_scoring_attributes
      stub_team_game_finder_request
      game = team_game

      assert_equal 112, game.pts
      assert_equal 10, game.oreb
      assert_equal 35, game.dreb
      assert_equal 45, game.reb
      assert_equal 4, game.plus_minus
    end

    def test_by_team_parses_other_counting_attributes
      stub_team_game_finder_request
      game = team_game

      assert_equal 28, game.ast
      assert_equal 8, game.stl
      assert_equal 5, game.blk
      assert_equal 12, game.tov
      assert_equal 18, game.pf
    end

    def test_by_player_returns_collection
      stub_player_game_finder_request

      assert_instance_of Collection, LeagueGameFinder.by_player(player: 201_939)
    end

    def test_by_player_parses_game_data
      stub_player_game_finder_request
      game = LeagueGameFinder.by_player(player: 201_939).first

      assert_equal "0022400001", game.game_id
      assert_equal 32, game.pts
    end

    private

    def team_game
      LeagueGameFinder.by_team(team: Team::GSW).first
    end

    def stub_team_game_finder_request
      stub_request(:get, /leaguegamefinder.*TeamID=#{Team::GSW}/o)
        .to_return(body: team_game_finder_response.to_json)
    end

    def stub_player_game_finder_request
      stub_request(:get, /leaguegamefinder.*PlayerID=201939/)
        .to_return(body: player_game_finder_response.to_json)
    end

    def team_game_finder_response
      {resultSets: [{name: "TeamGameFinderResults", headers: team_game_finder_headers,
                     rowSet: [team_game_row]}]}
    end

    def player_game_finder_response
      {resultSets: [{name: "PlayerGameFinderResults", headers: team_game_finder_headers,
                     rowSet: [player_game_row]}]}
    end

    def team_game_finder_headers
      %w[SEASON_ID TEAM_ID TEAM_ABBREVIATION TEAM_NAME GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA
        FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def team_game_row
      ["22024", Team::GSW, "GSW", "Warriors", "0022400001", "2024-10-22", "GSW vs. LAL", "W", 240, 42,
        88, 0.477, 15, 38, 0.395, 13, 16, 0.813, 10, 35, 45, 28, 8, 5, 12, 18, 112, 4]
    end

    def player_game_row
      ["22024", Team::GSW, "GSW", "Warriors", "0022400001", "2024-10-22", "GSW vs. LAL", "W", 36, 11,
        22, 0.500, 6, 12, 0.500, 4, 4, 1.000, 1, 4, 5, 8, 2, 0, 3, 2, 32, 12]
    end
  end
end
