require_relative "../../test_helper"

module NBA
  class PlayerCareerByCollegeTest < Minitest::Test
    cover PlayerCareerByCollege

    def test_find_returns_collection
      stub_college_request

      result = PlayerCareerByCollege.find(college: "Davidson")

      assert_instance_of Collection, result
    end

    def test_find_sends_correct_endpoint
      stub_request(:get, /playercareerbycollege\?College=Duke/).to_return(body: college_response.to_json)

      PlayerCareerByCollege.find(college: "Duke")

      assert_requested :get, /playercareerbycollege\?College=Duke/
    end

    def test_find_with_per_game_mode
      stub_request(:get, /PerModeSimple=PerGame/).to_return(body: college_response.to_json)

      PlayerCareerByCollege.find(college: "Davidson", per_mode: PlayerCareerByCollege::PER_GAME)

      assert_requested :get, /PerModeSimple=PerGame/
    end

    def test_find_defaults_to_totals_mode
      stub_request(:get, /PerModeSimple=Totals/).to_return(body: college_response.to_json)

      PlayerCareerByCollege.find(college: "Davidson")

      assert_requested :get, /PerModeSimple=Totals/
    end

    def test_find_with_season_filter
      stub_request(:get, /SeasonNullable=2023-24/).to_return(body: college_response.to_json)

      PlayerCareerByCollege.find(college: "Davidson", season: "2023-24")

      assert_requested :get, /SeasonNullable=2023-24/
    end

    def test_find_without_season_omits_parameter
      stub_request(:get, /playercareerbycollege/).to_return(body: college_response.to_json)

      PlayerCareerByCollege.find(college: "Davidson", season: nil)

      assert_requested :get, /SeasonTypeAllStar=Regular(%20|\+)Season$/
    end

    def test_find_without_season_does_not_include_season_nullable
      stub_request(:get, /playercareerbycollege/).to_return(body: college_response.to_json)

      PlayerCareerByCollege.find(college: "Davidson", season: nil)

      assert_not_requested :get, /SeasonNullable/
    end

    def test_find_returns_empty_collection_for_nil_response
      stub_request(:get, /playercareerbycollege/).to_return(body: nil)

      result = PlayerCareerByCollege.find(college: "Unknown")

      assert_instance_of Collection, result
      assert_empty result
    end

    private

    def stub_college_request
      stub_request(:get, /playercareerbycollege/).to_return(body: college_response.to_json)
    end

    def college_headers
      %w[PLAYER_ID PLAYER_NAME COLLEGE GP MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def college_response
      {resultSets: [{headers: college_headers, rowSet: [college_row]}]}
    end

    def college_row
      [201_939, "Stephen Curry", "Davidson", 966, 31_000.0,
        8000.0, 16_000.0, 0.5, 3500.0, 8500.0, 0.412,
        4500.0, 4900.0, 0.918, 700.0, 4200.0, 4900.0,
        5800.0, 1400.0, 300.0, 2600.0, 2000.0, 24_000.0]
    end
  end
end
