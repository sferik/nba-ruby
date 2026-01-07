require_relative "../test_helper"

module NBA
  class PlayerCareerByCollegeRollupResultSetTest < Minitest::Test
    cover PlayerCareerByCollegeRollup

    def test_east_parses_from_east_result_set
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: east_last_response.to_json)

      stat = PlayerCareerByCollegeRollup.east.first

      assert_equal "East College", stat.college
    end

    def test_midwest_parses_from_midwest_result_set
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: midwest_last_response.to_json)

      stat = PlayerCareerByCollegeRollup.midwest.first

      assert_equal "Midwest College", stat.college
    end

    def test_south_parses_from_south_result_set
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: south_last_response.to_json)

      stat = PlayerCareerByCollegeRollup.south.first

      assert_equal "South College", stat.college
    end

    def test_west_parses_from_west_result_set
      stub_request(:get, /playercareerbycollegerollup/).to_return(body: west_last_response.to_json)

      stat = PlayerCareerByCollegeRollup.west.first

      assert_equal "West College", stat.college
    end

    private

    def rollup_headers
      %w[PLAYER_ID PLAYER_NAME COLLEGE GP MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def east_last_response
      {resultSets: [
        {name: "Midwest", headers: rollup_headers, rowSet: [row_with_college("Midwest College")]},
        {name: "South", headers: rollup_headers, rowSet: [row_with_college("South College")]},
        {name: "West", headers: rollup_headers, rowSet: [row_with_college("West College")]},
        {name: "East", headers: rollup_headers, rowSet: [row_with_college("East College")]}
      ]}
    end

    def midwest_last_response
      {resultSets: [
        {name: "East", headers: rollup_headers, rowSet: [row_with_college("East College")]},
        {name: "South", headers: rollup_headers, rowSet: [row_with_college("South College")]},
        {name: "West", headers: rollup_headers, rowSet: [row_with_college("West College")]},
        {name: "Midwest", headers: rollup_headers, rowSet: [row_with_college("Midwest College")]}
      ]}
    end

    def south_last_response
      {resultSets: [
        {name: "East", headers: rollup_headers, rowSet: [row_with_college("East College")]},
        {name: "Midwest", headers: rollup_headers, rowSet: [row_with_college("Midwest College")]},
        {name: "West", headers: rollup_headers, rowSet: [row_with_college("West College")]},
        {name: "South", headers: rollup_headers, rowSet: [row_with_college("South College")]}
      ]}
    end

    def west_last_response
      {resultSets: [
        {name: "East", headers: rollup_headers, rowSet: [row_with_college("East College")]},
        {name: "Midwest", headers: rollup_headers, rowSet: [row_with_college("Midwest College")]},
        {name: "South", headers: rollup_headers, rowSet: [row_with_college("South College")]},
        {name: "West", headers: rollup_headers, rowSet: [row_with_college("West College")]}
      ]}
    end

    def row_with_college(college)
      [201_939, "Stephen Curry", college, 966, 31_000.0,
        8000.0, 16_000.0, 0.5, 3500.0, 8500.0, 0.412,
        4500.0, 4900.0, 0.918, 700.0, 4200.0, 4900.0,
        5800.0, 1400.0, 300.0, 2600.0, 2000.0, 24_000.0]
    end
  end
end
