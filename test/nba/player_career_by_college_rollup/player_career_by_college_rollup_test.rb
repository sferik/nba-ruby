require_relative "../../test_helper"

module NBA
  class PlayerCareerByCollegeRollupTest < Minitest::Test
    cover PlayerCareerByCollegeRollup

    def test_east_returns_collection
      stub_rollup_request

      result = PlayerCareerByCollegeRollup.east

      assert_instance_of Collection, result
    end

    def test_east_sends_correct_endpoint
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.east

      assert_requested :get, /playercareerbycollegerollup/
    end

    def test_midwest_returns_collection
      stub_rollup_request

      result = PlayerCareerByCollegeRollup.midwest

      assert_instance_of Collection, result
    end

    def test_south_returns_collection
      stub_rollup_request

      result = PlayerCareerByCollegeRollup.south

      assert_instance_of Collection, result
    end

    def test_west_returns_collection
      stub_rollup_request

      result = PlayerCareerByCollegeRollup.west

      assert_instance_of Collection, result
    end

    def test_east_parses_identity_info
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.east.first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "Davidson", stat.college
    end

    def test_east_with_per_game_mode
      stub_request(:get, /PerModeSimple=PerGame/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.east(per_mode: PlayerCareerByCollegeRollup::PER_GAME)

      assert_requested :get, /PerModeSimple=PerGame/
    end

    def test_east_defaults_to_totals_mode
      stub_request(:get, /PerModeSimple=Totals/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.east

      assert_requested :get, /PerModeSimple=Totals/
    end

    def test_east_with_season_filter
      stub_request(:get, /SeasonNullable=2023-24/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.east(season: "2023-24")

      assert_requested :get, /SeasonNullable=2023-24/
    end

    def test_east_without_season_does_not_include_season_nullable
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: rollup_response.to_json)

      PlayerCareerByCollegeRollup.east(season: nil)

      assert_not_requested :get, /SeasonNullable/
    end

    def test_east_returns_empty_collection_for_nil_response
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: nil)

      result = PlayerCareerByCollegeRollup.east

      assert_instance_of Collection, result
      assert_empty result
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
