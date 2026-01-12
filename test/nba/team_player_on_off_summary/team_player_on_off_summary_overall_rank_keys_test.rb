require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffSummaryOverallRankKeysTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def test_handles_missing_gp_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("GP_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.gp_rank
    end

    def test_handles_missing_w_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("W_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.w_rank
    end

    def test_handles_missing_l_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("L_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.l_rank
    end

    def test_handles_missing_w_pct_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("W_PCT_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.w_pct_rank
    end

    def test_handles_missing_min_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("MIN_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.min_rank
    end

    def test_handles_missing_fgm_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FGM_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fgm_rank
    end

    def test_handles_missing_fga_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FGA_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fga_rank
    end

    def test_handles_missing_fg_pct_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FG_PCT_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fg_pct_rank
    end

    def test_handles_missing_fg3m_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FG3M_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fg3m_rank
    end

    def test_handles_missing_fg3a_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FG3A_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fg3a_rank
    end

    def test_handles_missing_fg3_pct_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FG3_PCT_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fg3_pct_rank
    end

    def test_handles_missing_ftm_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FTM_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.ftm_rank
    end

    def test_handles_missing_fta_rank_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("FTA_RANK").to_json)
      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first

      assert_nil result.fta_rank
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "OverallTeamPlayerOnOffSummary", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[GROUP_SET GROUP_VALUE TEAM_ID TEAM_ABBREVIATION TEAM_NAME GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL
        BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK W_RANK L_RANK W_PCT_RANK MIN_RANK
        FGM_RANK FGA_RANK FG_PCT_RANK FG3M_RANK FG3A_RANK FG3_PCT_RANK FTM_RANK
        FTA_RANK FT_PCT_RANK OREB_RANK DREB_RANK REB_RANK AST_RANK TOV_RANK
        STL_RANK BLK_RANK BLKA_RANK PF_RANK PFD_RANK PTS_RANK PLUS_MINUS_RANK]
    end

    def row
      ["Overall", "On Court", 1_610_612_744, "GSW", "Warriors", 82, 46, 36, 0.561, 240.0,
        39.6, 87.8, 0.451, 14.8, 40.2, 0.368, 17.8, 22.1, 0.805, 9.1, 34.8, 43.9,
        27.5, 14.1, 7.6, 4.8, 4.2, 20.1, 18.9, 111.8, 2.5, 1, 5, 8, 6, 15, 10, 12,
        8, 3, 5, 7, 14, 16, 9, 20, 11, 13, 4, 18, 7, 19, 22, 25, 17, 2, 6]
    end
  end
end
