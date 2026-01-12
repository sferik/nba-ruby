require_relative "../../test_helper"

module NBA
  class TeamDetailsFindTest < Minitest::Test
    cover TeamDetails

    def test_find_returns_team_detail
      stub_team_details_request

      result = TeamDetails.find(team: Team::GSW)

      assert_instance_of TeamDetail, result
    end

    def test_find_uses_correct_team_id_in_path
      stub_team_details_request

      TeamDetails.find(team: Team::GSW)

      assert_requested :get, /teamdetails.*TeamID=#{Team::GSW}/o
    end

    def test_find_accepts_team_object
      stub_team_details_request
      team = Team.new(id: Team::GSW)

      result = TeamDetails.find(team: team)

      assert_instance_of TeamDetail, result
    end

    def test_find_parses_team_detail_successfully
      stub_team_details_request

      detail = TeamDetails.find(team: Team::GSW)

      assert_equal Team::GSW, detail.team_id
      assert_equal "Warriors", detail.nickname
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
