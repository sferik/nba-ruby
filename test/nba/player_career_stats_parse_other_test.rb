require_relative "../test_helper"

module NBA
  class PlayerCareerStatsParseOtherTest < Minitest::Test
    cover PlayerCareerStats

    def test_find_parses_rebound_stats
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 0.5, stats.oreb
      assert_in_delta 4.0, stats.dreb
      assert_in_delta 4.5, stats.reb
    end

    def test_find_parses_playmaking_stats
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 5.1, stats.ast
      assert_in_delta 0.7, stats.stl
      assert_in_delta 0.4, stats.blk
    end

    def test_find_parses_other_counting_stats
      stub_career_stats_request

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_in_delta 3.0, stats.tov
      assert_in_delta 1.8, stats.pf
      assert_in_delta 26.4, stats.pts
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
