require_relative "../test_helper"

module NBA
  class DraftCombinePlayerAnthroHeightAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_height_wo_shoes
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(85.5, DraftCombinePlayerAnthro.all(season: 2019).first.height_wo_shoes)
    end

    def test_parses_height_wo_shoes_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "7' 1.5\"", DraftCombinePlayerAnthro.all(season: 2019).first.height_wo_shoes_ft_in
    end

    def test_parses_height_w_shoes
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(86.5, DraftCombinePlayerAnthro.all(season: 2019).first.height_w_shoes)
    end

    def test_parses_height_w_shoes_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "7' 2.5\"", DraftCombinePlayerAnthro.all(season: 2019).first.height_w_shoes_ft_in
    end

    private

    def response
      headers = %w[HEIGHT_WO_SHOES HEIGHT_WO_SHOES_FT_IN HEIGHT_W_SHOES HEIGHT_W_SHOES_FT_IN]
      row = [85.5, "7' 1.5\"", 86.5, "7' 2.5\""]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
