require_relative "../test_helper"

module NBA
  class DraftBoardPlayerAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_person_id
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftBoard.all(season: 2023).first.person_id
    end

    def test_parses_player_name
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftBoard.all(season: 2023).first.player_name
    end

    def test_parses_season
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "2023", DraftBoard.all(season: 2023).first.season
    end

    def test_parses_round_number
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1, DraftBoard.all(season: 2023).first.round_number
    end

    def test_parses_round_pick
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1, DraftBoard.all(season: 2023).first.round_pick
    end

    def test_parses_overall_pick
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1, DraftBoard.all(season: 2023).first.overall_pick
    end

    private

    def response
      headers = %w[PERSON_ID PLAYER_NAME SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK]
      row = [1_630_162, "Victor Wembanyama", "2023", 1, 1, 1]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end
end
