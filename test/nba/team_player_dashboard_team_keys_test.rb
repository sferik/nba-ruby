require_relative "../test_helper"

module NBA
  class TeamPlayerDashboardTeamKeysTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_handles_missing_group_set_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("GROUP_SET").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.group_set
    end

    def test_handles_missing_team_id_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("TEAM_ID").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.team_id
    end

    def test_handles_missing_group_value_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("GROUP_VALUE").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.group_value
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("GP").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.gp
    end

    def test_handles_missing_min_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("MIN").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.min
    end

    def test_handles_missing_w_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("W").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.w
    end

    def test_handles_missing_l_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("L").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.l
    end

    def test_handles_missing_w_pct_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("W_PCT").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.w_pct
    end

    def test_handles_missing_pts_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PTS").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.pts
    end

    def test_handles_missing_plus_minus_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PLUS_MINUS").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.plus_minus
    end

    private

    def headers
      %w[GROUP_SET TEAM_ID GROUP_VALUE GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK
        BLKA PF PFD PTS PLUS_MINUS]
    end

    def row
      ["TeamOverall", 1_610_612_744, "Golden State Warriors", 82, 46, 36, 0.561,
        240.0, 39.6, 87.8, 0.451, 14.8, 40.2, 0.368, 17.8, 22.1, 0.805,
        9.1, 34.8, 43.9, 27.5, 14.1, 7.6, 4.8, 4.2, 20.1, 18.9, 111.8, 2.5]
    end

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "TeamOverall", headers: hdrs, rowSet: [rw]}]}
    end
  end
end
