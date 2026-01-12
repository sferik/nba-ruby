require_relative "../../test_helper"

module NBA
  class ShotChartLeagueWideTest < Minitest::Test
    cover ShotChartLeagueWide

    def test_all_returns_collection
      stub_shot_chart_request

      assert_instance_of Collection, ShotChartLeagueWide.all
    end

    def test_all_parses_zone_attributes
      stub_shot_chart_request

      stat = ShotChartLeagueWide.all.first

      assert_equal "Shot Zone Basic", stat.grid_type
      assert_equal "Restricted Area", stat.shot_zone_basic
      assert_equal "Center(C)", stat.shot_zone_area
      assert_equal "Less Than 8 ft.", stat.shot_zone_range
    end

    def test_all_parses_shooting_stats
      stub_shot_chart_request

      stat = ShotChartLeagueWide.all.first

      assert_equal 50_000, stat.fga
      assert_equal 32_500, stat.fgm
      assert_in_delta 0.650, stat.fg_pct
    end

    def test_all_with_season_param
      stub_request(:get, /shotchartleaguewide.*Season=2023-24/)
        .to_return(body: shot_chart_response.to_json)

      ShotChartLeagueWide.all(season: 2023)

      assert_requested :get, /shotchartleaguewide.*Season=2023-24/
    end

    def test_all_with_season_type_param
      stub_request(:get, /shotchartleaguewide.*SeasonType=Playoffs/)
        .to_return(body: shot_chart_response.to_json)

      ShotChartLeagueWide.all(season_type: ShotChartLeagueWide::PLAYOFFS)

      assert_requested :get, /shotchartleaguewide.*SeasonType=Playoffs/
    end

    def test_all_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, ShotChartLeagueWide.all(client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /shotchartleaguewide/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, ShotChartLeagueWide.all.size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      assert_equal 0, ShotChartLeagueWide.all.size
    end

    def test_returns_empty_when_headers_nil
      response = {resultSets: [{name: "LeagueWide", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      assert_equal 0, ShotChartLeagueWide.all.size
    end

    def test_returns_empty_when_rows_nil
      response = {resultSets: [{name: "LeagueWide", headers: ["GRID_TYPE"], rowSet: nil}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      assert_equal 0, ShotChartLeagueWide.all.size
    end

    def test_constants_defined
      assert_equal "LeagueWide", ShotChartLeagueWide::LEAGUE_WIDE
      assert_equal "Regular Season", ShotChartLeagueWide::REGULAR_SEASON
      assert_equal "Playoffs", ShotChartLeagueWide::PLAYOFFS
    end

    private

    def stub_shot_chart_request
      stub_request(:get, /shotchartleaguewide/)
        .to_return(body: shot_chart_response.to_json)
    end

    def shot_chart_response
      {
        resultSets: [{
          name: "LeagueWide",
          headers: shot_chart_headers,
          rowSet: [shot_chart_row]
        }]
      }
    end

    def shot_chart_headers
      %w[GRID_TYPE SHOT_ZONE_BASIC SHOT_ZONE_AREA SHOT_ZONE_RANGE FGA FGM FG_PCT]
    end

    def shot_chart_row
      ["Shot Zone Basic", "Restricted Area", "Center(C)", "Less Than 8 ft.", 50_000, 32_500, 0.650]
    end
  end
end
