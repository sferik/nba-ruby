require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsOverallKeys2Test < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_handles_missing_fg3m_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FG3M").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.fg3m
    end

    def test_handles_missing_fg3a_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FG3A").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FG3_PCT").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.fg3_pct
    end

    def test_handles_missing_ftm_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FTM").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.ftm
    end

    def test_handles_missing_fta_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FTA").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.fta
    end

    def test_handles_missing_ft_pct_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FT_PCT").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.ft_pct
    end

    def test_handles_missing_oreb_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("OREB").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.oreb
    end

    def test_handles_missing_dreb_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("DREB").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.dreb
    end

    def test_handles_missing_reb_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("REB").to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_nil result.reb
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "OverallTeamPlayerOnOffDetails", headers: hdrs, rowSet: [rw]}]}
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
