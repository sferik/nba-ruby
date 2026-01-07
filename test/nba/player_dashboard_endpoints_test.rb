require_relative "../test_helper"

module NBA
  class PlayerDashboardEndpointsTest < Minitest::Test
    cover PlayerDashboard

    def test_general_splits_returns_collection
      stub_dashboard_request("playerdashboardbygeneralsplits")

      assert_instance_of Collection, PlayerDashboard.general_splits(player: 201_939)
    end

    def test_clutch_splits_returns_collection
      stub_dashboard_request("playerdashboardbyclutch")

      assert_instance_of Collection, PlayerDashboard.clutch_splits(player: 201_939)
    end

    def test_shooting_splits_returns_collection
      stub_dashboard_request("playerdashboardbyshootingsplits")

      assert_instance_of Collection, PlayerDashboard.shooting_splits(player: 201_939)
    end

    def test_game_splits_returns_collection
      stub_dashboard_request("playerdashboardbygamesplits")

      assert_instance_of Collection, PlayerDashboard.game_splits(player: 201_939)
    end

    def test_last_n_games_returns_collection
      stub_dashboard_request("playerdashboardbylastngames")

      assert_instance_of Collection, PlayerDashboard.last_n_games(player: 201_939)
    end

    def test_year_over_year_returns_collection
      stub_dashboard_request("playerdashboardbyyearoveryear")

      assert_instance_of Collection, PlayerDashboard.year_over_year(player: 201_939)
    end

    def test_team_performance_returns_collection
      stub_dashboard_request("playerdashboardbyteamperformance")

      assert_instance_of Collection, PlayerDashboard.team_performance(player: 201_939)
    end

    private

    def stub_dashboard_request(endpoint)
      stub_request(:get, /#{endpoint}.*PlayerID=201939/)
        .to_return(body: dashboard_response.to_json)
    end

    def dashboard_response
      {
        resultSets: [{
          name: "OverallPlayerDashboard",
          headers: %w[GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
            FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS],
          rowSet: [["Overall", 82, 50, 32, 0.610, 34.5, 10.5, 21.2, 0.495, 5.5, 11.8, 0.466,
            5.0, 5.5, 0.909, 0.5, 5.5, 6.0, 5.5, 2.5, 1.0, 0.5, 0.2, 2.0, 3.5, 31.5, 8.5]]
        }]
      }
    end
  end
end
