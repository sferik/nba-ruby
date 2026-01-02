require_relative "../test_helper"

module NBA
  class CommonPlayoffSeriesAttributeMappingTest < Minitest::Test
    cover CommonPlayoffSeries

    def test_maps_all_series_attributes
      stub_playoff_series_request

      series = CommonPlayoffSeries.all(season: 2024).first

      assert_equal "0042400101", series.game_id
      assert_equal Team::BOS, series.home_team_id
      assert_equal Team::MIA, series.visitor_team_id
      assert_equal "0042400100", series.series_id
      assert_equal 1, series.game_num
    end

    private

    def stub_playoff_series_request
      stub_request(:get, /commonplayoffseries/).to_return(body: playoff_series_response.to_json)
    end

    def playoff_series_response
      {resultSets: [{name: "PlayoffSeries", headers: series_headers, rowSet: [series_row]}]}
    end

    def series_headers
      %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID SERIES_ID GAME_NUM]
    end

    def series_row
      ["0042400101", Team::BOS, Team::MIA, "0042400100", 1]
    end
  end
end
