require_relative "../../test_helper"

module NBA
  class TeamPlayerDashboardTeamValuesTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_team_parses_group_set
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_equal "TeamOverall", result.group_set
    end

    def test_team_parses_team_id
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_equal 1_610_612_744, result.team_id
    end

    def test_team_parses_group_value
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_equal "Golden State Warriors", result.group_value
    end

    def test_team_parses_gp
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_equal 82, result.gp
    end

    def test_team_parses_min
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_in_delta 240.0, result.min
    end

    def test_team_parses_record_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_equal 46, result.w
      assert_equal 36, result.l
      assert_in_delta 0.561, result.w_pct
    end

    def test_team_parses_shooting_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_in_delta 39.6, result.fgm
      assert_in_delta 87.8, result.fga
      assert_in_delta 0.451, result.fg_pct
    end

    def test_team_parses_three_point_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_in_delta 14.8, result.fg3m
      assert_in_delta 40.2, result.fg3a
      assert_in_delta 0.368, result.fg3_pct
    end

    def test_team_parses_free_throw_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_in_delta 17.8, result.ftm
      assert_in_delta 22.1, result.fta
      assert_in_delta 0.805, result.ft_pct
    end

    def test_team_parses_rebound_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_in_delta 9.1, result.oreb
      assert_in_delta 34.8, result.dreb
      assert_in_delta 43.9, result.reb
    end

    def test_team_parses_counting_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_in_delta 27.5, result.ast
      assert_in_delta 14.1, result.tov
      assert_in_delta 7.6, result.stl
      assert_in_delta 4.8, result.blk
    end

    private

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
