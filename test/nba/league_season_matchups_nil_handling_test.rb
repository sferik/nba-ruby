require_relative "../test_helper"

module NBA
  class LeagueSeasonMatchupsNilHandlingTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_all_handles_missing_season_id
      result = matchups_without("SEASON_ID")

      assert_nil result.first.season_id
    end

    def test_all_handles_missing_off_player_id
      result = matchups_without("OFF_PLAYER_ID")

      assert_nil result.first.off_player_id
    end

    def test_all_handles_missing_off_player_name
      result = matchups_without("OFF_PLAYER_NAME")

      assert_nil result.first.off_player_name
    end

    def test_all_handles_missing_def_player_id
      result = matchups_without("DEF_PLAYER_ID")

      assert_nil result.first.def_player_id
    end

    def test_all_handles_missing_def_player_name
      result = matchups_without("DEF_PLAYER_NAME")

      assert_nil result.first.def_player_name
    end

    def test_all_handles_missing_gp
      result = matchups_without("GP")

      assert_nil result.first.gp
    end

    def test_all_handles_missing_matchup_min
      result = matchups_without("MATCHUP_MIN")

      assert_nil result.first.matchup_min
    end

    def test_all_handles_missing_partial_poss
      result = matchups_without("PARTIAL_POSS")

      assert_nil result.first.partial_poss
    end

    def test_all_handles_missing_player_pts
      result = matchups_without("PLAYER_PTS")

      assert_nil result.first.player_pts
    end

    def test_all_handles_missing_team_pts
      result = matchups_without("TEAM_PTS")

      assert_nil result.first.team_pts
    end

    def test_all_handles_missing_matchup_ast
      result = matchups_without("MATCHUP_AST")

      assert_nil result.first.matchup_ast
    end

    def test_all_handles_missing_matchup_tov
      result = matchups_without("MATCHUP_TOV")

      assert_nil result.first.matchup_tov
    end

    def test_all_handles_missing_matchup_blk
      result = matchups_without("MATCHUP_BLK")

      assert_nil result.first.matchup_blk
    end

    def test_all_handles_missing_matchup_fgm
      result = matchups_without("MATCHUP_FGM")

      assert_nil result.first.matchup_fgm
    end

    def test_all_handles_missing_matchup_fga
      result = matchups_without("MATCHUP_FGA")

      assert_nil result.first.matchup_fga
    end

    def test_all_handles_missing_matchup_fg_pct
      result = matchups_without("MATCHUP_FG_PCT")

      assert_nil result.first.matchup_fg_pct
    end

    def test_all_handles_missing_matchup_fg3m
      result = matchups_without("MATCHUP_FG3M")

      assert_nil result.first.matchup_fg3m
    end

    def test_all_handles_missing_matchup_fg3a
      result = matchups_without("MATCHUP_FG3A")

      assert_nil result.first.matchup_fg3a
    end

    private

    def matchups_without(header)
      headers = stat_headers.reject { |h| h.eql?(header) }
      row = build_row_without(header)
      response = {resultSets: [{name: "SeasonMatchups", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leagueseasonmatchups/).to_return(body: response.to_json)

      LeagueSeasonMatchups.all(season: 2024)
    end

    def stat_headers
      %w[SEASON_ID OFF_PLAYER_ID OFF_PLAYER_NAME DEF_PLAYER_ID DEF_PLAYER_NAME GP
        MATCHUP_MIN PARTIAL_POSS PLAYER_PTS TEAM_PTS MATCHUP_AST MATCHUP_TOV MATCHUP_BLK
        MATCHUP_FGM MATCHUP_FGA MATCHUP_FG_PCT MATCHUP_FG3M MATCHUP_FG3A MATCHUP_FG3_PCT
        HELP_BLK HELP_FGM HELP_FGA HELP_FG_PERC MATCHUP_FTM MATCHUP_FTA SFL]
    end

    def stat_row
      ["22024", 201_939, "Stephen Curry", 203_507, "Giannis Antetokounmpo", 4,
        12.5, 45.2, 18.0, 22.0, 3.0, 1.0, 0.5,
        6.0, 14.0, 0.429, 2.0, 6.0, 0.333,
        0.0, 1.0, 2.0, 0.500, 4.0, 5.0, 2.0]
    end

    def build_row_without(header)
      idx = stat_headers.index(header)
      stat_row.reject.with_index { |_, i| i.eql?(idx) }
    end
  end
end
