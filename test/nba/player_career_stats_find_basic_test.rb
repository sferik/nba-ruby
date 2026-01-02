require_relative "../test_helper"

module NBA
  class PlayerCareerStatsFindBasicTest < Minitest::Test
    cover PlayerCareerStats

    def test_find_returns_collection
      stub_career_stats_request

      assert_instance_of Collection, PlayerCareerStats.find(player: 201_939)
    end

    def test_find_uses_correct_player_id_in_path
      stub_career_stats_request

      PlayerCareerStats.find(player: 201_939)

      assert_requested :get, /playercareerstats.*PlayerID=201939/
    end

    def test_find_accepts_player_object
      stub_career_stats_request
      player = Player.new(id: 201_939)

      PlayerCareerStats.find(player: player)

      assert_requested :get, /playercareerstats.*PlayerID=201939/
    end

    def test_find_default_per_mode_is_per_game
      stub_career_stats_request

      PlayerCareerStats.find(player: 201_939)

      assert_requested :get, /playercareerstats.*PerMode=PerGame/
    end

    def test_find_with_totals_per_mode
      stub_career_stats_request

      PlayerCareerStats.find(player: 201_939, per_mode: PlayerCareerStats::TOTALS)

      assert_requested :get, /playercareerstats.*PerMode=Totals/
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
