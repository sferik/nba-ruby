require_relative "../test_helper"

module NBA
  module CumeStatsPlayerGamesAllHelper
    HEADERS = %w[MATCHUP GAME_ID].freeze
    ROW = ["GSW vs. LAL", "0022400001"].freeze

    def response
      {resultSets: [{name: "CumeStatsPlayerGames", headers: HEADERS, rowSet: [ROW]}]}
    end
  end

  class CumeStatsPlayerGamesAllBasicTest < Minitest::Test
    include CumeStatsPlayerGamesAllHelper

    cover CumeStatsPlayerGames

    def setup
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)
    end

    def test_all_returns_collection
      assert_instance_of Collection, CumeStatsPlayerGames.all(player: 201_939, season: 2024)
    end

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CumeStatsPlayerGames.all(player: 201_939, season: 2024, client: mock_client)

      assert_instance_of Collection, result
      assert_predicate result, :empty?
      mock_client.verify
    end

    def test_all_sends_correct_endpoint
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames/
    end

    def test_all_uses_player_id_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames.*PlayerID=201939/
    end

    def test_all_accepts_player_object
      player = Player.new(id: 201_939)

      result = CumeStatsPlayerGames.all(player: player, season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      result = CumeStatsPlayerGames.all(player: 201_939, season: 2024, client: mock_client)

      assert_instance_of Collection, result
      mock_client.verify
    end

    def test_all_parses_game_id
      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "0022400001", entry.game_id
    end

    def test_all_parses_matchup
      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "GSW vs. LAL", entry.matchup
    end
  end

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
