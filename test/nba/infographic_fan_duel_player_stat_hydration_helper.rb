require_relative "../test_helper"

module NBA
  module InfographicFanDuelPlayerStatHydrationHelper
    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/)
        .to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                     rowSet: [[201_939, "Stephen Curry"]]}]}
    end

    def stub_team_details_request
      stub_request(:get, /teamdetails/)
        .to_return(body: team_details_response.to_json)
    end

    def team_details_response
      {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID CITY NICKNAME ABBREVIATION],
                     rowSet: [[Team::GSW, "Golden State", "Warriors", "GSW"]]}]}
    end

    def stub_box_score_summary_request(game_id)
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID],
                                rowSet: [[game_id, Team::GSW, Team::LAL]]}]}
      stub_request(:get, /boxscoresummaryv2.*GameID=#{game_id}/).to_return(body: response.to_json)
    end
  end
end
