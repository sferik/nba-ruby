require_relative "../test_helper"

module NBA
  class PlayerCareerByCollegeMissingCountingKeysTest < Minitest::Test
    cover PlayerCareerByCollege

    def test_handles_missing_oreb
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("OREB").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.oreb
    end

    def test_handles_missing_dreb
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("DREB").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.dreb
    end

    def test_handles_missing_reb
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("REB").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.reb
    end

    def test_handles_missing_ast
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("AST").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.ast
    end

    def test_handles_missing_stl
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("STL").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.stl
    end

    def test_handles_missing_blk
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("BLK").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.blk
    end

    def test_handles_missing_tov
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("TOV").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.tov
    end

    def test_handles_missing_pf
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("PF").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.pf
    end

    def test_handles_missing_pts
      stub_request(:get, /playercareerbycollege/).to_return(body: response_without("PTS").to_json)

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_nil stat.pts
    end

    private

    def all_headers
      %w[PLAYER_ID PLAYER_NAME COLLEGE GP MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS]
    end

    def all_values
      [201_939, "Stephen Curry", "Davidson", 966, 31_000.0,
        8000.0, 16_000.0, 0.5, 3500.0, 8500.0, 0.412,
        4500.0, 4900.0, 0.918, 700.0, 4200.0, 4900.0,
        5800.0, 1400.0, 300.0, 2600.0, 2000.0, 24_000.0]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{headers: headers, rowSet: [values]}]}
    end
  end
end
