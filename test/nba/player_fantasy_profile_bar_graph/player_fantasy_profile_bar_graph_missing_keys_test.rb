require_relative "../../test_helper"

module NBA
  class PlayerFantasyProfileBarGraphMissingKeysTest < Minitest::Test
    cover PlayerFantasyProfileBarGraph

    def test_handles_missing_player_id_key
      assert_nil build_stat_without("PLAYER_ID").player_id
    end

    def test_handles_missing_player_name_key
      assert_nil build_stat_without("PLAYER_NAME").player_name
    end

    def test_handles_missing_team_id_key
      assert_nil build_stat_without("TEAM_ID").team_id
    end

    def test_handles_missing_team_abbreviation_key
      assert_nil build_stat_without("TEAM_ABBREVIATION").team_abbreviation
    end

    def test_handles_missing_fan_duel_pts_key
      assert_nil build_stat_without("FAN_DUEL_PTS").fan_duel_pts
    end

    def test_handles_missing_nba_fantasy_pts_key
      assert_nil build_stat_without("NBA_FANTASY_PTS").nba_fantasy_pts
    end

    def test_handles_missing_pts_key
      assert_nil build_stat_without("PTS").pts
    end

    def test_handles_missing_reb_key
      assert_nil build_stat_without("REB").reb
    end

    def test_handles_missing_ast_key
      assert_nil build_stat_without("AST").ast
    end

    def test_handles_missing_fg3m_key
      assert_nil build_stat_without("FG3M").fg3m
    end

    def test_handles_missing_fg_pct_key
      assert_nil build_stat_without("FG_PCT").fg_pct
    end

    def test_handles_missing_ft_pct_key
      assert_nil build_stat_without("FT_PCT").ft_pct
    end

    def test_handles_missing_stl_key
      assert_nil build_stat_without("STL").stl
    end

    def test_handles_missing_blk_key
      assert_nil build_stat_without("BLK").blk
    end

    def test_handles_missing_tov_key
      assert_nil build_stat_without("TOV").tov
    end

    private

    def build_stat_without(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      row = all_values.first(headers.size)
      stub_request(:get, /playerfantasyprofilebargraph.*PlayerID=201939/)
        .to_return(body: {resultSets: [{name: "LastFiveGamesAvg", headers: headers, rowSet: [row]}]}.to_json)
      PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201_939).first
    end

    def all_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION FAN_DUEL_PTS NBA_FANTASY_PTS PTS REB AST
        FG3M FG_PCT FT_PCT STL BLK TOV]
    end

    def all_values
      [201_939, "Stephen Curry", 1_610_612_744, "GSW", 45.2, 52.1, 26.4, 5.7, 6.1, 4.3, 0.467,
        0.917, 1.2, 0.3, 3.1]
    end
  end
end
