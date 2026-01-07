require_relative "../test_helper"

module NBA
  class PlayerCareerByCollegeRollupRegionsTest < Minitest::Test
    cover PlayerCareerByCollegeRollup

    def test_midwest_parses_player_id
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.midwest.first

      assert_equal 201_939, stat.player_id
    end

    def test_south_parses_player_id
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.south.first

      assert_equal 201_939, stat.player_id
    end

    def test_west_parses_player_id
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_equal 201_939, stat.player_id
    end

    def test_midwest_parses_player_name
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.midwest.first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_south_parses_player_name
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.south.first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_west_parses_player_name
      stub_rollup_request

      stat = PlayerCareerByCollegeRollup.west.first

      assert_equal "Stephen Curry", stat.player_name
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
