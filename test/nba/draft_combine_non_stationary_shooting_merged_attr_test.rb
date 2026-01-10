require_relative "../test_helper"

module NBA
  class DraftCombineNonStationaryShootingMergedAttrTest < Minitest::Test
    cover DraftCombineNonStationaryShooting

    def test_merges_all_attribute_groups
      stub_request(:get, /draftcombinenonstationaryshooting/).to_return(body: response.to_json)

      result = DraftCombineNonStationaryShooting.all(season: 2019).first

      assert_equal "Victor Wembanyama", result.player_name
      assert_equal 3, result.off_dribble_fifteen_break_left_made
      assert_equal 2, result.on_move_fifteen_break_left_made
      assert_equal 4, result.off_dribble_college_break_left_made
      assert_equal 1, result.on_move_college_break_left_made
    end

    private

    def response
      headers = %w[
        PLAYER_NAME
        OFF_DRIBBLE_FIFTEEN_BREAK_LEFT_MADE
        ON_MOVE_FIFTEEN_BREAK_LEFT_MADE
        OFF_DRIBBLE_COLLEGE_BREAK_LEFT_MADE
        ON_MOVE_COLLEGE_BREAK_LEFT_MADE
      ]
      row = ["Victor Wembanyama", 3, 2, 4, 1]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
