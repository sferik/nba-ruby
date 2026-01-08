require_relative "../test_helper"

module NBA
  class LeagueDashLineupsDefaultParametersTest < Minitest::Test
    cover LeagueDashLineups

    def test_default_season_uses_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub = stub_request(:get, /Season=#{current_season_str}/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all

      assert_requested stub
    end

    def test_default_season_type_is_regular_season
      stub = stub_request(:get, /SeasonType=Regular%20Season/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all(season: 2024)

      assert_requested stub
    end

    def test_default_per_mode_is_per_game
      stub = stub_request(:get, /PerMode=PerGame/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all(season: 2024)

      assert_requested stub
    end

    def test_default_group_quantity_is_five_man
      stub = stub_request(:get, /GroupQuantity=5/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all(season: 2024)

      assert_requested stub
    end

    private

    def lineups_response
      {resultSets: [{name: "Lineups", headers: %w[GROUP_ID], rowSet: [["201939-203110"]]}]}
    end
  end
end
