require_relative "../../test_helper"

module NBA
  class TeamDetailsIdentityAttributeMappingTest < Minitest::Test
    cover TeamDetails

    def test_maps_team_identity_attributes
      stub_team_details_request

      detail = TeamDetails.find(team: Team::GSW)

      assert_equal Team::GSW, detail.team_id
      assert_equal "GSW", detail.abbreviation
      assert_equal "Warriors", detail.nickname
      assert_equal 1946, detail.year_founded
      assert_equal "Golden State", detail.city
    end

    private

    def stub_team_details_request
      stub_request(:get, /teamdetails/).to_return(body: team_details_response.to_json)
    end

    def team_details_response
      {resultSets: [
        {name: "TeamBackground", headers: detail_headers, rowSet: [detail_row]},
        {name: "TeamHistory", headers: [], rowSet: []}
      ]}
    end

    def detail_headers
      %w[TEAM_ID ABBREVIATION NICKNAME YEARFOUNDED CITY ARENA ARENACAPACITY OWNER
        GENERALMANAGER HEADCOACH DLEAGUEAFFILIATION]
    end

    def detail_row
      [Team::GSW, "GSW", "Warriors", 1946, "Golden State", "Chase Center", 18_064,
        "Joe Lacob", "Mike Dunleavy Jr.", "Steve Kerr", "Santa Cruz Warriors"]
    end
  end
end
