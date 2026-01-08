require_relative "../test_helper"

module NBA
  class LeagueSeasonMatchupsDefaultParametersTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_default_season_uses_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub = stub_request(:get, /Season=#{current_season_str}/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all

      assert_requested stub
    end

    def test_season_parameter_is_formatted_correctly
      stub = stub_request(:get, /Season=2024-25/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    def test_default_season_type_is_regular_season
      stub = stub_request(:get, /SeasonType=Regular%20Season/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    def test_default_per_mode_is_per_game
      stub = stub_request(:get, /PerMode=PerGame/)
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    private

    def matchups_response
      {resultSets: [{name: "SeasonMatchups", headers: %w[SEASON_ID OFF_PLAYER_ID], rowSet: [["22024", 201_939]]}]}
    end
  end
end
