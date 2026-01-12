require_relative "../../test_helper"

module NBA
  class TeamPlayerDashboardTeamCountingKeysTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_handles_missing_oreb_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("OREB").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.oreb
    end

    def test_handles_missing_dreb_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("DREB").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.dreb
    end

    def test_handles_missing_reb_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("REB").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.reb
    end

    def test_handles_missing_ast_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("AST").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.ast
    end

    def test_handles_missing_tov_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("TOV").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.tov
    end

    def test_handles_missing_stl_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("STL").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.stl
    end

    def test_handles_missing_blk_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("BLK").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.blk
    end

    def test_handles_missing_blka_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("BLKA").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.blka
    end

    def test_handles_missing_pf_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PF").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.pf
    end

    def test_handles_missing_pfd_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PFD").to_json)
      result = TeamPlayerDashboard.team(team: 1_610_612_744).first

      assert_nil result.pfd
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
