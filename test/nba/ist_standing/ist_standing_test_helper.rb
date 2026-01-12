require_relative "../../test_helper"

module NBA
  module IstStandingTestHelper
    def stub_team_details_request
      stub_request(:get, /teamdetails/)
        .to_return(body: team_details_response.to_json)
    end

    def team_details_response
      {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID CITY NICKNAME ABBREVIATION],
                     rowSet: [[Team::LAL, "Los Angeles", "Lakers", "LAL"]]}]}
    end
  end
end
