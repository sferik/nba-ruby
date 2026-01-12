require_relative "../../test_helper"

module NBA
  class ShotChartLeagueWideNilHandlingTest < Minitest::Test
    cover ShotChartLeagueWide

    def test_returns_nil_for_missing_grid_type
      stat = stat_with_missing_header("GRID_TYPE")

      assert_nil stat.grid_type
    end

    def test_returns_nil_for_missing_shot_zone_basic
      stat = stat_with_missing_header("SHOT_ZONE_BASIC")

      assert_nil stat.shot_zone_basic
    end

    def test_returns_nil_for_missing_shot_zone_area
      stat = stat_with_missing_header("SHOT_ZONE_AREA")

      assert_nil stat.shot_zone_area
    end

    def test_returns_nil_for_missing_shot_zone_range
      stat = stat_with_missing_header("SHOT_ZONE_RANGE")

      assert_nil stat.shot_zone_range
    end

    def test_returns_nil_for_missing_fga
      stat = stat_with_missing_header("FGA")

      assert_nil stat.fga
    end

    def test_returns_nil_for_missing_fgm
      stat = stat_with_missing_header("FGM")

      assert_nil stat.fgm
    end

    def test_returns_nil_for_missing_fg_pct
      stat = stat_with_missing_header("FG_PCT")

      assert_nil stat.fg_pct
    end

    def test_uses_default_season
      stub_request(:get, /shotchartleaguewide.*Season=#{Utils.current_season}/)
        .to_return(body: shot_chart_response.to_json)

      ShotChartLeagueWide.all

      assert_requested :get, /shotchartleaguewide.*Season=#{Utils.current_season}/
    end

    def test_uses_default_season_type
      stub_request(:get, /shotchartleaguewide.*SeasonType=Regular%20Season/)
        .to_return(body: shot_chart_response.to_json)

      ShotChartLeagueWide.all

      assert_requested :get, /shotchartleaguewide.*SeasonType=Regular/
    end

    def test_finds_correct_result_set_among_multiple
      response = {
        resultSets: [
          {name: "Other", headers: ["X"], rowSet: [["Y"]]},
          {name: "LeagueWide", headers: shot_chart_headers, rowSet: [shot_chart_row]}
        ]
      }
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      result = ShotChartLeagueWide.all

      assert_equal 1, result.size
      assert_equal "Restricted Area", result.first.shot_zone_basic
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: shot_chart_headers, rowSet: [shot_chart_row]}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      result = ShotChartLeagueWide.all

      assert_equal 0, result.size
    end

    def test_returns_empty_when_result_sets_key_missing
      response = {}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      result = ShotChartLeagueWide.all

      assert_equal 0, result.size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueWide", rowSet: [shot_chart_row]}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      result = ShotChartLeagueWide.all

      assert_equal 0, result.size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "LeagueWide", headers: shot_chart_headers}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)

      result = ShotChartLeagueWide.all

      assert_equal 0, result.size
    end

    private

    def stat_with_missing_header(header_to_remove)
      headers = shot_chart_headers.reject { |h| h == header_to_remove }
      row = shot_chart_row.dup
      idx = shot_chart_headers.index(header_to_remove)
      row.delete_at(idx) if idx
      response = {resultSets: [{name: "LeagueWide", headers: headers, rowSet: [row]}]}
      stub_request(:get, /shotchartleaguewide/).to_return(body: response.to_json)
      ShotChartLeagueWide.all.first
    end

    def shot_chart_response
      {resultSets: [{name: "LeagueWide", headers: shot_chart_headers, rowSet: [shot_chart_row]}]}
    end

    def shot_chart_headers = %w[GRID_TYPE SHOT_ZONE_BASIC SHOT_ZONE_AREA SHOT_ZONE_RANGE FGA FGM FG_PCT]
    def shot_chart_row = ["Shot Zone Basic", "Restricted Area", "Center(C)", "Less Than 8 ft.", 50_000, 32_500, 0.650]
  end
end
