require_relative "../../test_helper"

module NBA
  class BoxScoreMiscPlayerEdgeCasesTest < Minitest::Test
    cover BoxScoreMisc

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreMisc.player_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoremiscv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreMisc.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoremiscv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreMisc.player_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.player_stats(game: "001").size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayerStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.player_stats(game: "001").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stats = BoxScoreMisc.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stats = BoxScoreMisc.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_handles_missing_game_id
      headers = player_headers.reject { |h| h == "GAME_ID" }
      row = player_row[1..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stat = BoxScoreMisc.player_stats(game: "001").first

      assert_nil stat.game_id
      assert_equal 201_939, stat.player_id
    end

    private

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PTS_OFF_TOV PTS_2ND_CHANCE PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE
        OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 8, 5, 10, 18, 6, 4, 8, 16, 1, 0, 2, 4]
    end
  end
end
