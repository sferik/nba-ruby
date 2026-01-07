require_relative "../test_helper"

module NBA
  class PlayerCareerByCollegeParsingTest < Minitest::Test
    cover PlayerCareerByCollege

    def test_find_parses_identity_info
      stub_college_request

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "Davidson", stat.college
      assert_equal 966, stat.gp
      assert_in_delta 31_000.0, stat.min
    end

    def test_find_parses_shooting_stats
      stub_college_request

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_in_delta 8000.0, stat.fgm
      assert_in_delta 16_000.0, stat.fga
      assert_in_delta 0.5, stat.fg_pct
    end

    def test_find_parses_three_point_stats
      stub_college_request

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_in_delta 3500.0, stat.fg3m
      assert_in_delta 8500.0, stat.fg3a
      assert_in_delta 0.412, stat.fg3_pct
    end

    def test_find_parses_free_throw_stats
      stub_college_request

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_in_delta 4500.0, stat.ftm
      assert_in_delta 4900.0, stat.fta
      assert_in_delta 0.918, stat.ft_pct
    end

    def test_find_parses_counting_stats
      stub_college_request

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_in_delta 700.0, stat.oreb
      assert_in_delta 4200.0, stat.dreb
      assert_in_delta 4900.0, stat.reb
      assert_in_delta 5800.0, stat.ast
    end

    def test_find_parses_other_counting_stats
      stub_college_request

      stat = PlayerCareerByCollege.find(college: "Davidson").first

      assert_in_delta 1400.0, stat.stl
      assert_in_delta 300.0, stat.blk
      assert_in_delta 2600.0, stat.tov
      assert_in_delta 2000.0, stat.pf
      assert_in_delta 24_000.0, stat.pts
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
