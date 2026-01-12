require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsPlayersTest < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_players_on_court_returns_collection
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_players_on_court_returns_player_stat_objects
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744)

      assert_kind_of TeamOnOffPlayerStat, result.first
    end

    def test_players_on_court_parses_vs_player_id
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_equal 201_566, result.vs_player_id
    end

    def test_players_on_court_parses_vs_player_name
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_equal "Russell Westbrook", result.vs_player_name
    end

    def test_players_on_court_parses_court_status
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_equal "On", result.court_status
    end

    def test_players_off_court_returns_collection
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_off_response.to_json)

      result = TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_players_off_court_returns_player_stat_objects
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_off_response.to_json)

      result = TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744)

      assert_kind_of TeamOnOffPlayerStat, result.first
    end

    def test_players_on_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: players_on_response.to_json)

      TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_players_off_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: players_off_response.to_json)

      TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    private

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
