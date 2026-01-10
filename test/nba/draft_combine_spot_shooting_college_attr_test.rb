require_relative "../test_helper"

module NBA
  class DraftCombineSpotShootingCollegeAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_parses_college_corner_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_made
    end

    def test_parses_college_corner_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_attempt
    end

    def test_parses_college_corner_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.8, DraftCombineSpotShooting.all(season: 2019).first.college_corner_left_pct)
    end

    def test_parses_college_break_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineSpotShooting.all(season: 2019).first.college_break_left_made
    end

    def test_parses_college_break_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineSpotShooting.all(season: 2019).first.college_break_left_attempt
    end

    def test_parses_college_break_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.5, DraftCombineSpotShooting.all(season: 2019).first.college_break_left_pct)
    end

    def test_parses_college_top_key_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineSpotShooting.all(season: 2019).first.college_top_key_made
    end

    def test_parses_college_top_key_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineSpotShooting.all(season: 2019).first.college_top_key_attempt
    end

    def test_parses_college_top_key_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.29, DraftCombineSpotShooting.all(season: 2019).first.college_top_key_pct)
    end

    def test_parses_college_break_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineSpotShooting.all(season: 2019).first.college_break_right_made
    end

    def test_parses_college_break_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 8, DraftCombineSpotShooting.all(season: 2019).first.college_break_right_attempt
    end

    def test_parses_college_break_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.13, DraftCombineSpotShooting.all(season: 2019).first.college_break_right_pct)
    end

    def test_parses_college_corner_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_made
    end

    def test_parses_college_corner_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 9, DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_attempt
    end

    def test_parses_college_corner_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.56, DraftCombineSpotShooting.all(season: 2019).first.college_corner_right_pct)
    end

    private

    def response
      headers = %w[
        COLLEGE_CORNER_LEFT_MADE COLLEGE_CORNER_LEFT_ATTEMPT COLLEGE_CORNER_LEFT_PCT
        COLLEGE_BREAK_LEFT_MADE COLLEGE_BREAK_LEFT_ATTEMPT COLLEGE_BREAK_LEFT_PCT
        COLLEGE_TOP_KEY_MADE COLLEGE_TOP_KEY_ATTEMPT COLLEGE_TOP_KEY_PCT
        COLLEGE_BREAK_RIGHT_MADE COLLEGE_BREAK_RIGHT_ATTEMPT COLLEGE_BREAK_RIGHT_PCT
        COLLEGE_CORNER_RIGHT_MADE COLLEGE_CORNER_RIGHT_ATTEMPT COLLEGE_CORNER_RIGHT_PCT
      ]
      row = [4, 5, 0.8, 3, 6, 0.5, 2, 7, 0.29, 1, 8, 0.13, 5, 9, 0.56]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
