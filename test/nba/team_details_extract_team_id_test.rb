require_relative "../test_helper"

module NBA
  class TeamDetailsExtractTeamIdTest < Minitest::Test
    cover TeamDetails

    def test_find_extracts_team_id_from_integer
      stub_request(:get, /teamdetails/).to_return(body: team_details_response.to_json)

      TeamDetails.find(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_find_extracts_team_id_from_team_object
      stub_request(:get, /teamdetails/).to_return(body: team_details_response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamDetails.find(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_history_extracts_team_id_from_integer
      stub_request(:get, /teamdetails/).to_return(body: team_details_response.to_json)

      TeamDetails.history(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_history_extracts_team_id_from_team_object
      stub_request(:get, /teamdetails/).to_return(body: team_details_response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamDetails.history(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    private

    def team_details_response
      {resultSets: [
        {name: "TeamBackground", headers: [], rowSet: []},
        {name: "TeamHistory", headers: [], rowSet: []}
      ]}
    end
  end
end
