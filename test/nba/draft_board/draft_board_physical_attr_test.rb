require_relative "../../test_helper"

module NBA
  class DraftBoardPhysicalAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_height
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "7-4", DraftBoard.all(season: 2023).first.height
    end

    def test_parses_weight
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "210", DraftBoard.all(season: 2023).first.weight
    end

    def test_parses_position
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "C", DraftBoard.all(season: 2023).first.position
    end

    def test_parses_jersey_number
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "1", DraftBoard.all(season: 2023).first.jersey_number
    end

    def test_parses_birthdate
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "2004-01-04", DraftBoard.all(season: 2023).first.birthdate
    end

    def test_parses_age
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_in_delta(19.0, DraftBoard.all(season: 2023).first.age)
    end

    private

    def response
      headers = %w[HEIGHT WEIGHT POSITION JERSEY_NUMBER BIRTHDATE AGE]
      row = ["7-4", "210", "C", "1", "2004-01-04", 19.0]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end
end
