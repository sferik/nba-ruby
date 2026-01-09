require_relative "../test_helper"

module NBA
  class VideoDetailsAssetPopulatesTest < Minitest::Test
    cover VideoDetailsAsset

    def test_find_populates_uuid_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "abc123def456", entry.uuid
    end

    def test_find_populates_game_id_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "0022300001", entry.game_id
    end

    def test_find_populates_game_event_id_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal 1, entry.game_event_id
    end

    def test_find_populates_video_available_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal 1, entry.video_available
    end

    def test_find_populates_video_url_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "https://videos.nba.com/video.mp4", entry.video_url
    end

    def test_find_populates_file_size_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal 1_024_000, entry.file_size
    end

    def test_find_populates_aspect_ratio_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "16:9", entry.aspect_ratio
    end

    def test_find_populates_video_duration_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_in_delta 12.5, entry.video_duration
    end

    def test_find_populates_video_description_from_data
      response = {resultSets: [{name: "VideoDetailsAsset", headers: all_headers, rowSet: [build_full_row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "3PT Jump Shot", entry.video_description
    end

    private

    def all_headers
      %w[UUID GAME_ID GAME_EVENT_ID VIDEO_AVAILABLE VIDEO_URL FILE_SIZE ASPECT_RATIO VIDEO_DURATION
        VIDEO_DESCRIPTION]
    end

    def build_full_row
      ["abc123def456", "0022300001", 1, 1, "https://videos.nba.com/video.mp4", 1_024_000, "16:9", 12.5,
        "3PT Jump Shot"]
    end
  end
end
