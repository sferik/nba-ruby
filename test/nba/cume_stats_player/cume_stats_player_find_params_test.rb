require_relative "../../test_helper"
require_relative "cume_stats_player_find_test_helper"

module NBA
  class CumeStatsPlayerFindParamsTest < Minitest::Test
    cover CumeStatsPlayer

    def test_find_uses_default_season_type
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_requested :get, /cumestatsplayer.*SeasonType=Regular%20Season/
    end

    def test_find_accepts_custom_season_type
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25",
        season_type: "Playoffs")

      assert_requested :get, /cumestatsplayer.*SeasonType=Playoffs/
    end

    def test_find_uses_default_league
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_requested :get, /cumestatsplayer.*LeagueID=00/
    end

    def test_find_accepts_custom_league_id
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25", league: "10")

      assert_requested :get, /cumestatsplayer.*LeagueID=10/
    end

    def test_find_accepts_league_object
      stub_cume_stats_player_request
      league = League.new(id: "10", name: "WNBA")

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25", league: league)

      assert_requested :get, /cumestatsplayer.*LeagueID=10/
    end

    private

    def stub_cume_stats_player_request
      stub_request(:get, /cumestatsplayer/).to_return(body: CumeStatsPlayerFindTestHelper.cume_stats_player_response.to_json)
    end
  end
end
