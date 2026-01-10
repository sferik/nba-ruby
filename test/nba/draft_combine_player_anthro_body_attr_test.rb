require_relative "../test_helper"

module NBA
  class DraftCombinePlayerAnthroBodyAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_body_fat_pct
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(4.8, DraftCombinePlayerAnthro.all(season: 2019).first.body_fat_pct)
    end

    def test_parses_hand_length
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(10.25, DraftCombinePlayerAnthro.all(season: 2019).first.hand_length)
    end

    def test_parses_hand_width
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(12.0, DraftCombinePlayerAnthro.all(season: 2019).first.hand_width)
    end

    private

    def response
      headers = %w[BODY_FAT_PCT HAND_LENGTH HAND_WIDTH]
      row = [4.8, 10.25, 12.0]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
