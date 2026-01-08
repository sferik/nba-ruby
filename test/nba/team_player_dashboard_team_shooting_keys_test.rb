require_relative "../test_helper"

module NBA
  class TeamPlayerDashboardTeamShootingKeysTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_handles_missing_fgm_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FGM").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fgm
    end

    def test_handles_missing_fga_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FGA").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fga
    end

    def test_handles_missing_fg_pct_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FG_PCT").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fg_pct
    end

    def test_handles_missing_fg3m_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FG3M").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fg3m
    end

    def test_handles_missing_fg3a_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FG3A").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FG3_PCT").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fg3_pct
    end

    def test_handles_missing_ftm_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FTM").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.ftm
    end

    def test_handles_missing_fta_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FTA").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.fta
    end

    def test_handles_missing_ft_pct_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("FT_PCT").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.ft_pct
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
