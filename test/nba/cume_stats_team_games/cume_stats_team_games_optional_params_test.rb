require_relative "../../test_helper"
require_relative "cume_stats_team_games_test_helper"

module NBA
  class CumeStatsTeamGamesOptionalParamsTest < Minitest::Test
    include CumeStatsTeamGamesTestHelper

    cover CumeStatsTeamGames

    def test_all_with_location_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, location: "Home")

      assert_requested :get, /Location=Home/
    end

    def test_all_with_outcome_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, outcome: "W")

      assert_requested :get, /Outcome=W/
    end

    def test_all_with_season_id_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, season_id: "22023")

      assert_requested :get, /SeasonID=22023/
    end

    def test_all_with_vs_conference_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_conference: "East")

      assert_requested :get, /VsConference=East/
    end

    def test_all_with_vs_division_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_division: "Pacific")

      assert_requested :get, /VsDivision=Pacific/
    end

    def test_all_with_vs_team_parameter
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_team: 1_610_612_743)

      assert_requested :get, /VsTeamID=1610612743/
    end

    def test_all_with_vs_team_object
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      vs_team = Team.new(id: 1_610_612_743)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, vs_team: vs_team)

      assert_requested :get, /VsTeamID=1610612743/
    end

    def test_all_includes_all_params_when_specified
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)
      call_with_all_params

      assert_requested :get, /LeagueID=10.*SeasonType=Playoffs.*TeamID=1610612747/
    end

    def test_all_without_location_omits_location_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /Location=/
    end

    def test_all_without_outcome_omits_outcome_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /Outcome=/
    end

    def test_all_without_season_id_omits_season_id_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /SeasonID=/
    end

    def test_all_without_vs_conference_omits_vs_conference_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /VsConference=/
    end

    def test_all_without_vs_division_omits_vs_division_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /VsDivision=/
    end

    def test_all_without_vs_team_omits_vs_team_id_param
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_not_requested :get, /VsTeamID=/
    end

    private

    def call_with_all_params
      CumeStatsTeamGames.all(
        team: 1_610_612_747, season: 2023, season_type: "Playoffs", league: "10",
        location: "Home", outcome: "W", season_id: "22023",
        vs_conference: "East", vs_division: "Pacific", vs_team: 1_610_612_743
      )
    end
  end
end
