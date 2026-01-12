require_relative "../../test_helper"

module NBA
  class PlayerCareerStatsParseShootingTest < Minitest::Test
    cover PlayerCareerStats

    def test_find_parses_field_goal_stats
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 8.4, stats.fgm
      assert_in_delta 17.9, stats.fga
      assert_in_delta 0.473, stats.fg_pct
    end

    def test_find_parses_three_point_stats
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 4.8, stats.fg3m
      assert_in_delta 11.7, stats.fg3a
      assert_in_delta 0.408, stats.fg3_pct
    end

    def test_find_parses_free_throw_stats
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 4.5, stats.ftm
      assert_in_delta 4.9, stats.fta
      assert_in_delta 0.915, stats.ft_pct
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
