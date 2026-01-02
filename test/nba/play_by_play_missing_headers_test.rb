require_relative "../test_helper"

module NBA
  class PlayByPlayMissingHeadersTest < Minitest::Test
    cover PlayByPlay

    def test_find_handles_missing_player2_headers
      response = {resultSets: [{name: "PlayByPlay", headers: minimal_headers, rowSet: [minimal_row]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_equal "001", play.game_id
      assert_nil play.player2_id
      assert_nil play.player2_name
    end

    def test_find_handles_missing_player3_headers
      response = {resultSets: [{name: "PlayByPlay", headers: minimal_headers, rowSet: [minimal_row]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_nil play.player3_id
      assert_nil play.player3_name
    end

    def test_find_handles_missing_description_headers
      response = {resultSets: [{name: "PlayByPlay", headers: %w[GAME_ID EVENTNUM], rowSet: [["001", 1]]}]}
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)

      play = PlayByPlay.find(game: "001").first

      assert_nil play.home_description
      assert_nil play.score
    end

    private

    def minimal_headers
      %w[GAME_ID EVENTNUM PLAYER1_ID PLAYER1_NAME]
    end

    def minimal_row
      ["001", 1, 201_939, "Stephen Curry"]
    end
  end
end
