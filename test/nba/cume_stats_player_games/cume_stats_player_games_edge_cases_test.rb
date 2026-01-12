require_relative "../../test_helper"

module NBA
  class CumeStatsPlayerGamesEdgeCasesTest < Minitest::Test
    cover CumeStatsPlayerGames

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /cumestatsplayergames/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /cumestatsplayergames/).to_return(body: {}.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_no_headers
      response = {resultSets: [{name: "CumeStatsPlayerGames", headers: nil, rowSet: [%w[data data]]}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{name: "CumeStatsPlayerGames", rowSet: [["data"]]}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_no_rows
      response = {resultSets: [{name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID], rowSet: nil}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID]}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_returns_empty_collection_when_rowset_is_empty
      response = {resultSets: [{name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID], rowSet: []}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsPlayerGames.all(player: 201_939, season: 2024).size
    end

    def test_all_finds_result_set_when_not_first
      other_set = {name: "Other", headers: %w[FIELD], rowSet: [["value"]]}
      correct_set = {name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID], rowSet: [["GSW vs. LAL", "0022400001"]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "GSW vs. LAL", entry.matchup
      assert_equal "0022400001", entry.game_id
    end

    def test_all_finds_correct_result_set_by_name
      correct_set = {name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID], rowSet: [["GSW vs. LAL", "0022400001"]]}
      other_set = {name: "Other", headers: %w[FIELD], rowSet: [["value"]]}
      response = {resultSets: [correct_set, other_set]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "GSW vs. LAL", entry.matchup
      assert_equal "0022400001", entry.game_id
    end

    def test_all_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      correct_set = {name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID], rowSet: [["GSW vs. LAL", "0022400001"]]}
      response = {resultSets: [unnamed_set, correct_set]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "GSW vs. LAL", entry.matchup
      assert_equal "0022400001", entry.game_id
    end

    def test_all_handles_nil_values_in_response
      response = {resultSets: [{name: "CumeStatsPlayerGames", headers: %w[MATCHUP GAME_ID], rowSet: [[nil, nil]]}]}
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)

      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_nil entry.matchup
      assert_nil entry.game_id
    end
  end
end
