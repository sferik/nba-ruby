require_relative "../../test_helper"

module NBA
  class HustleStatsBoxScoreAvailableTest < Minitest::Test
    cover HustleStatsBoxScore

    def test_available_returns_true_when_hustle_status_is_one
      stub_available_request(hustle_status: 1)

      assert HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_hustle_status_is_zero
      stub_available_request(hustle_status: 0)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_hustle_status_is_float
      stub_available_request(hustle_status: 1.0)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_uses_correct_game_id_in_path
      stub_available_request(hustle_status: 1)

      HustleStatsBoxScore.available?(game: "0022400001")

      assert_requested :get, /hustlestatsboxscore\?GameID=0022400001/
    end

    def test_available_accepts_game_object
      stub_available_request(hustle_status: 1)
      game = Game.new(id: "0022400001")

      HustleStatsBoxScore.available?(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_available_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, available_response(hustle_status: 1).to_json, [String]

      HustleStatsBoxScore.available?(game: "0022400001", client: mock_client)

      mock_client.verify
    end

    def test_available_returns_false_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      refute HustleStatsBoxScore.available?(game: "0022400001", client: mock_client)
      mock_client.verify
    end

    def test_available_returns_false_when_result_sets_nil
      stub_request(:get, /hustlestatsboxscore/).to_return(body: {resultSets: nil}.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_result_sets_key_missing
      stub_request(:get, /hustlestatsboxscore/).to_return(body: {}.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_hustle_stats_available_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: ["HUSTLE_STATUS"], rowSet: [[1]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_row_set_missing
      response = {resultSets: [{name: "HustleStatsAvailable", headers: ["HUSTLE_STATUS"]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_row_set_empty
      response = {resultSets: [{name: "HustleStatsAvailable", headers: ["HUSTLE_STATUS"], rowSet: []}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_headers_missing
      response = {resultSets: [{name: "HustleStatsAvailable", rowSet: [[1]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_returns_false_when_hustle_status_key_missing
      response = {resultSets: [{name: "HustleStatsAvailable", headers: ["OTHER_KEY"], rowSet: [[1]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_uses_first_row_when_multiple_rows_present
      response = {resultSets: [{name: "HustleStatsAvailable", headers: ["HUSTLE_STATUS"], rowSet: [[1], [0]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert HustleStatsBoxScore.available?(game: "0022400001")
    end

    def test_available_uses_first_row_not_last_row
      response = {resultSets: [{name: "HustleStatsAvailable", headers: ["HUSTLE_STATUS"], rowSet: [[0], [1]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      refute HustleStatsBoxScore.available?(game: "0022400001")
    end

    private

    def stub_available_request(hustle_status:)
      stub_request(:get, /hustlestatsboxscore/).to_return(body: available_response(hustle_status: hustle_status).to_json)
    end

    def available_response(hustle_status:)
      {resultSets: [{name: "HustleStatsAvailable", headers: ["HUSTLE_STATUS"], rowSet: [[hustle_status]]}]}
    end
  end
end
