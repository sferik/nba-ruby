require_relative "../test_helper"

module NBA
  class PlayoffSeriesModelTest < Minitest::Test
    cover PlayoffSeries

    def test_objects_with_same_game_id_and_series_id_are_equal
      series0 = PlayoffSeries.new(game_id: "0042400101", series_id: "0042400100")
      series1 = PlayoffSeries.new(game_id: "0042400101", series_id: "0042400100")

      assert_equal series0, series1
    end

    def test_objects_with_different_game_id_are_not_equal
      series0 = PlayoffSeries.new(game_id: "0042400101", series_id: "0042400100")
      series1 = PlayoffSeries.new(game_id: "0042400102", series_id: "0042400100")

      refute_equal series0, series1
    end

    def test_home_team_returns_nil_when_home_team_id_is_nil
      series = PlayoffSeries.new(home_team_id: nil)

      assert_nil series.home_team
    end

    def test_visitor_team_returns_nil_when_visitor_team_id_is_nil
      series = PlayoffSeries.new(visitor_team_id: nil)

      assert_nil series.visitor_team
    end

    def test_game_returns_nil_when_game_id_is_nil
      series = PlayoffSeries.new(game_id: nil)

      assert_nil series.game
    end

    def test_home_team_returns_team_object_when_home_team_id_valid
      series = PlayoffSeries.new(home_team_id: Team::BOS)

      result = series.home_team

      assert_instance_of Team, result
      assert_equal Team::BOS, result.id
    end

    def test_visitor_team_returns_team_object_when_visitor_team_id_valid
      series = PlayoffSeries.new(visitor_team_id: Team::MIA)

      result = series.visitor_team

      assert_instance_of Team, result
      assert_equal Team::MIA, result.id
    end

    def test_game_returns_game_object_when_game_id_valid
      stub_request(:get, /boxscoresummaryv2/).to_return(body: game_summary_response.to_json)

      series = PlayoffSeries.new(game_id: "0042400101")
      result = series.game

      assert_instance_of Game, result
      assert_equal "0042400101", result.id
    end

    private

    def game_summary_response
      {resultSets: [{name: "GameSummary", headers: %w[GAME_ID GAME_DATE_EST GAME_STATUS_ID HOME_TEAM_ID VISITOR_TEAM_ID ARENA],
                     rowSet: [["0042400101", "2024-04-20", 3, Team::BOS, Team::MIA, "TD Garden"]]}]}
    end
  end
end
