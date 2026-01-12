require_relative "../../test_helper"

module NBA
  class GamesFindEdgeCasesTest < Minitest::Test
    cover Games

    def test_find_returns_nil_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_nil Games.find("0022400001", client: mock_client)
      mock_client.verify
    end

    def test_find_returns_nil_when_no_result_sets
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {resultSets: nil}.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_result_sets_key_missing
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {}.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_game_summary_not_found
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {resultSets: [{name: "Other"}]}.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_no_headers
      response = {resultSets: [{name: "GameSummary", headers: nil, rowSet: [["0022400001"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_headers_key_missing
      response = {resultSets: [{name: "GameSummary", rowSet: [["0022400001"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_no_rows
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_rowset_key_missing
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_returns_nil_when_rowset_is_empty
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID], rowSet: []}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil Games.find("0022400001")
    end

    def test_find_finds_game_summary_when_not_first
      other_set = {name: "LineScore", headers: %w[OTHER], rowSet: [["wrong"]]}
      game_set = {name: "GameSummary", headers: %w[GAME_ID], rowSet: [["0022400001"]]}
      response = {resultSets: [other_set, game_set]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      game = Games.find("0022400001")

      assert_equal "0022400001", game.id
    end

    def test_find_uses_find_not_last_for_result_set
      first_set = {name: "LineScore", headers: %w[OTHER], rowSet: [["wrong1"]]}
      game_set = {name: "GameSummary", headers: %w[GAME_ID], rowSet: [["0022400001"]]}
      last_set = {name: "Officials", headers: %w[OTHER], rowSet: [["wrong2"]]}
      response = {resultSets: [first_set, game_set, last_set]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      game = Games.find("0022400001")

      assert_equal "0022400001", game.id
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      game_set = {name: "GameSummary", headers: %w[GAME_ID], rowSet: [["0022400001"]]}
      response = {resultSets: [unnamed_set, game_set]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      game = Games.find("0022400001")

      assert_equal "0022400001", game.id
    end

    def test_find_handles_missing_game_id_header
      response = {resultSets: [{name: "GameSummary", headers: %w[ARENA], rowSet: [["Chase Center"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      game = Games.find("0022400001")

      assert_nil game.id
      assert_equal "Chase Center", game.arena
    end

    def test_find_uses_first_row
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID], rowSet: [["0022400001"], ["wrong"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      game = Games.find("0022400001")

      assert_equal "0022400001", game.id
    end
  end
end
