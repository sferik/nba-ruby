require_relative "../../test_helper"

module NBA
  class VideoDetailsPopulatesTest < Minitest::Test
    cover VideoDetails

    def test_populates_video_id
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "abc123", video.video_id
    end

    def test_populates_game_id
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "0022300001", video.game_id
    end

    def test_populates_game_event_id
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal 10, video.game_event_id
    end

    def test_populates_player_id
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal 201_939, video.player_id
    end

    def test_populates_team_id
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal Team::GSW, video.team_id
    end

    def test_populates_description
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "Curry 3PT Jump Shot", video.description
    end

    def test_populates_video_urls
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "{\"720p\":\"url1\"}", video.video_urls
    end

    def test_populates_video_available
      stub_video_details_request

      video = VideoDetails.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal 1, video.video_available
    end

    def test_find_extracts_player_id_from_player_object
      stub_video_details_request
      player = Player.new(id: 201_939)

      VideoDetails.find(player: player, team: Team::GSW, season: 2023)

      assert_requested :get, /PlayerID=201939/
    end

    def test_find_extracts_team_id_from_team_object
      stub_video_details_request
      team = Team.new(id: Team::GSW)

      VideoDetails.find(player: 201_939, team: team, season: 2023)

      assert_requested :get, /TeamID=#{Team::GSW}/o
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
