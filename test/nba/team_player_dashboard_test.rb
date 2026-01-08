require_relative "../test_helper"

module NBA
  class TeamPlayerDashboardTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_players_returns_collection
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_players_returns_player_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_equal 1, result.size
      assert_kind_of TeamPlayerStat, result.first
    end

    def test_players_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_players_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: players_response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamPlayerDashboard.players(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_players_includes_season_in_path
      stub_request(:get, /Season=2024-25/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744, season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_players_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_players_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_players_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_players_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    def test_players_includes_league_id
      stub_request(:get, /LeagueID=00/).to_return(body: players_response.to_json)

      TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_requested :get, /LeagueID=00/
    end

    private

    def players_headers
      %w[GROUP_SET PLAYER_ID PLAYER_NAME GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK
        BLKA PF PFD PTS PLUS_MINUS NBA_FANTASY_PTS DD2 TD3]
    end

    def players_row
      ["PlayersSeasonTotals", 201_939, "Stephen Curry", 74, 46, 28, 0.622,
        32.7, 10.0, 19.6, 0.451, 4.8, 11.7, 0.408, 4.8, 5.1, 0.921,
        0.7, 4.5, 5.1, 5.1, 2.8, 0.7, 0.4, 0.3, 1.6, 1.9, 26.4, 7.8, 45.2, 10, 2]
    end

    def players_response
      {resultSets: [{name: "PlayersSeasonTotals", headers: players_headers, rowSet: [players_row]}]}
    end
  end
end
