require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffSummaryOverallValuesTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def setup
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)
      @result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first
    end

    def test_extracts_group_set
      assert_equal "Overall", @result.group_set
    end

    def test_extracts_group_value
      assert_equal "On Court", @result.group_value
    end

    def test_extracts_team_id
      assert_equal 1_610_612_744, @result.team_id
    end

    def test_extracts_team_abbreviation
      assert_equal "GSW", @result.team_abbreviation
    end

    def test_extracts_team_name
      assert_equal "Warriors", @result.team_name
    end

    def test_extracts_gp
      assert_equal 82, @result.gp
    end

    def test_extracts_w
      assert_equal 46, @result.w
    end

    def test_extracts_l
      assert_equal 36, @result.l
    end

    def test_extracts_w_pct
      assert_in_delta 0.561, @result.w_pct
    end

    def test_extracts_min
      assert_in_delta 240.0, @result.min
    end

    def test_extracts_fgm
      assert_in_delta 39.6, @result.fgm
    end

    def test_extracts_fga
      assert_in_delta 87.8, @result.fga
    end

    def test_extracts_fg_pct
      assert_in_delta 0.451, @result.fg_pct
    end

    def test_extracts_fg3m
      assert_in_delta 14.8, @result.fg3m
    end

    def test_extracts_fg3a
      assert_in_delta 40.2, @result.fg3a
    end

    def test_extracts_fg3_pct
      assert_in_delta 0.368, @result.fg3_pct
    end

    def test_extracts_ftm
      assert_in_delta 17.8, @result.ftm
    end

    def test_extracts_fta
      assert_in_delta 22.1, @result.fta
    end

    def test_extracts_ft_pct
      assert_in_delta 0.805, @result.ft_pct
    end

    def test_extracts_oreb
      assert_in_delta 9.1, @result.oreb
    end

    def test_extracts_dreb
      assert_in_delta 34.8, @result.dreb
    end

    def test_extracts_reb
      assert_in_delta 43.9, @result.reb
    end

    private

    def response
      {resultSets: [{name: "OverallTeamPlayerOnOffSummary", headers: headers, rowSet: [row]}]}
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
