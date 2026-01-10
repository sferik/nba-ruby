require_relative "../test_helper"

module NBA
  class DraftCombineSpotShootingMergedAttrTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_merges_all_attribute_groups
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      result = DraftCombineSpotShooting.all(season: 2019).first

      assert_equal "Victor Wembanyama", result.player_name
      assert_equal 3, result.fifteen_corner_left_made
      assert_equal 4, result.college_corner_left_made
      assert_equal 2, result.nba_corner_left_made
    end

    private

    def response
      headers = %w[PLAYER_NAME FIFTEEN_CORNER_LEFT_MADE COLLEGE_CORNER_LEFT_MADE NBA_CORNER_LEFT_MADE]
      row = ["Victor Wembanyama", 3, 4, 2]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
