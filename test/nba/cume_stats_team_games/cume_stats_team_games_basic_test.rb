require_relative "../../test_helper"
require_relative "cume_stats_team_games_test_helper"

module NBA
  class CumeStatsTeamGamesBasicTest < Minitest::Test
    include CumeStatsTeamGamesTestHelper

    cover CumeStatsTeamGames

    def test_all_returns_collection
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      result = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_team_id_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /TeamID=1610612747/
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /Season=2023-24/
    end

    def test_all_uses_correct_season_type_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_uses_default_season_type_when_not_specified
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_entries_successfully
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      entries = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_equal 1, entries.size
      assert_equal 22_300_001, entries.first.game_id
      assert_equal "LAL @ DEN", entries.first.matchup
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      league = League.new(id: "10")

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, league: league)

      assert_requested :get, /LeagueID=10/
    end

    def test_all_accepts_team_object
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_747)

      CumeStatsTeamGames.all(team: team, season: 2023)

      assert_requested :get, /TeamID=1610612747/
    end
  end
end
