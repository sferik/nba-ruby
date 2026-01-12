require_relative "../../test_helper"

module NBA
  class TeamDashboardGamePerformanceDefaultsTest < Minitest::Test
    cover TeamDashboard

    def test_game_splits_uses_default_season_type
      stub_request(:get, /teamdashboardbygamesplits.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.game_splits(team: Team::GSW)

      assert_requested :get, /teamdashboardbygamesplits.*SeasonType=Regular%20Season/
    end

    def test_game_splits_uses_default_per_mode
      stub_request(:get, /teamdashboardbygamesplits.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.game_splits(team: Team::GSW)

      assert_requested :get, /teamdashboardbygamesplits.*PerMode=PerGame/
    end

    def test_last_n_games_uses_default_season_type
      stub_request(:get, /teamdashboardbylastngames.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.last_n_games(team: Team::GSW)

      assert_requested :get, /teamdashboardbylastngames.*SeasonType=Regular%20Season/
    end

    def test_last_n_games_uses_default_per_mode
      stub_request(:get, /teamdashboardbylastngames.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.last_n_games(team: Team::GSW)

      assert_requested :get, /teamdashboardbylastngames.*PerMode=PerGame/
    end

    def test_team_performance_uses_default_season_type
      stub_request(:get, /teamdashboardbyteamperformance.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.team_performance(team: Team::GSW)

      assert_requested :get, /teamdashboardbyteamperformance.*SeasonType=Regular%20Season/
    end

    def test_team_performance_uses_default_per_mode
      stub_request(:get, /teamdashboardbyteamperformance.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.team_performance(team: Team::GSW)

      assert_requested :get, /teamdashboardbyteamperformance.*PerMode=PerGame/
    end

    def test_year_over_year_uses_default_season_type
      stub_request(:get, /teamdashboardbyyearoveryear.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.year_over_year(team: Team::GSW)

      assert_requested :get, /teamdashboardbyyearoveryear.*SeasonType=Regular%20Season/
    end

    def test_year_over_year_uses_default_per_mode
      stub_request(:get, /teamdashboardbyyearoveryear.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.year_over_year(team: Team::GSW)

      assert_requested :get, /teamdashboardbyyearoveryear.*PerMode=PerGame/
    end

    private

    def dashboard_response
      {
        resultSets: [{
          name: "OverallTeamDashboard",
          headers: %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
            FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS],
          rowSet: [["Overall", 82, 50, 32, 0.610, 48.0, 42.5, 88.2, 0.482, 14.5, 38.8, 0.374,
            18.0, 22.5, 0.800, 10.5, 35.5, 46.0, 28.5, 13.5, 8.0, 5.5, 4.0, 19.0, 21.0, 117.5, 5.5]]
        }]
      }
    end
  end
end
