require_relative "../test_helper"

module NBA
  class VideoDetailsFindTest < Minitest::Test
    cover VideoDetails

    def test_find_returns_collection
      stub_video_details_request

      assert_instance_of Collection, VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)
    end

    def test_find_uses_player_parameter
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetails.*PlayerID=201939/
    end

    def test_find_uses_team_parameter
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetails.*TeamID=#{Team::GSW}/o
    end

    def test_find_uses_season_parameter
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetails.*Season=2023-24/
    end

    def test_find_accepts_custom_context_measure
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023, context_measure: "FG3A")

      assert_requested :get, /videodetails.*ContextMeasure=FG3A/
    end

    def test_find_accepts_custom_season_type
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023, season_type: "Playoffs")

      assert_requested :get, /videodetails.*SeasonType=Playoffs/
    end

    def test_find_uses_default_context_measure
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetails.*ContextMeasure=FGA/
    end

    def test_find_uses_default_season_type
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetails.*SeasonType=Regular%20Season/
    end

    def test_find_uses_default_league
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetails.*LeagueID=00/
    end

    def test_find_accepts_league_object
      stub_video_details_request

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023, league: League.new(id: "00"))

      assert_requested :get, /videodetails.*LeagueID=00/
    end

    def test_find_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, video_details_response.to_json, [String]

      VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023, client: mock_client)

      mock_client.verify
    end

    private

    def stub_video_details_request
      stub_request(:get, /videodetails/).to_return(body: video_details_response.to_json)
    end

    def video_details_response
      {resultSets: [{name: "VideoDetails", headers: video_headers, rowSet: [video_row]}]}
    end

    def video_headers
      %w[VIDEO_ID GAME_ID GAME_EVENT_ID PLAYER_ID TEAM_ID DESCRIPTION VIDEO_URLS VIDEO_AVAILABLE]
    end

    def video_row
      ["abc123", "0022300001", 10, 201_939, Team::GSW, "Curry 3PT Jump Shot", "{\"720p\":\"url1\"}", 1]
    end
  end
end
