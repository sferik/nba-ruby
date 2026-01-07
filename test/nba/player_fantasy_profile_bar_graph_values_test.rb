require_relative "../test_helper"

module NBA
  class PlayerFantasyProfileBarGraphValuesTest < Minitest::Test
    cover PlayerFantasyProfileBarGraph

    def test_parses_player_id
      assert_equal 201_939, last_five_stat.player_id
    end

    def test_parses_player_name
      assert_equal "Stephen Curry", last_five_stat.player_name
    end

    def test_parses_team_id
      assert_equal 1_610_612_744, last_five_stat.team_id
    end

    def test_parses_team_abbreviation
      assert_equal "GSW", last_five_stat.team_abbreviation
    end

    def test_parses_fan_duel_pts
      assert_in_delta 45.2, last_five_stat.fan_duel_pts
    end

    def test_parses_nba_fantasy_pts
      assert_in_delta 52.1, last_five_stat.nba_fantasy_pts
    end

    def test_parses_pts
      assert_in_delta 26.4, last_five_stat.pts
    end

    def test_parses_reb
      assert_in_delta 5.7, last_five_stat.reb
    end

    def test_parses_ast
      assert_in_delta 6.1, last_five_stat.ast
    end

    def test_parses_fg3m
      assert_in_delta 4.3, last_five_stat.fg3m
    end

    def test_parses_fg_pct
      assert_in_delta 0.467, last_five_stat.fg_pct
    end

    def test_parses_ft_pct
      assert_in_delta 0.917, last_five_stat.ft_pct
    end

    def test_parses_stl
      assert_in_delta 1.2, last_five_stat.stl
    end

    def test_parses_blk
      assert_in_delta 0.3, last_five_stat.blk
    end

    def test_parses_tov
      assert_in_delta 3.1, last_five_stat.tov
    end

    private

    def last_five_stat
      stub_request(:get, /playerfantasyprofilebargraph/).to_return(body: last_five_response.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939).first
    end

    def last_five_response
      {resultSets: [{name: "LastFiveGamesAvg", headers: headers,
                     rowSet: [[201_939, "Stephen Curry", 1_610_612_744, "GSW", 45.2, 52.1, 26.4, 5.7,
                       6.1, 4.3, 0.467, 0.917, 1.2, 0.3, 3.1]]}]}
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION FAN_DUEL_PTS NBA_FANTASY_PTS PTS REB AST
        FG3M FG_PCT FT_PCT STL BLK TOV]
    end
  end
end
