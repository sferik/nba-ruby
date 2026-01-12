require_relative "../../test_helper"

module NBA
  class TeamDashboardEndpointsTest < Minitest::Test
    cover TeamDashboard

    def test_general_splits_returns_collection
      stub_dashboard_request("teamdashboardbygeneralsplits")

      assert_instance_of Collection, TeamDashboard.general_splits(team: Team::GSW)
    end

    def test_shooting_splits_returns_collection
      stub_dashboard_request("teamdashboardbyshootingsplits")

      assert_instance_of Collection, TeamDashboard.shooting_splits(team: Team::GSW)
    end

    def test_lineups_returns_collection
      stub_dashboard_request("teamdashlineups")

      assert_instance_of Collection, TeamDashboard.lineups(team: Team::GSW)
    end

    def test_clutch_splits_returns_collection
      stub_dashboard_request("teamdashboardbyclutch")

      assert_instance_of Collection, TeamDashboard.clutch_splits(team: Team::GSW)
    end

    def test_game_splits_returns_collection
      stub_dashboard_request("teamdashboardbygamesplits")

      assert_instance_of Collection, TeamDashboard.game_splits(team: Team::GSW)
    end

    def test_last_n_games_returns_collection
      stub_dashboard_request("teamdashboardbylastngames")

      assert_instance_of Collection, TeamDashboard.last_n_games(team: Team::GSW)
    end

    def test_team_performance_returns_collection
      stub_dashboard_request("teamdashboardbyteamperformance")

      assert_instance_of Collection, TeamDashboard.team_performance(team: Team::GSW)
    end

    def test_year_over_year_returns_collection
      stub_dashboard_request("teamdashboardbyyearoveryear")

      assert_instance_of Collection, TeamDashboard.year_over_year(team: Team::GSW)
    end

    private

    def stub_dashboard_request(endpoint)
      response = {
        resultSets: [{
          name: "OverallTeamDashboard",
          headers: %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
            FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS],
          rowSet: [["Overall", 82, 50, 32, 0.610, 48.0, 42.5, 88.2, 0.482, 14.5, 38.8, 0.374,
            18.0, 22.5, 0.800, 10.5, 35.5, 46.0, 28.5, 13.5, 8.0, 5.5, 4.0, 19.0, 21.0, 117.5, 5.5]]
        }]
      }
      stub_request(:get, /#{endpoint}.*TeamID=#{Team::GSW}/).to_return(body: response.to_json)
    end
  end
end
