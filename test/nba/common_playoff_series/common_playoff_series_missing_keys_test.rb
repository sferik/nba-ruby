require_relative "../../test_helper"

module NBA
  class CommonPlayoffSeriesMissingKeysTest < Minitest::Test
    cover CommonPlayoffSeries

    def test_handles_missing_game_id
      headers = series_headers_without("GAME_ID")
      row = series_row_without_index(0)
      response = {resultSets: [{name: "PlayoffSeries", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024).first

      assert_nil series.game_id
      assert_equal Team::BOS, series.home_team_id
    end

    def test_handles_missing_home_team_id
      headers = series_headers_without("HOME_TEAM_ID")
      row = series_row_without_index(1)
      response = {resultSets: [{name: "PlayoffSeries", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024).first

      assert_nil series.home_team_id
      assert_equal "0042400101", series.game_id
    end

    def test_handles_missing_visitor_team_id
      headers = series_headers_without("VISITOR_TEAM_ID")
      row = series_row_without_index(2)
      response = {resultSets: [{name: "PlayoffSeries", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024).first

      assert_nil series.visitor_team_id
      assert_equal "0042400101", series.game_id
    end

    def test_handles_missing_series_id
      headers = series_headers_without("SERIES_ID")
      row = series_row_without_index(3)
      response = {resultSets: [{name: "PlayoffSeries", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024).first

      assert_nil series.series_id
      assert_equal "0042400101", series.game_id
    end

    def test_handles_missing_game_num
      headers = series_headers_without("GAME_NUM")
      row = series_row_without_index(4)
      response = {resultSets: [{name: "PlayoffSeries", headers: headers, rowSet: [row]}]}
      stub_request(:get, /commonplayoffseries/).to_return(body: response.to_json)

      series = CommonPlayoffSeries.all(season: 2024).first

      assert_nil series.game_num
      assert_equal "0042400101", series.game_id
    end

    private

    def series_headers
      %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID SERIES_ID GAME_NUM]
    end

    def series_row
      ["0042400101", Team::BOS, Team::MIA, "0042400100", 1]
    end

    def series_headers_without(key)
      series_headers.reject { |h| h == key }
    end

    def series_row_without_index(idx)
      series_row[0...idx] + series_row[(idx + 1)..]
    end
  end
end
