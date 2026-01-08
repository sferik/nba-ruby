require_relative "../test_helper"

module NBA
  class TeamPlayerDashboardCountingKeysTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_handles_missing_oreb_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("OREB").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.oreb
    end

    def test_handles_missing_dreb_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("DREB").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.dreb
    end

    def test_handles_missing_reb_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("REB").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.reb
    end

    def test_handles_missing_ast_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("AST").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.ast
    end

    def test_handles_missing_tov_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("TOV").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.tov
    end

    def test_handles_missing_stl_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("STL").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.stl
    end

    def test_handles_missing_blk_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("BLK").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.blk
    end

    def test_handles_missing_blka_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("BLKA").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.blka
    end

    def test_handles_missing_pf_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PF").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.pf
    end

    def test_handles_missing_pfd_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PFD").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.pfd
    end

    def test_handles_missing_pts_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PTS").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.pts
    end

    def test_handles_missing_plus_minus_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PLUS_MINUS").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.plus_minus
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

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "PlayersSeasonTotals", headers: hdrs, rowSet: [rw]}]}
    end
  end
end
