require_relative "../test_helper"

module NBA
  class FantasyWidgetEdgeCasesTest < Minitest::Test
    cover FantasyWidget

    def test_all_handles_nil_response
      stub_request(:get, /fantasywidget/).to_return(body: nil)

      result = FantasyWidget.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /fantasywidget/).to_return(body: {resultSets: []}.to_json)

      result = FantasyWidget.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /fantasywidget/).to_return(body: response.to_json)

      result = FantasyWidget.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "FantasyWidgetResult",
                                headers: %w[PLAYER_ID PLAYER_NAME], rowSet: []}]}
      stub_request(:get, /fantasywidget/).to_return(body: response.to_json)

      result = FantasyWidget.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_player_id
      response = {resultSets: [{name: "FantasyWidgetResult",
                                headers: %w[PLAYER_NAME TEAM_ID],
                                rowSet: [["Stephen Curry", Team::GSW]]}]}
      stub_request(:get, /fantasywidget/).to_return(body: response.to_json)

      player = FantasyWidget.all.first

      assert_nil player.player_id
      assert_equal "Stephen Curry", player.player_name
    end

    def test_all_handles_missing_fantasy_pts
      response = {resultSets: [{name: "FantasyWidgetResult",
                                headers: %w[PLAYER_ID PLAYER_NAME],
                                rowSet: [[201_939, "Stephen Curry"]]}]}
      stub_request(:get, /fantasywidget/).to_return(body: response.to_json)

      player = FantasyWidget.all.first

      assert_equal 201_939, player.player_id
      assert_nil player.fan_duel_pts
      assert_nil player.nba_fantasy_pts
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "FantasyWidgetResult", headers: %w[PLAYER_ID PLAYER_NAME FAN_DUEL_PTS],
         rowSet: [[201_939, "Stephen Curry", 45.5]]}
      ]}
      stub_request(:get, /fantasywidget/).to_return(body: response.to_json)

      player = FantasyWidget.all.first

      assert_equal 201_939, player.player_id
      assert_equal "Stephen Curry", player.player_name
    end

    def test_all_default_league_is_nba
      stub_request(:get, /fantasywidget.*LeagueID=00/)
        .to_return(body: {resultSets: [{name: "FantasyWidgetResult", headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}.to_json)

      FantasyWidget.all

      assert_requested :get, /fantasywidget.*LeagueID=00/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /fantasywidget.*SeasonType=Regular%20Season/)
        .to_return(body: {resultSets: [{name: "FantasyWidgetResult", headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}.to_json)

      FantasyWidget.all

      assert_requested :get, /fantasywidget.*SeasonType=Regular%20Season/
    end

    def test_all_default_active_players_is_y
      stub_request(:get, /fantasywidget.*ActivePlayers=Y/)
        .to_return(body: {resultSets: [{name: "FantasyWidgetResult", headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}.to_json)

      FantasyWidget.all

      assert_requested :get, /fantasywidget.*ActivePlayers=Y/
    end

    def test_all_default_last_n_games_is_zero
      stub_request(:get, /fantasywidget.*LastNGames=0/)
        .to_return(body: {resultSets: [{name: "FantasyWidgetResult", headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}.to_json)

      FantasyWidget.all

      assert_requested :get, /fantasywidget.*LastNGames=0/
    end
  end
end
