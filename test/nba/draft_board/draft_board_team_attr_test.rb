require_relative "../../test_helper"

module NBA
  class DraftBoardTeamAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_team_id
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1_610_612_759, DraftBoard.all(season: 2023).first.team_id
    end

    def test_parses_team_city
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "San Antonio", DraftBoard.all(season: 2023).first.team_city
    end

    def test_parses_team_name
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "Spurs", DraftBoard.all(season: 2023).first.team_name
    end

    def test_parses_team_abbreviation
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "SAS", DraftBoard.all(season: 2023).first.team_abbreviation
    end

    private

    def response
      headers = %w[TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION]
      row = [1_610_612_759, "San Antonio", "Spurs", "SAS"]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end
end
