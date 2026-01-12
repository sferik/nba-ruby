module NBA
  module VideoStatusPopulatesHelper
    private

    def stub_video_status_request
      stub_request(:get, /videostatus/).to_return(body: video_status_response.to_json)
    end

    def video_status_response
      {resultSets: [{name: "VideoStatus", headers: all_headers, rowSet: [all_row]}]}
    end

    def all_headers
      %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT
        VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME VISITOR_TEAM_ABBREVIATION
        HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME HOME_TEAM_ABBREVIATION
        IS_AVAILABLE PT_XYZ_AVAILABLE]
    end

    def all_row
      ["0022300001", "2023-10-24", 3, "Final",
        Team::GSW, "Golden State", "Warriors", "GSW",
        Team::LAL, "Los Angeles", "Lakers", "LAL",
        1, 1]
    end
  end
end
