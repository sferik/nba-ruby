require_relative "../../test_helper"

module NBA
  class VideoDetailsAssetEdgeCasesTest < Minitest::Test
    cover VideoDetailsAsset

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_sets
      stub_request(:get, /videodetailsasset/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /videodetailsasset/).to_return(body: {}.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_returns_empty_collection_when_no_headers
      response = {resultSets: [{name: "VideoDetailsAsset", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{name: "VideoDetailsAsset", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_returns_empty_collection_when_no_rows
      response = {resultSets: [{name: "VideoDetailsAsset", headers: %w[UUID], rowSet: nil}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{name: "VideoDetailsAsset", headers: %w[UUID]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      assert_equal 0, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).size
    end

    def test_find_finds_result_set_when_not_first
      other_set = {name: "Other", headers: %w[UUID], rowSet: [["wrong"]]}
      correct_set = {name: "VideoDetailsAsset", headers: %w[UUID GAME_ID], rowSet: [%w[abc123 0022300001]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "abc123", entry.uuid
      assert_equal "0022300001", entry.game_id
    end

    def test_find_finds_correct_result_set_by_name
      correct_set = {name: "VideoDetailsAsset", headers: %w[UUID GAME_ID], rowSet: [%w[abc123 0022300001]]}
      other_set = {name: "Other", headers: %w[UUID], rowSet: [["wrong"]]}
      response = {resultSets: [correct_set, other_set]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "abc123", entry.uuid
      assert_equal "0022300001", entry.game_id
    end

    def test_find_handles_missing_uuid_header
      response = {resultSets: [{name: "VideoDetailsAsset", headers: %w[GAME_ID], rowSet: [["0022300001"]]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_nil entry.uuid
      assert_equal "0022300001", entry.game_id
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      asset_set = {name: "VideoDetailsAsset", headers: %w[UUID GAME_ID], rowSet: [%w[abc123 0022300001]]}
      response = {resultSets: [unnamed_set, asset_set]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "abc123", entry.uuid
      assert_equal "0022300001", entry.game_id
    end

    def test_find_handles_missing_game_id_header
      response = {resultSets: [{name: "VideoDetailsAsset", headers: %w[UUID VIDEO_URL],
                                rowSet: [["abc123", "https://videos.nba.com/video.mp4"]]}]}
      stub_request(:get, /videodetailsasset/).to_return(body: response.to_json)

      entry = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023).first

      assert_equal "abc123", entry.uuid
      assert_nil entry.game_id
      assert_equal "https://videos.nba.com/video.mp4", entry.video_url
    end
  end
end
