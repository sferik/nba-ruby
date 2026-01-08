require_relative "../test_helper"

module NBA
  class TeamPlayerDashboardResultSetTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_players_ignores_wrong_result_set_name
      response = {resultSets: [{name: "WrongName", headers: headers, rowSet: [row]}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_team_ignores_wrong_result_set_name
      response = {resultSets: [{name: "WrongName", headers: team_headers, rowSet: [team_row]}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_finds_correct_result_set_among_many
      response = {resultSets: [
        {name: "WrongName", headers: team_headers, rowSet: [team_row]},
        {name: "PlayersSeasonTotals", headers: headers, rowSet: [row]}
      ]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      refute_empty result
      assert_kind_of TeamPlayerStat, result.first
    end

    def test_team_finds_correct_result_set_among_many
      response = {resultSets: [
        {name: "WrongName", headers: headers, rowSet: [row]},
        {name: "TeamOverall", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      refute_empty result
      assert_kind_of TeamDashboardStat, result.first
    end

    def test_players_requires_exact_name_match
      response = {resultSets: [{name: "playersSeasonTotals", headers: headers, rowSet: [row]}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_team_requires_exact_name_match
      response = {resultSets: [{name: "teamOverall", headers: team_headers, rowSet: [team_row]}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_returns_team_player_stat_not_dashboard_stat
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_kind_of TeamPlayerStat, result.first
      refute_kind_of TeamDashboardStat, result.first
    end

    def test_team_returns_team_dashboard_stat_not_player_stat
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_kind_of TeamDashboardStat, result.first
      refute_kind_of TeamPlayerStat, result.first
    end

    private

    def headers
      %w[GROUP_SET PLAYER_ID PLAYER_NAME GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK
        BLKA PF PFD PTS PLUS_MINUS NBA_FANTASY_PTS DD2 TD3]
    end

    def row
      ["PlayersSeasonTotals", 201_939, "Stephen Curry", 74, 46, 28, 0.622,
        32.7, 10.0, 19.6, 0.451, 4.8, 11.7, 0.408, 4.8, 5.1, 0.921,
        0.7, 4.5, 5.1, 5.1, 2.8, 0.7, 0.4, 0.3, 1.6, 1.9, 26.4, 7.8, 45.2, 10, 2]
    end

    def players_response
      {resultSets: [{name: "PlayersSeasonTotals", headers: headers, rowSet: [row]}]}
    end

    def team_headers
      %w[GROUP_SET TEAM_ID GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK
        BLKA PF PFD PTS PLUS_MINUS]
    end

    def team_row
      ["TeamOverall", 1_610_612_744, "Golden State Warriors", 82, 46, 36, 0.561,
        240.0, 39.6, 87.8, 0.451, 14.8, 40.2, 0.368, 17.8, 22.1, 0.805,
        9.1, 34.8, 43.9, 27.5, 14.1, 7.6, 4.8, 4.2, 20.1, 18.9, 111.8, 2.5]
    end

    def team_response
      {resultSets: [{name: "TeamOverall", headers: team_headers, rowSet: [team_row]}]}
    end
  end
end
