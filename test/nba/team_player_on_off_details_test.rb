require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffDetailsTest < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_overall_constant
      assert_equal "OverallTeamPlayerOnOffDetails", TeamPlayerOnOffDetails::OVERALL
    end

    def test_players_on_constant
      assert_equal "PlayersOnCourtTeamPlayerOnOffDetails", TeamPlayerOnOffDetails::PLAYERS_ON
    end

    def test_players_off_constant
      assert_equal "PlayersOffCourtTeamPlayerOnOffDetails", TeamPlayerOnOffDetails::PLAYERS_OFF
    end

    def test_overall_returns_collection
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: overall_response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_overall_returns_overall_stat_objects
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: overall_response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_kind_of TeamOnOffOverallStat, result.first
    end

    def test_overall_parses_group_set
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: overall_response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_equal "Overall", result.group_set
    end

    def test_overall_parses_group_value
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: overall_response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744).first

      assert_equal "On Court", result.group_value
    end

    def test_overall_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: overall_response.to_json)

      TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    private

    def overall_headers
      %w[GROUP_SET GROUP_VALUE TEAM_ID TEAM_ABBREVIATION TEAM_NAME GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL
        BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK W_RANK L_RANK W_PCT_RANK MIN_RANK
        FGM_RANK FGA_RANK FG_PCT_RANK FG3M_RANK FG3A_RANK FG3_PCT_RANK FTM_RANK
        FTA_RANK FT_PCT_RANK OREB_RANK DREB_RANK REB_RANK AST_RANK TOV_RANK
        STL_RANK BLK_RANK BLKA_RANK PF_RANK PFD_RANK PTS_RANK PLUS_MINUS_RANK]
    end

    def overall_row
      ["Overall", "On Court", 1_610_612_744, "GSW", "Warriors", 82, 46, 36, 0.561, 240.0,
        39.6, 87.8, 0.451, 14.8, 40.2, 0.368, 17.8, 22.1, 0.805, 9.1, 34.8, 43.9,
        27.5, 14.1, 7.6, 4.8, 4.2, 20.1, 18.9, 111.8, 2.5, 1, 5, 8, 6, 15, 10, 12,
        8, 3, 5, 7, 14, 16, 9, 20, 11, 13, 4, 18, 7, 19, 22, 25, 17, 2, 6]
    end

    def overall_response
      {resultSets: [{name: "OverallTeamPlayerOnOffDetails", headers: overall_headers, rowSet: [overall_row]}]}
    end
  end
end
