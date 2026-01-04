require_relative "../test_helper"

module NBA
  class CommonPlayoffSeriesEdgeCasesTest < Minitest::Test
    cover CommonPlayoffSeries

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CommonPlayoffSeries.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /commonplayoffseries/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /commonplayoffseries/).to_return(body: {}.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayoffSeries", rowSet: [[1]]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PlayoffSeries", headers: %w[GAME_ID]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: series_headers, rowSet: [series_row]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "PlayoffSeries", headers: series_headers, rowSet: [series_row]}
      ]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024)

      assert_equal 1, series.size
      assert_equal "0042400101", series.first.game_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayoffSeries", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayoffSeries", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      assert_equal 0, CommonPlayoffSeries.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayoffSeries", headers: series_headers, rowSet: [series_row]}
      ]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024)

      assert_equal 1, series.size
      assert_equal "0042400101", series.first.game_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayoffSeries", headers: series_headers, rowSet: [series_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024)

      assert_equal 1, series.size
      assert_equal "0042400101", series.first.game_id
    end

    private

    def series_headers
      %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID SERIES_ID GAME_NUM]
    end

    def series_row
      ["0042400101", Team::BOS, Team::MIA, "0042400100", 1]
    end
  end
end
