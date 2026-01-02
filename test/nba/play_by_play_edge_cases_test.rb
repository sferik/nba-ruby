require_relative "../test_helper"

module NBA
  class PlayByPlayEdgeCasesTest < Minitest::Test
    cover PlayByPlay

    def test_find_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, PlayByPlay.find(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_when_no_result_sets
      stub_request(:get, /playbyplayv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_returns_empty_when_result_sets_key_missing
      stub_request(:get, /playbyplayv2/).to_return(body: {}.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayByPlay", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayByPlay", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayByPlay", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "PlayByPlay", headers: %w[GAME_ID]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      assert_equal 0, PlayByPlay.find(game: "001").size
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      play_set = {name: "PlayByPlay", headers: %w[GAME_ID], rowSet: [["001"]]}
      response = {resultSets: [unnamed_set, play_set]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_equal "001", play.game_id
    end

    def test_find_finds_correct_result_set_by_name
      other_set = {name: "AvailableVideo", headers: %w[VIDEO_AVAILABLE_FLAG], rowSet: [[1]]}
      play_set = {name: "PlayByPlay", headers: %w[GAME_ID EVENTNUM], rowSet: [["001", 1]]}
      response = {resultSets: [other_set, play_set]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_equal "001", play.game_id
      assert_equal 1, play.event_num
    end

    def test_find_uses_find_not_last_for_result_set
      first_set = {name: "AvailableVideo", headers: %w[VIDEO_AVAILABLE_FLAG], rowSet: [[1]]}
      play_set = {name: "PlayByPlay", headers: %w[GAME_ID EVENTNUM], rowSet: [["001", 1]]}
      last_set = {name: "GameInfo", headers: %w[GAME_ID], rowSet: [["wrong"]]}
      response = {resultSets: [first_set, play_set, last_set]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_equal "001", play.game_id
      assert_equal 1, play.event_num
    end

    def test_find_handles_missing_event_num
      response = {resultSets: [{name: "PlayByPlay", headers: %w[GAME_ID], rowSet: [["001"]]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_nil play.event_num
      assert_equal "001", play.game_id
    end

    def test_find_handles_missing_game_id_header
      response = {resultSets: [{name: "PlayByPlay", headers: %w[EVENTNUM], rowSet: [[1]]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_nil play.game_id
      assert_equal 1, play.event_num
    end
  end
end
