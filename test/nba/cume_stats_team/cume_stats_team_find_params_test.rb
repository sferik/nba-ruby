require_relative "cume_stats_team_test_helper"

module NBA
  class CumeStatsTeamFindParamsTest < Minitest::Test
    include CumeStatsTeamTestHelper

    cover CumeStatsTeam

    def test_find_uses_pipe_separated_game_ids_in_path
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: %w[0022400001 0022400002], season: 2024)

      assert_requested :get, /GameIDs=0022400001%7C0022400002/
    end

    def test_find_accepts_string_game_ids
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: "0022400001|0022400002", season: 2024)

      assert_requested :get, /GameIDs=0022400001%7C0022400002/
    end

    def test_find_uses_correct_season_in_path
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_find_uses_correct_season_type_in_path
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_find_uses_default_season_type_when_not_specified
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_find_uses_correct_league_in_path
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_find_uses_default_league_when_not_specified
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_requested :get, /LeagueID=00/
    end

    def test_find_accepts_league_object
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
      league = League.new(id: "10")

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024, league: league)

      assert_requested :get, /LeagueID=10/
    end
  end
end
