require_relative "synergy_play_types_test_helper"

module NBA
  class SynergyPlayTypesNilHandlingTeamTest < Minitest::Test
    include SynergyPlayTypesTestHelper

    cover SynergyPlayTypes

    def test_handles_missing_fgm_key
      headers = play_type_headers.reject { |h| h == "FGM" }
      row = team_play_type_row.dup
      row.delete_at(9)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.fgm
    end

    def test_handles_missing_fga_key
      headers = play_type_headers.reject { |h| h == "FGA" }
      row = team_play_type_row.dup
      row.delete_at(10)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.fga
    end

    def test_handles_missing_fg_pct_key
      headers = play_type_headers.reject { |h| h == "FG_PCT" }
      row = team_play_type_row.dup
      row.delete_at(11)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.fg_pct
    end

    def test_handles_missing_efg_pct_key
      headers = play_type_headers.reject { |h| h == "EFG_PCT" }
      row = team_play_type_row.dup
      row.delete_at(12)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.efg_pct
    end

    def test_handles_missing_ft_poss_pct_key
      headers = play_type_headers.reject { |h| h == "FT_POSS_PCT" }
      row = team_play_type_row.dup
      row.delete_at(13)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.ft_poss_pct
    end

    def test_handles_missing_tov_poss_pct_key
      headers = play_type_headers.reject { |h| h == "TOV_POSS_PCT" }
      row = team_play_type_row.dup
      row.delete_at(14)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.tov_poss_pct
    end

    def test_handles_missing_sf_poss_pct_key
      headers = play_type_headers.reject { |h| h == "SF_POSS_PCT" }
      row = team_play_type_row.dup
      row.delete_at(15)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.sf_poss_pct
    end

    def test_handles_missing_ppp_key
      headers = play_type_headers.reject { |h| h == "PPP" }
      row = team_play_type_row.dup
      row.delete_at(16)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.ppp
    end

    def test_handles_missing_percentile_key
      headers = play_type_headers.reject { |h| h == "PERCENTILE" }
      row = team_play_type_row.dup
      row.delete_at(17)
      response = {resultSets: [{name: "SynergyPlayType", headers: headers, rowSet: [row]}]}
      stub_request(:get, /synergyplaytypes/).to_return(body: response.to_json)
      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_nil stat.percentile
    end
  end
end
