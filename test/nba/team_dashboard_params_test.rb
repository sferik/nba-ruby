require_relative "../test_helper"

module NBA
  class TeamDashboardParamsTest < Minitest::Test
    cover TeamDashboard

    def test_accepts_team_object
      stub_request(:get, /teamdashboardbygeneralsplits.*TeamID=#{Team::GSW}/o)
        .to_return(body: dashboard_response.to_json)

      team = Team.new(id: Team::GSW)
      TeamDashboard.general_splits(team: team)

      assert_requested :get, /teamdashboardbygeneralsplits.*TeamID=#{Team::GSW}/o
    end

    def test_with_season_param
      stub_request(:get, /teamdashboardbygeneralsplits.*Season=2023-24/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.general_splits(team: Team::GSW, season: 2023)

      assert_requested :get, /teamdashboardbygeneralsplits.*Season=2023-24/
    end

    def test_with_season_type_param
      stub_request(:get, /teamdashboardbygeneralsplits.*SeasonType=Playoffs/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.general_splits(team: Team::GSW, season_type: TeamDashboard::PLAYOFFS)

      assert_requested :get, /teamdashboardbygeneralsplits.*SeasonType=Playoffs/
    end

    def test_with_per_mode_param
      stub_request(:get, /teamdashboardbygeneralsplits.*PerMode=Totals/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.general_splits(team: Team::GSW, per_mode: TeamDashboard::TOTALS)

      assert_requested :get, /teamdashboardbygeneralsplits.*PerMode=Totals/
    end

    def test_constants_defined
      assert_equal "Regular Season", TeamDashboard::REGULAR_SEASON
      assert_equal "Playoffs", TeamDashboard::PLAYOFFS
      assert_equal "PerGame", TeamDashboard::PER_GAME
      assert_equal "Totals", TeamDashboard::TOTALS
      assert_equal "Per100Possessions", TeamDashboard::PER_100
    end

    def test_general_splits_uses_default_season_type
      stub_request(:get, /teamdashboardbygeneralsplits.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.general_splits(team: Team::GSW)

      assert_requested :get, /teamdashboardbygeneralsplits.*SeasonType=Regular%20Season/
    end

    def test_general_splits_uses_default_per_mode
      stub_request(:get, /teamdashboardbygeneralsplits.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.general_splits(team: Team::GSW)

      assert_requested :get, /teamdashboardbygeneralsplits.*PerMode=PerGame/
    end

    def test_shooting_splits_uses_default_season_type
      stub_request(:get, /teamdashboardbyshootingsplits.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.shooting_splits(team: Team::GSW)

      assert_requested :get, /teamdashboardbyshootingsplits.*SeasonType=Regular%20Season/
    end

    def test_shooting_splits_uses_default_per_mode
      stub_request(:get, /teamdashboardbyshootingsplits.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.shooting_splits(team: Team::GSW)

      assert_requested :get, /teamdashboardbyshootingsplits.*PerMode=PerGame/
    end

    def test_lineups_uses_default_season_type
      stub_request(:get, /teamdashlineups.*SeasonType=Regular%20Season/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.lineups(team: Team::GSW)

      assert_requested :get, /teamdashlineups.*SeasonType=Regular%20Season/
    end

    def test_lineups_uses_default_per_mode
      stub_request(:get, /teamdashlineups.*PerMode=PerGame/)
        .to_return(body: dashboard_response.to_json)

      TeamDashboard.lineups(team: Team::GSW)

      assert_requested :get, /teamdashlineups.*PerMode=PerGame/
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
