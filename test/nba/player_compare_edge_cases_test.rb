require_relative "../test_helper"

module NBA
  class PlayerCompareEdgeCasesTest < Minitest::Test
    cover PlayerCompare

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = PlayerCompare.compare(player: 1, vs_player: 2, season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /playercompare/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /playercompare/).to_return(body: {}.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "OverallCompare", rowSet: [[1]]}]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "OverallCompare", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: player_headers, rowSet: [player_row]}]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "OverallCompare", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      stats = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "OverallCompare", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "OverallCompare", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      assert_equal 0, PlayerCompare.compare(player: 1, vs_player: 2, season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "OverallCompare", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      stats = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "OverallCompare", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /playercompare/).to_return(body: response.to_json)

      stats = PlayerCompare.compare(player: 201_939, vs_player: 2544, season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    private

    def player_headers
      %w[PLAYER_ID FIRST_NAME LAST_NAME SEASON_ID GP MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS EFF AST_TOV STL_TOV]
    end

    def player_row
      [201_939, "Stephen", "Curry", "2024-25", 72, 34.5, 9.2, 19.8, 0.465, 4.8, 11.2, 0.429,
        5.1, 5.5, 0.927, 0.5, 4.3, 4.8, 5.1, 0.9, 0.4, 3.2, 2.1, 28.3, 28.5, 1.59, 0.28]
    end
  end
end
