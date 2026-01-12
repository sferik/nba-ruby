require_relative "synergy_play_types_test_helper"

module NBA
  class SynergyPlayTypesNilHandlingPlayerTest < Minitest::Test
    include SynergyPlayTypesTestHelper

    cover SynergyPlayTypes

    def test_handles_missing_player_id_key
      headers = play_type_headers.reject { |h| h == "PLAYER_ID" }
      row = player_play_type_row[1..]
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.player_id
    end

    def test_handles_missing_player_name_key
      headers = play_type_headers.reject { |h| h == "PLAYER_NAME" }
      row = player_play_type_row.dup
      row.delete_at(1)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.player_name
    end

    def test_handles_missing_team_id_key
      headers = play_type_headers.reject { |h| h == "TEAM_ID" }
      row = player_play_type_row.dup
      row.delete_at(2)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.team_id
    end

    def test_handles_missing_team_abbreviation_key
      headers = play_type_headers.reject { |h| h == "TEAM_ABBREVIATION" }
      row = player_play_type_row.dup
      row.delete_at(3)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.team_abbreviation
    end

    def test_handles_missing_gp_key
      headers = play_type_headers.reject { |h| h == "GP" }
      row = player_play_type_row.dup
      row.delete_at(4)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.gp
    end

    def test_handles_missing_poss_key
      headers = play_type_headers.reject { |h| h == "POSS" }
      row = player_play_type_row.dup
      row.delete_at(5)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.poss
    end

    def test_handles_missing_poss_pct_key
      headers = play_type_headers.reject { |h| h == "POSS_PCT" }
      row = player_play_type_row.dup
      row.delete_at(6)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.poss_pct
    end

    def test_handles_missing_pts_key
      headers = play_type_headers.reject { |h| h == "PTS" }
      row = player_play_type_row.dup
      row.delete_at(7)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.pts
    end

    def test_handles_missing_pts_pct_key
      headers = play_type_headers.reject { |h| h == "PTS_PCT" }
      row = player_play_type_row.dup
      row.delete_at(8)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_nil stat.pts_pct
    end
  end
end
