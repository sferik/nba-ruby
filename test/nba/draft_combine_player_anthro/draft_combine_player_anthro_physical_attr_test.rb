require_relative "../../test_helper"

module NBA
  class DraftCombinePlayerAnthroPhysicalAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_weight
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(209.0, DraftCombinePlayerAnthro.all(season: 2019).first.weight)
    end

    def test_parses_wingspan
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(96.0, DraftCombinePlayerAnthro.all(season: 2019).first.wingspan)
    end

    def test_parses_wingspan_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "8' 0\"", DraftCombinePlayerAnthro.all(season: 2019).first.wingspan_ft_in
    end

    def test_parses_standing_reach
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_in_delta(114.5, DraftCombinePlayerAnthro.all(season: 2019).first.standing_reach)
    end

    def test_parses_standing_reach_ft_in
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "9' 6.5\"", DraftCombinePlayerAnthro.all(season: 2019).first.standing_reach_ft_in
    end

    private

    def response
      headers = %w[WEIGHT WINGSPAN WINGSPAN_FT_IN STANDING_REACH STANDING_REACH_FT_IN]
      row = [209.0, 96.0, "8' 0\"", 114.5, "9' 6.5\""]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
