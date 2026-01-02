require_relative "../test_helper"

module NBA
  class PlayerCareerStatsParseBasicTest < Minitest::Test
    cover PlayerCareerStats

    def test_find_parses_player_id
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal 201_939, stats.player_id
    end

    def test_find_parses_season_id
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal "2024-25", stats.season_id
    end

    def test_find_parses_team_id
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal Team::GSW, stats.team_id
    end

    def test_find_parses_team_abbreviation
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal "GSW", stats.team_abbreviation
    end

    def test_find_parses_player_age
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal 36, stats.player_age
    end

    def test_find_parses_games_played
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal 74, stats.gp
    end

    def test_find_parses_games_started
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal 74, stats.gs
    end

    def test_find_parses_minutes
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 32.7, stats.min
    end

    private

    def stub_career_stats_request
      stub_request(:get, /playercareerstats/).to_return(body: career_stats_response.to_json)
    end

    def career_stats_response
      {resultSets: [{name: "SeasonTotalsRegularSeason", headers: career_stats_headers, rowSet: [career_stats_row]}]}
    end

    def career_stats_headers
      %w[SEASON_ID TEAM_ID TEAM_ABBREVIATION PLAYER_AGE GP GS MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def career_stats_row
      ["2024-25", Team::GSW, "GSW", 36, 74, 74, 32.7, 8.4, 17.9, 0.473, 4.8, 11.7, 0.408, 4.5, 4.9, 0.915,
        0.5, 4.0, 4.5, 5.1, 0.7, 0.4, 3.0, 1.8, 26.4]
    end
  end
end
