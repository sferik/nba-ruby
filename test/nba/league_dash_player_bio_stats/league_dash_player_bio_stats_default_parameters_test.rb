require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerBioStatsDefaultParametersTest < Minitest::Test
    cover LeagueDashPlayerBioStats

    def test_default_season_uses_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub = stub_request(:get, /Season=#{current_season_str}/)
        .to_return(body: bio_stats_response.to_json)

      LeagueDashPlayerBioStats.all

      assert_requested stub
    end

    def test_default_season_type_is_regular_season
      stub = stub_request(:get, /SeasonType=Regular%20Season/)
        .to_return(body: bio_stats_response.to_json)

      LeagueDashPlayerBioStats.all(season: 2024)

      assert_requested stub
    end

    def test_default_per_mode_is_per_game
      stub = stub_request(:get, /PerMode=PerGame/)
        .to_return(body: bio_stats_response.to_json)

      LeagueDashPlayerBioStats.all(season: 2024)

      assert_requested stub
    end

    private

    def bio_stats_response
      {resultSets: [{name: "LeagueDashPlayerBioStats", headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}
    end
  end
end
