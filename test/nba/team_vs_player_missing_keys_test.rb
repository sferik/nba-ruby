require_relative "../test_helper"

module NBA
  class TeamVsPlayerMissingKeysTest < Minitest::Test
    cover TeamVsPlayer

    def test_handles_missing_team_id_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("TEAM_ID").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.team_id
    end

    def test_handles_missing_vs_player_id_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("VS_PLAYER_ID").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.vs_player_id
    end

    def test_handles_missing_court_status_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("COURT_STATUS").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.court_status
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("GP").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.gp
    end

    def test_handles_missing_min_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("MIN").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.min
    end

    def test_handles_missing_pts_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("PTS").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.pts
    end

    def test_handles_missing_reb_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("REB").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.reb
    end

    def test_handles_missing_ast_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("AST").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.ast
    end

    def test_handles_missing_stl_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("STL").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.stl
    end

    def test_handles_missing_blk_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("BLK").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.blk
    end

    def test_handles_missing_tov_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("TOV").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.tov
    end

    def test_handles_missing_fg_pct_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("FG_PCT").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.fg_pct
    end

    def test_handles_missing_plus_minus_key
      stub_request(:get, /teamvsplayer/).to_return(body: response_missing_key("PLUS_MINUS").to_json)
      stat = TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566).first

      assert_nil stat.plus_minus
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "Overall", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[TEAM_ID VS_PLAYER_ID COURT_STATUS GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def row
      [1_610_612_744, 201_566, "Overall", 24, 32.5, 106.4, 45.7, 26.1, 8.2, 5.3, 13.1, 0.467, 8.5]
    end
  end
end
