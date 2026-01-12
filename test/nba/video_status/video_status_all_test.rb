require_relative "../../test_helper"

module NBA
  class VideoStatusAllTest < Minitest::Test
    cover VideoStatus

    def test_all_returns_collection
      stub_video_status_request

      assert_instance_of Collection, VideoStatus.all(game_date: "2023-10-24")
    end

    def test_all_uses_game_date_parameter
      stub_video_status_request

      VideoStatus.all(game_date: "2023-10-24")

      assert_requested :get, /videostatus.*GameDate=2023-10-24/
    end

    def test_all_uses_default_league_id
      stub_video_status_request

      VideoStatus.all(game_date: "2023-10-24")

      assert_requested :get, /videostatus.*LeagueID=00/
    end

    def test_all_accepts_custom_league
      stub_video_status_request

      VideoStatus.all(game_date: "2023-10-24", league: "10")

      assert_requested :get, /videostatus.*LeagueID=10/
    end

    def test_all_accepts_league_object
      stub_video_status_request
      league = League.new(id: "10", name: "WNBA")

      VideoStatus.all(game_date: "2023-10-24", league: league)

      assert_requested :get, /videostatus.*LeagueID=10/
    end

    def test_all_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, video_status_response.to_json, [String]

      result = VideoStatus.all(game_date: "2023-10-24", client: mock_client)

      assert_instance_of Collection, result
      mock_client.verify
    end

    private

    def stub_video_status_request
      stub_request(:get, /videostatus/).to_return(body: video_status_response.to_json)
    end

    def video_status_response
      {resultSets: [
        {name: "VideoStatus", headers: video_status_headers, rowSet: [video_status_row]}
      ]}
    end

    def video_status_headers
      %w[GAME_ID GAME_DATE VISITOR_TEAM_ID VISITOR_TEAM_CITY VISITOR_TEAM_NAME
        VISITOR_TEAM_ABBREVIATION HOME_TEAM_ID HOME_TEAM_CITY HOME_TEAM_NAME
        HOME_TEAM_ABBREVIATION GAME_STATUS GAME_STATUS_TEXT IS_AVAILABLE PT_XYZ_AVAILABLE]
    end

    def video_status_row
      ["0022300001", "2023-10-24", Team::GSW, "Golden State", "Warriors",
        "GSW", Team::LAL, "Los Angeles", "Lakers", "LAL", 3, "Final", 1, 1]
    end
  end
end
