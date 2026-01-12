require_relative "../../test_helper"

module NBA
  class DraftCombineNonStationaryShootingOnMoveAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_parses_on_move_fifteen_break_left_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 2, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_made
    end

    def test_parses_on_move_fifteen_break_left_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 5, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_attempt
    end

    def test_parses_on_move_fifteen_break_left_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.4, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_left_pct)
    end

    def test_parses_on_move_fifteen_top_key_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 3, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_made
    end

    def test_parses_on_move_fifteen_top_key_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 6, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_attempt
    end

    def test_parses_on_move_fifteen_top_key_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.5, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_top_key_pct)
    end

    def test_parses_on_move_fifteen_break_right_made
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 1, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_made
    end

    def test_parses_on_move_fifteen_break_right_attempt
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_equal 7, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_attempt
    end

    def test_parses_on_move_fifteen_break_right_pct
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      assert_in_delta(0.14, DraftCombineNonStationaryShooting.all(season: 2019).first.on_move_fifteen_break_right_pct)
    end

    private

    def response
      headers = %w[
        ON_MOVE_FIFTEEN_BREAK_LEFT_MADE ON_MOVE_FIFTEEN_BREAK_LEFT_ATTEMPT
        ON_MOVE_FIFTEEN_BREAK_LEFT_PCT ON_MOVE_FIFTEEN_TOP_KEY_MADE
        ON_MOVE_FIFTEEN_TOP_KEY_ATTEMPT ON_MOVE_FIFTEEN_TOP_KEY_PCT
        ON_MOVE_FIFTEEN_BREAK_RIGHT_MADE ON_MOVE_FIFTEEN_BREAK_RIGHT_ATTEMPT
        ON_MOVE_FIFTEEN_BREAK_RIGHT_PCT
      ]
      row = [2, 5, 0.4, 3, 6, 0.5, 1, 7, 0.14]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
