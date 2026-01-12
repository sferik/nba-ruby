require_relative "../../test_helper"

module NBA
  class PlayerCareerByCollegeRollupWestTest < Minitest::Test
    cover PlayerCareerByCollegeRollup

    def test_west_parses_gp
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_equal 966, stat.gp
    end

    def test_west_parses_min
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_in_delta 31_000.0, stat.min
    end

    def test_west_parses_shooting_stats
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_in_delta 8000.0, stat.fgm
      assert_in_delta 16_000.0, stat.fga
      assert_in_delta 0.5, stat.fg_pct
    end

    def test_west_parses_three_point_stats
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_in_delta 3500.0, stat.fg3m
      assert_in_delta 8500.0, stat.fg3a
      assert_in_delta 0.412, stat.fg3_pct
    end

    def test_west_parses_free_throw_stats
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_in_delta 4500.0, stat.ftm
      assert_in_delta 4900.0, stat.fta
      assert_in_delta 0.918, stat.ft_pct
    end

    def test_west_parses_counting_stats
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_in_delta 700.0, stat.oreb
      assert_in_delta 4200.0, stat.dreb
      assert_in_delta 4900.0, stat.reb
      assert_in_delta 5800.0, stat.ast
    end

    def test_west_parses_other_counting_stats
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_in_delta 1400.0, stat.stl
      assert_in_delta 300.0, stat.blk
      assert_in_delta 2600.0, stat.tov
      assert_in_delta 2000.0, stat.pf
      assert_in_delta 24_000.0, stat.pts
    end

    def test_west_with_per_game_mode
      stub_request(:get, /PerModeSimple=PerGame/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.west(per_mode: PlayerCareerByCollegeRollup::PER_GAME)

      assert_requested :get, /PerModeSimple=PerGame/
    end

    def test_west_defaults_to_totals_mode
      stub_request(:get, /PerModeSimple=Totals/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.west

      assert_requested :get, /PerModeSimple=Totals/
    end

    def test_west_with_season_filter
      stub_request(:get, /SeasonNullable=2023-24/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.west(season: "2023-24")

      assert_requested :get, /SeasonNullable=2023-24/
    end

    private

    def stub_rollup_request
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: rollup_response.to_json)
    end

    def rollup_headers
      %w[PLAYER_ID PLAYER_NAME COLLEGE GP MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def rollup_response
      {resultSets: [
        {name: "East", headers: rollup_headers, rowSet: [rollup_row]},
        {name: "Midwest", headers: rollup_headers, rowSet: [rollup_row]},
        {name: "South", headers: rollup_headers, rowSet: [rollup_row]},
        {name: "West", headers: rollup_headers, rowSet: [rollup_row]}
      ]}
    end

    def rollup_row
      [201_939, "Stephen Curry", "Davidson", 966, 31_000.0,
        8000.0, 16_000.0, 0.5, 3500.0, 8500.0, 0.412,
        4500.0, 4900.0, 0.918, 700.0, 4200.0, 4900.0,
        5800.0, 1400.0, 300.0, 2600.0, 2000.0, 24_000.0]
    end
  end
end
