require_relative "../../test_helper"

module NBA
  class VideoStatusEdgeCasesTest < Minitest::Test
    cover VideoStatus

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24", client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /videostatus/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /videostatus/).to_return(body: {}.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_returns_empty_collection_when_no_headers
      response = {resultSets: [{name: "VideoStatus", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{name: "VideoStatus", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_returns_empty_collection_when_no_rows
      response = {resultSets: [{name: "VideoStatus", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{name: "VideoStatus", headers: %w[GAME_ID]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      assert_equal 0, VideoStatus.all(game_date: "2023-10-24").size
    end

    def test_all_finds_result_set_when_not_first
      other_set = {name: "OtherSet", headers: %w[GAME_ID], rowSet: [%w[0022300999]]}
      correct_set = {name: "VideoStatus", headers: %w[GAME_ID GAME_DATE], rowSet: [%w[0022300001 2023-10-24]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "0022300001", entry.game_id
      assert_equal "2023-10-24", entry.game_date
    end

    def test_all_finds_correct_result_set_by_name
      correct_set = {name: "VideoStatus", headers: %w[GAME_ID GAME_DATE], rowSet: [%w[0022300001 2023-10-24]]}
      other_set = {name: "OtherSet", headers: %w[GAME_ID], rowSet: [%w[0022300999]]}
      response = {resultSets: [correct_set, other_set]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "0022300001", entry.game_id
      assert_equal "2023-10-24", entry.game_date
    end

    def test_all_handles_missing_game_id_header
      response = {resultSets: [{name: "VideoStatus", headers: %w[GAME_DATE], rowSet: [["2023-10-24"]]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_nil entry.game_id
      assert_equal "2023-10-24", entry.game_date
    end

    def test_all_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [%w[wrong]]}
      video_set = {name: "VideoStatus", headers: %w[GAME_ID GAME_DATE], rowSet: [%w[0022300001 2023-10-24]]}
      response = {resultSets: [unnamed_set, video_set]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "0022300001", entry.game_id
      assert_equal "2023-10-24", entry.game_date
    end

    def test_all_handles_missing_home_team_city_header
      response = {resultSets: [{name: "VideoStatus", headers: %w[GAME_ID HOME_TEAM_NAME], rowSet: [%w[0022300001 Lakers]]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)

      entry = VideoStatus.all(game_date: "2023-10-24").first

      assert_equal "0022300001", entry.game_id
      assert_nil entry.home_team_city
      assert_equal "Lakers", entry.home_team_name
    end
  end
end
