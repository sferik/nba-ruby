require_relative "../../test_helper"

module NBA
  class LeagueDashPtStatsDefaultParamsTest < Minitest::Test
    cover LeagueDashPtStats

    def test_default_season_uses_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub = stub_request(:get, /Season=#{current_season_str}/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all

      assert_requested stub
    end

    def test_default_season_type_is_regular_season
      stub = stub_request(:get, /SeasonType=Regular%20Season/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024)

      assert_requested stub
    end

    def test_default_per_mode_is_per_game
      stub = stub_request(:get, /PerMode=PerGame/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024)

      assert_requested stub
    end

    def test_default_player_or_team_is_player
      stub = stub_request(:get, /PlayerOrTeam=Player/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024)

      assert_requested stub
    end

    def test_default_pt_measure_type_is_speed_distance
      stub = stub_request(:get, /PtMeasureType=SpeedDistance/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024)

      assert_requested stub
    end

    private

    def pt_stats_response
      {resultSets: [{name: "LeagueDashPtStats", headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}
    end
  end
end
