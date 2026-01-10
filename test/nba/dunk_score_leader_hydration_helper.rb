require_relative "../test_helper"

module NBA
  module DunkScoreLeaderHydrationHelper
    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/)
        .to_return(body: player_info_response.to_json)
    end

    def stub_team_details_request
      stub_request(:get, /teamdetails/)
        .to_return(body: team_details_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT WEIGHT SCHOOL COUNTRY
                       DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER],
                     rowSet: [[1_631_094, "Paolo Banchero", "Paolo", "Banchero", "Active", "5", "6-10", "250", "Duke", "USA", 2022, 1,
                       1]]}]}
    end

    def team_details_response
      {resultSets: [{name: "TeamBackground",
                     headers: %w[TEAM_ID ABBREVIATION NICKNAME YEARFOUNDED CITY ARENA ARENACAPACITY OWNER GENERALMANAGER HEADCOACH],
                     rowSet: [[Team::ORL, "ORL", "Magic", 1989, "Orlando", "Amway Center", 18_846, "ORLANDO MAGIC LTD", "Jeff Weltman",
                       "Jamahl Mosley"]]}]}
    end
  end
end
