require_relative "../../test_helper"

module NBA
  class TeamPlayerDashboardTeamTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_team_returns_collection
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_team_returns_team_dashboard_stats
      stub_request(:get, /teamplayerdashboard/).to_return(body: team_response.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_equal 1, result.size
      assert_kind_of TeamDashboardStat, result.first
    end

    def test_team_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: team_response.to_json)

      TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_team_includes_default_season_type
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: team_response.to_json)

      TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_team_includes_default_per_mode
      stub_request(:get, /PerMode=PerGame/).to_return(body: team_response.to_json)

      TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_team_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: team_response.to_json)

      TeamPlayerDashboard.team(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_team_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: team_response.to_json)

      TeamPlayerDashboard.team(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
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
