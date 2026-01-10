require_relative "cume_stats_player_games_all_helper"

module NBA
  class CumeStatsPlayerGamesAllOptionalParamsTest < Minitest::Test
    include CumeStatsPlayerGamesAllHelper

    cover CumeStatsPlayerGames

    def setup
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)
    end

    def test_all_uses_location_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, location: "Home")

      assert_requested :get, /cumestatsplayergames.*Location=Home/
    end

    def test_all_uses_outcome_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, outcome: "W")

      assert_requested :get, /cumestatsplayergames.*Outcome=W/
    end

    def test_all_uses_vs_conference_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_conference: "East")

      assert_requested :get, /cumestatsplayergames.*VsConference=East/
    end

    def test_all_uses_vs_division_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_division: "Atlantic")

      assert_requested :get, /cumestatsplayergames.*VsDivision=Atlantic/
    end

    def test_all_uses_vs_team_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_team: 1_610_612_747)

      assert_requested :get, /cumestatsplayergames.*VsTeamID=1610612747/
    end

    def test_all_accepts_vs_team_object
      team = Team.new(id: 1_610_612_747)

      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_team: team)

      assert_requested :get, /cumestatsplayergames.*VsTeamID=1610612747/
    end

    def test_all_omits_location_when_nil
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, location: nil)

      assert_not_requested :get, /Location=/
    end

    def test_all_omits_outcome_when_nil
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, outcome: nil)

      assert_not_requested :get, /Outcome=/
    end

    def test_all_omits_vs_conference_when_nil
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_conference: nil)

      assert_not_requested :get, /VsConference=/
    end

    def test_all_omits_vs_division_when_nil
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_division: nil)

      assert_not_requested :get, /VsDivision=/
    end

    def test_all_omits_vs_team_when_nil
      CumeStatsPlayerGames.all(player: 201_939, season: 2024, vs_team: nil)

      assert_not_requested :get, /VsTeamID=/
    end
  end
end
