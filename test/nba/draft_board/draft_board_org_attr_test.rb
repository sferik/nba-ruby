require_relative "../../test_helper"

module NBA
  class DraftBoardOrgAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_organization
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "Metropolitans 92", DraftBoard.all(season: 2023).first.organization
    end

    def test_parses_organization_type
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "International", DraftBoard.all(season: 2023).first.organization_type
    end

    private

    def response
      headers = %w[ORGANIZATION ORGANIZATION_TYPE]
      row = ["Metropolitans 92", "International"]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end
end
