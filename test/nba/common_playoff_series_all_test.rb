require_relative "../test_helper"

module NBA
  class CommonPlayoffSeriesAllTest < Minitest::Test
    cover CommonPlayoffSeries

    def test_all_returns_collection
      stub_playoff_series_request

      result = CommonPlayoffSeries.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_playoff_series_request

      CommonPlayoffSeries.all(season: 2024)

      assert_requested :get, /commonplayoffseries.*Season=2024-25/
    end

    def test_all_uses_correct_league_id_in_path
      stub_playoff_series_request

      CommonPlayoffSeries.all(season: 2024)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_uses_default_season_from_utils
      stub_playoff_series_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      CommonPlayoffSeries.all

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_all_uses_default_league_id_when_not_specified
      stub_playoff_series_request

      CommonPlayoffSeries.all

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_series_successfully
      stub_playoff_series_request

      series = CommonPlayoffSeries.all(season: 2024)

      assert_equal 1, series.size
      assert_equal "0042400101", series.first.game_id
    end

    def test_all_accepts_league_id_parameter
      stub_playoff_series_request

      CommonPlayoffSeries.all(season: 2024, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_accepts_league_object
      stub_playoff_series_request
      league = League.new(id: "10", name: "WNBA")

      CommonPlayoffSeries.all(season: 2024, league: league)

      assert_requested :get, /LeagueID=10/
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
