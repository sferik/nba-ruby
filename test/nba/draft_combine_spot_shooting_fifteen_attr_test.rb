require_relative "../test_helper"

module NBA
  class DraftCombineSpotShootingFifteenAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_parses_fifteen_corner_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_made
    end

    def test_parses_fifteen_corner_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_attempt
    end

    def test_parses_fifteen_corner_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.6, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_left_pct)
    end

    def test_parses_fifteen_break_left_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 4, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_made
    end

    def test_parses_fifteen_break_left_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_attempt
    end

    def test_parses_fifteen_break_left_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.67, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_left_pct)
    end

    def test_parses_fifteen_top_key_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_made
    end

    def test_parses_fifteen_top_key_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_attempt
    end

    def test_parses_fifteen_top_key_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.29, DraftCombineSpotShooting.all(season: 2019).first.fifteen_top_key_pct)
    end

    def test_parses_fifteen_break_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_made
    end

    def test_parses_fifteen_break_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 8, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_attempt
    end

    def test_parses_fifteen_break_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.13, DraftCombineSpotShooting.all(season: 2019).first.fifteen_break_right_pct)
    end

    def test_parses_fifteen_corner_right_made
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_made
    end

    def test_parses_fifteen_corner_right_attempt
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 9, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_attempt
    end

    def test_parses_fifteen_corner_right_pct
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_in_delta(0.56, DraftCombineSpotShooting.all(season: 2019).first.fifteen_corner_right_pct)
    end

    private

    def response
      headers = %w[
        FIFTEEN_CORNER_LEFT_MADE FIFTEEN_CORNER_LEFT_ATTEMPT FIFTEEN_CORNER_LEFT_PCT
        FIFTEEN_BREAK_LEFT_MADE FIFTEEN_BREAK_LEFT_ATTEMPT FIFTEEN_BREAK_LEFT_PCT
        FIFTEEN_TOP_KEY_MADE FIFTEEN_TOP_KEY_ATTEMPT FIFTEEN_TOP_KEY_PCT
        FIFTEEN_BREAK_RIGHT_MADE FIFTEEN_BREAK_RIGHT_ATTEMPT FIFTEEN_BREAK_RIGHT_PCT
        FIFTEEN_CORNER_RIGHT_MADE FIFTEEN_CORNER_RIGHT_ATTEMPT FIFTEEN_CORNER_RIGHT_PCT
      ]
      row = [3, 5, 0.6, 4, 6, 0.67, 2, 7, 0.29, 1, 8, 0.13, 5, 9, 0.56]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
