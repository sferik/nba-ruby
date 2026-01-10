require_relative "cume_stats_player_games_all_helper"

module NBA
  class CumeStatsPlayerGamesAllParamsTest < Minitest::Test
    include CumeStatsPlayerGamesAllHelper

    cover CumeStatsPlayerGames

    def setup
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)
    end

    def test_all_uses_season_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames.*Season=2024-25/
    end

    def test_all_uses_season_type_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, season_type: "Playoffs")

      assert_requested :get, /cumestatsplayergames.*SeasonType=Playoffs/
    end

    def test_all_uses_default_season_type
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames.*SeasonType=Regular.*Season/
    end

    def test_all_uses_league_id_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames.*LeagueID=00/
    end

    def test_all_accepts_custom_league_id
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, league: "10")

      assert_requested :get, /cumestatsplayergames.*LeagueID=10/
    end

    def test_all_accepts_league_object
      league = League.new(id: "10", name: "WNBA")

      CumeStatsPlayerGames.all(player: 201_939, season: 2024, league: league)

      assert_requested :get, /cumestatsplayergames.*LeagueID=10/
    end
  end
end
