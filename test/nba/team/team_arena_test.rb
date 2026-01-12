require_relative "../../test_helper"

module NBA
  class TeamArenaTest < Minitest::Test
    cover Team

    def test_arena_returns_arena_from_team_details
      stub_team_details_request
      team = Team.new(id: Team::GSW)

      assert_equal "Chase Center", team.arena
    end

    def test_arena_returns_nil_when_team_details_not_found
      stub_request(:get, /teamdetails/).to_return(body: {resultSets: []}.to_json)
      team = Team.new(id: Team::GSW)

      assert_nil team.arena
    end

    def test_arena_calls_api_with_correct_team_id
      stub_team_details_request
      team = Team.new(id: Team::GSW)

      team.arena

      assert_requested :get, /teamdetails.*TeamID=#{Team::GSW}/o
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
