require_relative "../test_helper"

module NBA
  class VideoDetailsAssetMissingKeysTest < Minitest::Test
    cover VideoDetailsAsset

    def test_find_handles_missing_uuid_key
      headers = all_headers.reject { |h| h.eql?("UUID") }
      row = build_row_without("UUID")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.uuid
    end

    def test_find_handles_missing_game_id_key
      headers = all_headers.reject { |h| h.eql?("GAME_ID") }
      row = build_row_without("GAME_ID")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.game_id
    end

    def test_find_handles_missing_game_event_id_key
      headers = all_headers.reject { |h| h.eql?("GAME_EVENT_ID") }
      row = build_row_without("GAME_EVENT_ID")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.game_event_id
    end

    def test_find_handles_missing_video_available_key
      headers = all_headers.reject { |h| h.eql?("VIDEO_AVAILABLE") }
      row = build_row_without("VIDEO_AVAILABLE")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.video_available
    end

    def test_find_handles_missing_video_url_key
      headers = all_headers.reject { |h| h.eql?("VIDEO_URL") }
      row = build_row_without("VIDEO_URL")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.video_url
    end

    def test_find_handles_missing_file_size_key
      headers = all_headers.reject { |h| h.eql?("FILE_SIZE") }
      row = build_row_without("FILE_SIZE")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.file_size
    end

    def test_find_handles_missing_aspect_ratio_key
      headers = all_headers.reject { |h| h.eql?("ASPECT_RATIO") }
      row = build_row_without("ASPECT_RATIO")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.aspect_ratio
    end

    def test_find_handles_missing_video_duration_key
      headers = all_headers.reject { |h| h.eql?("VIDEO_DURATION") }
      row = build_row_without("VIDEO_DURATION")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.video_duration
    end

    def test_find_handles_missing_video_description_key
      headers = all_headers.reject { |h| h.eql?("VIDEO_DESCRIPTION") }
      row = build_row_without("VIDEO_DESCRIPTION")
      response = {resultSets: [{name: "VideoDetailsAsset", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.video_description
    end

    private

    def all_headers
      %w[UUID GAME_ID GAME_EVENT_ID VIDEO_AVAILABLE VIDEO_URL FILE_SIZE ASPECT_RATIO VIDEO_DURATION
        VIDEO_DESCRIPTION]
    end

    def build_row_without(missing_key)
      all_headers.reject { |h| h.eql?(missing_key) }.map { |h| full_row_data[h] }
    end

    def full_row_data
      {"UUID" => "abc123def456", "GAME_ID" => "0022300001", "GAME_EVENT_ID" => 1, "VIDEO_AVAILABLE" => 1,
       "VIDEO_URL" => "https://videos.nba.com/video.mp4", "FILE_SIZE" => 1_024_000, "ASPECT_RATIO" => "16:9",
       "VIDEO_DURATION" => 12.5, "VIDEO_DESCRIPTION" => "3PT Jump Shot"}
    end
  end
end
