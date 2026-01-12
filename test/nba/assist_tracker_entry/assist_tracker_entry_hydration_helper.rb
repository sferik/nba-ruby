module NBA
  module AssistTrackerEntryHydrationHelper
    def stub_player_info_request(player_id:, name:)
      stub_request(:get, /commonplayerinfo/)
        .to_return(body: player_info_response(player_id: player_id, name: name).to_json)
    end

    def player_info_response(player_id:, name:)
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[player_id, name]]}]}
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
