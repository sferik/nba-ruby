require_relative "../../test_helper"

module NBA
  class DraftCombineStatsPhysicalAttrTest < Minitest::Test
    cover DraftCombineStats

    def test_parses_height_wo_shoes
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 83.5, DraftCombineStats.all(season: 2019).first.height_wo_shoes
    end

    def test_parses_height_wo_shoes_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "6-11.5", DraftCombineStats.all(season: 2019).first.height_wo_shoes_ft_in
    end

    def test_parses_height_w_shoes
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 84.5, DraftCombineStats.all(season: 2019).first.height_w_shoes
    end

    def test_parses_height_w_shoes_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "7-0.5", DraftCombineStats.all(season: 2019).first.height_w_shoes_ft_in
    end

    def test_parses_weight
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 209.0, DraftCombineStats.all(season: 2019).first.weight
    end

    def test_parses_wingspan
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 94.0, DraftCombineStats.all(season: 2019).first.wingspan
    end

    def test_parses_wingspan_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "7-10", DraftCombineStats.all(season: 2019).first.wingspan_ft_in
    end

    def test_parses_standing_reach
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 112.0, DraftCombineStats.all(season: 2019).first.standing_reach
    end

    def test_parses_standing_reach_ft_in
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "9-4", DraftCombineStats.all(season: 2019).first.standing_reach_ft_in
    end

    def test_parses_body_fat_pct
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 6.8, DraftCombineStats.all(season: 2019).first.body_fat_pct
    end

    def test_parses_hand_length
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 9.75, DraftCombineStats.all(season: 2019).first.hand_length
    end

    def test_parses_hand_width
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_in_delta 10.5, DraftCombineStats.all(season: 2019).first.hand_width
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[
        HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN
        WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN
        BODY_FAT_PCT HAND_LENGTH HAND_WIDTH
      ]
    end

    def row
      [83.5, "6-11.5", 84.5, "7-0.5", 209.0, 94.0, "7-10", 112.0, "9-4", 6.8, 9.75, 10.5]
    end
  end
end
