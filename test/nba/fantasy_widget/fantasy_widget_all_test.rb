require_relative "../../test_helper"

module NBA
  class FantasyWidgetAllTest < Minitest::Test
    cover FantasyWidget

    def test_all_returns_collection
      stub_fantasy_widget_request

      assert_instance_of Collection, FantasyWidget.all
    end

    def test_all_parses_player_info
      stub_fantasy_widget_request

      player = FantasyWidget.all.first

      assert_equal 201_939, player.player_id
      assert_equal "Stephen Curry", player.player_name
      assert_equal "G", player.player_position
    end

    def test_all_parses_team_info
      stub_fantasy_widget_request

      player = FantasyWidget.all.first

      assert_equal Team::GSW, player.team_id
      assert_equal "GSW", player.team_abbreviation
    end

    def test_all_parses_fantasy_points
      stub_fantasy_widget_request

      player = FantasyWidget.all.first

      assert_in_delta 45.2, player.fan_duel_pts
      assert_in_delta 52.8, player.nba_fantasy_pts
    end

    def test_all_parses_game_stats
      stub_fantasy_widget_request

      player = FantasyWidget.all.first

      assert_equal 82, player.gp
      assert_in_delta 34.5, player.min
    end

    def test_all_parses_scoring_stats
      stub_fantasy_widget_request

      player = FantasyWidget.all.first

      assert_in_delta 29.4, player.pts
      assert_in_delta 6.1, player.reb
      assert_in_delta 6.3, player.ast
    end

    def test_all_with_custom_season
      stub_request(:get, /fantasywidget.*Season=2022-23/)
        .to_return(body: fantasy_widget_response.to_json)

      FantasyWidget.all(season: 2022)

      assert_requested :get, /fantasywidget.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /fantasywidget.*SeasonType=Playoffs/)
        .to_return(body: fantasy_widget_response.to_json)

      FantasyWidget.all(season_type: "Playoffs")

      assert_requested :get, /fantasywidget.*SeasonType=Playoffs/
    end

    def test_all_with_active_players
      stub_request(:get, /fantasywidget.*ActivePlayers=N/)
        .to_return(body: fantasy_widget_response.to_json)

      FantasyWidget.all(active_players: "N")

      assert_requested :get, /fantasywidget.*ActivePlayers=N/
    end

    def test_all_with_last_n_games
      stub_request(:get, /fantasywidget.*LastNGames=10/)
        .to_return(body: fantasy_widget_response.to_json)

      FantasyWidget.all(last_n_games: 10)

      assert_requested :get, /fantasywidget.*LastNGames=10/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /fantasywidget.*LeagueID=00/)
        .to_return(body: fantasy_widget_response.to_json)

      FantasyWidget.all(league: league)

      assert_requested :get, /fantasywidget.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /fantasywidget.*LeagueID=00/)
        .to_return(body: fantasy_widget_response.to_json)

      FantasyWidget.all(league: "00")

      assert_requested :get, /fantasywidget.*LeagueID=00/
    end

    private

    def stub_fantasy_widget_request
      stub_request(:get, /fantasywidget/).to_return(body: fantasy_widget_response.to_json)
    end

    def fantasy_widget_response
      {resultSets: [{name: "FantasyWidgetResult",
                     headers: %w[PLAYER_ID PLAYER_NAME PLAYER_POSITION TEAM_ID TEAM_ABBREVIATION
                       GP MIN FAN_DUEL_PTS NBA_FANTASY_PTS PTS REB AST],
                     rowSet: [[201_939, "Stephen Curry", "G", Team::GSW, "GSW",
                       82, 34.5, 45.2, 52.8, 29.4, 6.1, 6.3]]}]}
    end
  end
end
