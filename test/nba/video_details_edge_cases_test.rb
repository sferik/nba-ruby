require_relative "../test_helper"

module NBA
  class VideoDetailsEdgeCasesTest < Minitest::Test
    cover VideoDetails

    def test_find_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_when_no_result_sets
      stub_request(:get, /videodetails/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_returns_empty_when_result_sets_key_missing
      stub_request(:get, /videodetails/).to_return(body: {}.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_returns_empty_when_no_headers
      response = {resultSets: [{name: "VideoDetails", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "VideoDetails", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_returns_empty_when_no_rows
      response = {resultSets: [{name: "VideoDetails", headers: %w[VIDEO_ID], rowSet: nil}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "VideoDetails", headers: %w[VIDEO_ID]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      assert_equal 0, VideoDetails.find(player: 1, team: 1, season: 2023).size
    end

    def test_find_finds_correct_result_set_when_not_first
      other_set = {name: "OtherData", headers: %w[OTHER], rowSet: [["wrong"]]}
      video_set = {name: "VideoDetails", headers: %w[VIDEO_ID GAME_ID], rowSet: [%w[abc123 001]]}
      response = {resultSets: [other_set, video_set]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_equal "abc123", video.video_id
      assert_equal "001", video.game_id
    end

    def test_find_uses_find_not_last_for_result_set
      first_set = {name: "OtherData", headers: %w[OTHER], rowSet: [["wrong"]]}
      video_set = {name: "VideoDetails", headers: %w[VIDEO_ID GAME_ID], rowSet: [%w[abc123 001]]}
      last_set = {name: "MoreData", headers: %w[MORE], rowSet: [["also_wrong"]]}
      response = {resultSets: [first_set, video_set, last_set]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_equal "abc123", video.video_id
      assert_equal "001", video.game_id
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      video_set = {name: "VideoDetails", headers: %w[VIDEO_ID], rowSet: [["abc123"]]}
      response = {resultSets: [unnamed_set, video_set]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_equal "abc123", video.video_id
    end
  end
end
