require_relative "../../test_helper"

module NBA
  class DraftCombineStatsPlayerAttrTest < Minitest::Test
    cover DraftCombineStats

    def test_parses_season
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "2023-24", DraftCombineStats.all(season: 2019).first.season
    end

    def test_parses_player_id
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftCombineStats.all(season: 2019).first.player_id
    end

    def test_parses_first_name
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "Victor", DraftCombineStats.all(season: 2019).first.first_name
    end

    def test_parses_last_name
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "Wembanyama", DraftCombineStats.all(season: 2019).first.last_name
    end

    def test_parses_player_name
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftCombineStats.all(season: 2019).first.player_name
    end

    def test_parses_position
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal "C", DraftCombineStats.all(season: 2019).first.position
    end

    private

    def response
      {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[SEASON PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION]
    end

    def row
      ["2023-24", 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"]
    end
  end
end
