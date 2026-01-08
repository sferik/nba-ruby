require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffDetailsEdgeCases2Test < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_find_result_set_skips_non_matching_sets
      response = {resultSets: [
        {name: "WrongName1", headers: %w[A], rowSet: [[1]]},
        {name: "OverallTeamPlayerOnOffDetails", headers: overall_headers, rowSet: [overall_row]},
        {name: "WrongName2", headers: %w[B], rowSet: [[2]]}
      ]}
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_equal "Overall", result.first.group_set
      assert_equal "On Court", result.first.group_value
    end

    def test_players_on_court_default_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: players_on_response.to_json)
      TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_players_on_court_default_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: players_on_response.to_json)
      TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_players_off_court_default_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: players_off_response.to_json)
      TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_players_off_court_default_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: players_off_response.to_json)
      TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
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

    def player_headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME
        COURT_STATUS GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA
        FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK
        W_RANK L_RANK W_PCT_RANK MIN_RANK FGM_RANK FGA_RANK FG_PCT_RANK FG3M_RANK
        FG3A_RANK FG3_PCT_RANK FTM_RANK FTA_RANK FT_PCT_RANK OREB_RANK DREB_RANK
        REB_RANK AST_RANK TOV_RANK STL_RANK BLK_RANK BLKA_RANK PF_RANK PFD_RANK
        PTS_RANK PLUS_MINUS_RANK]
    end

    def players_on_row
      ["On", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "On", 20,
        12, 8, 0.600, 48.0, 8.5, 18.2, 0.467, 3.2, 8.5, 0.376, 3.8, 4.6, 0.826, 2.1,
        7.8, 9.9, 6.2, 3.1, 1.8, 1.2, 0.9, 4.5, 4.2, 24.0, 5.5, 1, 2, 3, 4, 5, 6, 7,
        8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    end

    def players_on_response
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffDetails", headers: player_headers, rowSet: [players_on_row]}]}
    end

    def players_off_row
      ["Off", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "Off", 62,
        34, 28, 0.548, 192.0, 31.1, 69.6, 0.447, 11.6, 31.7, 0.366, 14.0, 17.5, 0.800,
        7.0, 27.0, 34.0, 21.3, 11.0, 5.8, 3.6, 3.3, 15.6, 14.7, 87.8, 0.8, 1, 2, 3,
        4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    end

    def players_off_response
      {resultSets: [{name: "PlayersOffCourtTeamPlayerOnOffDetails", headers: player_headers, rowSet: [players_off_row]}]}
    end
  end
end
