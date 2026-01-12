require_relative "../../test_helper"

module NBA
  class DraftCombinePlayerAnthroMergedAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_merges_all_attribute_groups
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      result = DraftCombinePlayerAnthro.all(season: 2019).first

      assert_equal "Victor Wembanyama", result.player_name
      assert_in_delta(85.5, result.height_wo_shoes)
      assert_in_delta(209.0, result.weight)
    end

    private

    def response
      headers = %w[PLAYER_NAME HEIGHT_WO_SHOES WEIGHT]
      row = ["Victor Wembanyama", 85.5, 209.0]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
