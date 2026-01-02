require_relative "../test_helper"

module NBA
  class TeamDetailsArenaAttributeMappingTest < Minitest::Test
    cover TeamDetails

    def test_maps_arena_and_ownership_attributes
      stub_team_details_request

      detail = TeamDetails.find(team: Team::GSW)

      assert_equal "Chase Center", detail.arena
      assert_equal 18_064, detail.arena_capacity
      assert_equal "Joe Lacob", detail.owner
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
