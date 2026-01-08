require_relative "../test_helper"

module NBA
  class LeagueLineupVizDefaultParametersTest < Minitest::Test
    cover LeagueLineupViz

    def test_default_season_uses_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub = stub_request(:get, /Season=#{current_season_str}/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all

      assert_requested stub
    end

    def test_default_season_type_is_regular_season
      stub = stub_request(:get, /SeasonType=Regular%20Season/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024)

      assert_requested stub
    end

    def test_default_per_mode_is_per_game
      stub = stub_request(:get, /PerMode=PerGame/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024)

      assert_requested stub
    end

    def test_default_measure_type_is_base
      stub = stub_request(:get, /MeasureType=Base/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024)

      assert_requested stub
    end

    def test_default_group_quantity_is_five_man
      stub = stub_request(:get, /GroupQuantity=5/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024)

      assert_requested stub
    end

    def test_default_minutes_min_is_zero
      stub = stub_request(:get, /MinutesMin=0/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024)

      assert_requested stub
    end

    private

    def lineup_viz_response
      {resultSets: [{name: "LeagueLineupViz", headers: %w[GROUP_ID], rowSet: [["201939-203110"]]}]}
    end
  end
end
