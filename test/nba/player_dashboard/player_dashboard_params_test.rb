require_relative "../../test_helper"

module NBA
  class PlayerDashboardParamsTest < Minitest::Test
    cover PlayerDashboard

    def test_accepts_player_object
      stub_request(:get, /playerdashboardbygeneralsplits.*PlayerID=201939/)
        .to_return(body: dashboard_response.to_json)
      player = Player.new(id: 201_939)
      PlayerDashboard.general_splits(player: player)

      assert_requested :get, /playerdashboardbygeneralsplits.*PlayerID=201939/
    end

    def test_with_season_param
      stub_request(:get, /playerdashboardbygeneralsplits.*Season=2023-24/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.general_splits(player: 201_939, season: 2023)

      assert_requested :get, /playerdashboardbygeneralsplits.*Season=2023-24/
    end

    def test_with_season_type_param
      stub_request(:get, /playerdashboardbygeneralsplits.*SeasonType=Playoffs/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.general_splits(player: 201_939, season_type: PlayerDashboard::PLAYOFFS)

      assert_requested :get, /playerdashboardbygeneralsplits.*SeasonType=Playoffs/
    end

    def test_with_per_mode_param
      stub_request(:get, /playerdashboardbygeneralsplits.*PerMode=Totals/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.general_splits(player: 201_939, per_mode: PlayerDashboard::TOTALS)

      assert_requested :get, /playerdashboardbygeneralsplits.*PerMode=Totals/
    end

    def test_constants_defined
      assert_equal "Regular Season", PlayerDashboard::REGULAR_SEASON
      assert_equal "Playoffs", PlayerDashboard::PLAYOFFS
      assert_equal "PerGame", PlayerDashboard::PER_GAME
      assert_equal "Totals", PlayerDashboard::TOTALS
      assert_equal "Per36", PlayerDashboard::PER_36
    end

    def test_general_splits_uses_defaults
      stub_request(:get, /playerdashboardbygeneralsplits.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.general_splits(player: 201_939)

      assert_requested :get, /playerdashboardbygeneralsplits.*PerMode=PerGame/
    end

    def test_clutch_splits_uses_defaults
      stub_request(:get, /playerdashboardbyclutch.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.clutch_splits(player: 201_939)

      assert_requested :get, /playerdashboardbyclutch.*PerMode=PerGame/
    end

    def test_shooting_splits_uses_defaults
      stub_request(:get, /playerdashboardbyshootingsplits.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.shooting_splits(player: 201_939)

      assert_requested :get, /playerdashboardbyshootingsplits.*PerMode=PerGame/
    end

    def test_game_splits_uses_defaults
      stub_request(:get, /playerdashboardbygamesplits.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.game_splits(player: 201_939)

      assert_requested :get, /playerdashboardbygamesplits.*PerMode=PerGame/
    end

    def test_last_n_games_uses_defaults
      stub_request(:get, /playerdashboardbylastngames.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.last_n_games(player: 201_939)

      assert_requested :get, /playerdashboardbylastngames.*PerMode=PerGame/
    end

    def test_year_over_year_uses_defaults
      stub_request(:get, /playerdashboardbyyearoveryear.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.year_over_year(player: 201_939)

      assert_requested :get, /playerdashboardbyyearoveryear.*PerMode=PerGame/
    end

    def test_team_performance_uses_defaults
      stub_request(:get, /playerdashboardbyteamperformance.*SeasonType=Regular(%20|\+)Season/)
        .to_return(body: dashboard_response.to_json)
      PlayerDashboard.team_performance(player: 201_939)

      assert_requested :get, /playerdashboardbyteamperformance.*PerMode=PerGame/
    end

    private

    def dashboard_response
      {
        resultSets: [{
          name: "OverallPlayerDashboard",
          headers: %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
            FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS],
          rowSet: [["Overall", 82, 50, 32, 0.610, 34.5, 10.5, 21.2, 0.495, 5.5, 11.8,
            0.466, 5.0, 5.5, 0.909, 0.5, 5.5, 6.0, 5.5, 2.5, 1.0, 0.5, 0.2, 2.0, 3.5, 31.5, 8.5]]
        }]
      }
    end
  end
end
