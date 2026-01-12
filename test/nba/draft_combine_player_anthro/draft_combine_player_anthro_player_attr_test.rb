require_relative "../../test_helper"

module NBA
  class DraftCombinePlayerAnthroPlayerAttrTest < Minitest::Test
    cover DraftCombinePlayerAnthro

    def test_parses_temp_player_id
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal 123_456, DraftCombinePlayerAnthro.all(season: 2019).first.temp_player_id
    end

    def test_parses_player_id
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombinePlayerAnthro.all(season: 2019).first.player_id
    end

    def test_parses_first_name
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "Victor", DraftCombinePlayerAnthro.all(season: 2019).first.first_name
    end

    def test_parses_last_name
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "Wembanyama", DraftCombinePlayerAnthro.all(season: 2019).first.last_name
    end

    def test_parses_player_name
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftCombinePlayerAnthro.all(season: 2019).first.player_name
    end

    def test_parses_position
      stub_request(:get, /draftcombineplayeranthro/).to_return(body: response.to_json)

      assert_equal "C", DraftCombinePlayerAnthro.all(season: 2019).first.position
    end

    private

    def response
      headers = %w[TEMP_PLAYER_ID PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION]
      row = [123_456, 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"]
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end
  end
end
