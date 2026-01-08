require_relative "../test_helper"

module NBA
  class TeamPlayerDashboardKeysTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_handles_missing_group_set_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("GROUP_SET").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.group_set
    end

    def test_handles_missing_player_id_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PLAYER_ID").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.player_id
    end

    def test_handles_missing_player_name_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("PLAYER_NAME").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.player_name
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("GP").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.gp
    end

    def test_handles_missing_min_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("MIN").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.min
    end

    def test_handles_missing_w_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("W").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.w
    end

    def test_handles_missing_l_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("L").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.l
    end

    def test_handles_missing_w_pct_key
      stub_request(:get, /teamplayerdashboard/).to_return(body: response_missing_key("W_PCT").to_json)
      result = TeamPlayerDashboard.players(team: 1_610_612_744).first

      assert_nil result.w_pct
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
