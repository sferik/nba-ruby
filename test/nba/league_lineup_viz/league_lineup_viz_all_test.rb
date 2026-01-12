require_relative "../../test_helper"

module NBA
  class LeagueLineupVizAllTest < Minitest::Test
    cover LeagueLineupViz

    def test_all_returns_collection
      stub_request(:get, /leaguelineupviz/).to_return(body: lineup_viz_response.to_json)

      assert_instance_of Collection, LeagueLineupViz.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguelineupviz/).to_return(body: lineup_viz_response.to_json)

      result = LeagueLineupViz.all(season: 2024)

      assert_equal "201939-203110", result.first.group_id
    end

    def test_all_with_season_type_parameter
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024, season_type: LeagueLineupViz::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_parameter
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024, per_mode: LeagueLineupViz::TOTALS)

      assert_requested stub
    end

    def test_all_with_measure_type_parameter
      stub = stub_request(:get, /MeasureType=Advanced/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024, measure_type: LeagueLineupViz::ADVANCED)

      assert_requested stub
    end

    def test_all_with_group_quantity_parameter
      stub = stub_request(:get, /GroupQuantity=3/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024, group_quantity: LeagueLineupViz::THREE_MAN)

      assert_requested stub
    end

    def test_all_with_minutes_min_parameter
      stub = stub_request(:get, /MinutesMin=100/)
        .to_return(body: lineup_viz_response.to_json)

      LeagueLineupViz.all(season: 2024, minutes_min: 100)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, lineup_viz_response.to_json, [String]

      LeagueLineupViz.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def lineup_viz_response
      {resultSets: [{name: "LeagueLineupViz", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[GROUP_ID GROUP_NAME TEAM_ID TEAM_ABBREVIATION MIN OFF_RATING DEF_RATING NET_RATING
        PACE TS_PCT FTA_RATE TM_AST_PCT PCT_FGA_2PT PCT_FGA_3PT PCT_PTS_2PT_MR PCT_PTS_FB
        PCT_PTS_FT PCT_PTS_PAINT PCT_AST_FGM PCT_UAST_FGM OPP_FG3_PCT OPP_EFG_PCT OPP_FTA_RATE
        OPP_TOV_PCT]
    end

    def stat_row
      ["201939-203110", "S. Curry - K. Thompson", Team::GSW, "GSW", 245.5, 115.3, 108.5, 6.8,
        101.2, 0.612, 0.285, 0.652, 0.545, 0.455, 0.125, 0.152, 0.185, 0.425, 0.652, 0.348,
        0.352, 0.512, 0.275, 0.132]
    end
  end
end
