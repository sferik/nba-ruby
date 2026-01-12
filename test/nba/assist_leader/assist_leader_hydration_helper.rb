require_relative "../../test_helper"

module NBA
  module AssistLeaderHydrationHelper
    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/)
        .to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_566, "Russell Westbrook"]]}]}
    end

    def stub_team_details_request
      stub_request(:get, /teamdetails/)
        .to_return(body: team_details_response.to_json)
    end

    def team_details_response
      {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID CITY NICKNAME ABBREVIATION],
                     rowSet: [[Team::LAC, "Los Angeles", "Clippers", "LAC"]]}]}
    end
  end
end
