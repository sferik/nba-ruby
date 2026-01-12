require_relative "../../test_helper"

module NBA
  class TeamPlayerDashboardValuesTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_players_parses_player_id
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_equal 201_939, result.player_id
    end

    def test_players_parses_player_name
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_equal "Stephen Curry", result.player_name
    end

    def test_players_parses_group_set
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_equal "PlayersSeasonTotals", result.group_set
    end

    def test_players_parses_gp
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_equal 74, result.gp
    end

    def test_players_parses_record_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_equal 46, result.w
      assert_equal 28, result.l
      assert_in_delta 0.622, result.w_pct
    end

    def test_players_parses_shooting_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_in_delta 10.0, result.fgm
      assert_in_delta 19.6, result.fga
      assert_in_delta 0.451, result.fg_pct
    end

    def test_players_parses_three_point_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_in_delta 4.8, result.fg3m
      assert_in_delta 11.7, result.fg3a
      assert_in_delta 0.408, result.fg3_pct
    end

    def test_players_parses_free_throw_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_in_delta 4.8, result.ftm
      assert_in_delta 5.1, result.fta
      assert_in_delta 0.921, result.ft_pct
    end

    def test_players_parses_rebound_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_in_delta 0.7, result.oreb
      assert_in_delta 4.5, result.dreb
      assert_in_delta 5.1, result.reb
    end

    def test_players_parses_counting_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_in_delta 5.1, result.ast
      assert_in_delta 2.8, result.tov
      assert_in_delta 0.7, result.stl
      assert_in_delta 0.4, result.blk
    end

    def test_players_parses_bonus_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: players_response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_in_delta 45.2, result.nba_fantasy_pts
      assert_equal 10, result.dd2
      assert_equal 2, result.td3
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
