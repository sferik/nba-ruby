require_relative "../test_helper"

module NBA
  module CumeStatsPlayerMissingKeysHelper
    GAME_BY_GAME_STATS = CumeStatsPlayer::GAME_BY_GAME_STATS
    TOTAL_PLAYER_STATS = CumeStatsPlayer::TOTAL_PLAYER_STATS

    FULL_GAME_HEADERS = %w[
      GAME_ID MATCHUP GAME_DATE VS_TEAM_ID VS_TEAM_CITY VS_TEAM_NAME MIN SEC
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS
    ].freeze

    FULL_GAME_ROW = [
      "0022400001", "GSW vs. LAL", "2024-10-22", 1_610_612_747, "Los Angeles", "Lakers",
      35, 42, 10, 20, 0.500, 3, 8, 0.375, 7, 8, 0.875, 2, 6, 8, 5, 3, 2, 3, 1, 30
    ].freeze

    FULL_TOTAL_HEADERS = %w[
      PLAYER_ID PLAYER_NAME JERSEY_NUM SEASON GP GS ACTUAL_MINUTES ACTUAL_SECONDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB TOT_REB AST PF STL TOV BLK PTS
      AVG_MIN AVG_SEC AVG_FGM AVG_FGA AVG_FG3M AVG_FG3A AVG_FTM AVG_FTA AVG_OREB AVG_DREB
      AVG_TOT_REB AVG_AST AVG_PF AVG_STL AVG_TOV AVG_BLK AVG_PTS
      MAX_MIN MAX_FGM MAX_FGA MAX_FG3M MAX_FG3A MAX_FTM MAX_FTA MAX_OREB MAX_DREB MAX_REB
      MAX_AST MAX_PF MAX_STL MAX_TOV MAX_BLK MAX_PTS
    ].freeze

    FULL_TOTAL_ROW = [
      201_939, "Stephen Curry", "30", "2024-25", 2, 2, 67, 57,
      18, 38, 0.474, 5, 15, 0.333, 12, 14, 0.857, 3, 11, 14, 12, 5, 3, 5, 1, 53,
      33.5, 28.5, 9.0, 19.0, 2.5, 7.5, 6.0, 7.0, 1.5, 5.5,
      7.0, 6.0, 2.5, 1.5, 2.5, 0.5, 26.5,
      35, 10, 20, 3, 8, 7, 8, 2, 6, 8,
      7, 3, 2, 3, 1, 30
    ].freeze

    def game_headers_without(key)
      FULL_GAME_HEADERS.reject { |h| h.eql?(key) }
    end

    def game_row_without(key)
      game_headers_without(key).map { |h| FULL_GAME_ROW[FULL_GAME_HEADERS.index(h)] }
    end

    def total_headers_without(key)
      FULL_TOTAL_HEADERS.reject { |h| h.eql?(key) }
    end

    def total_row_without(key)
      total_headers_without(key).map { |h| FULL_TOTAL_ROW[FULL_TOTAL_HEADERS.index(h)] }
    end

    def stub_with_game_headers_except(key)
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers_without(key), rowSet: [game_row_without(key)]},
        {name: TOTAL_PLAYER_STATS, headers: FULL_TOTAL_HEADERS, rowSet: [FULL_TOTAL_ROW]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def stub_with_total_headers_except(key)
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: FULL_GAME_HEADERS, rowSet: [FULL_GAME_ROW]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers_without(key), rowSet: [total_row_without(key)]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def find_result
      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")
    end
  end

  class CumeStatsPlayerGameMissingKeysBasicTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_game_id_key
      stub_with_game_headers_except("GAME_ID")

      assert_nil find_result[:game_by_game].first.game_id
    end

    def test_handles_missing_matchup_key
      stub_with_game_headers_except("MATCHUP")

      assert_nil find_result[:game_by_game].first.matchup
    end

    def test_handles_missing_game_date_key
      stub_with_game_headers_except("GAME_DATE")

      assert_nil find_result[:game_by_game].first.game_date
    end

    def test_handles_missing_vs_team_id_key
      stub_with_game_headers_except("VS_TEAM_ID")

      assert_nil find_result[:game_by_game].first.vs_team_id
    end

    def test_handles_missing_vs_team_city_key
      stub_with_game_headers_except("VS_TEAM_CITY")

      assert_nil find_result[:game_by_game].first.vs_team_city
    end

    def test_handles_missing_vs_team_name_key
      stub_with_game_headers_except("VS_TEAM_NAME")

      assert_nil find_result[:game_by_game].first.vs_team_name
    end

    def test_handles_missing_min_key
      stub_with_game_headers_except("MIN")

      assert_nil find_result[:game_by_game].first.min
    end

    def test_handles_missing_sec_key
      stub_with_game_headers_except("SEC")

      assert_nil find_result[:game_by_game].first.sec
    end
  end

  class CumeStatsPlayerGameMissingKeysShotTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_fgm_key
      stub_with_game_headers_except("FGM")

      assert_nil find_result[:game_by_game].first.fgm
    end

    def test_handles_missing_fga_key
      stub_with_game_headers_except("FGA")

      assert_nil find_result[:game_by_game].first.fga
    end

    def test_handles_missing_fg_pct_key
      stub_with_game_headers_except("FG_PCT")

      assert_nil find_result[:game_by_game].first.fg_pct
    end

    def test_handles_missing_fg3m_key
      stub_with_game_headers_except("FG3M")

      assert_nil find_result[:game_by_game].first.fg3m
    end

    def test_handles_missing_fg3a_key
      stub_with_game_headers_except("FG3A")

      assert_nil find_result[:game_by_game].first.fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_with_game_headers_except("FG3_PCT")

      assert_nil find_result[:game_by_game].first.fg3_pct
    end

    def test_handles_missing_ftm_key
      stub_with_game_headers_except("FTM")

      assert_nil find_result[:game_by_game].first.ftm
    end

    def test_handles_missing_fta_key
      stub_with_game_headers_except("FTA")

      assert_nil find_result[:game_by_game].first.fta
    end

    def test_handles_missing_ft_pct_key
      stub_with_game_headers_except("FT_PCT")

      assert_nil find_result[:game_by_game].first.ft_pct
    end
  end

  class CumeStatsPlayerGameMissingKeysOtherTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_oreb_key
      stub_with_game_headers_except("OREB")

      assert_nil find_result[:game_by_game].first.oreb
    end

    def test_handles_missing_dreb_key
      stub_with_game_headers_except("DREB")

      assert_nil find_result[:game_by_game].first.dreb
    end

    def test_handles_missing_reb_key
      stub_with_game_headers_except("REB")

      assert_nil find_result[:game_by_game].first.reb
    end

    def test_handles_missing_ast_key
      stub_with_game_headers_except("AST")

      assert_nil find_result[:game_by_game].first.ast
    end

    def test_handles_missing_pf_key
      stub_with_game_headers_except("PF")

      assert_nil find_result[:game_by_game].first.pf
    end

    def test_handles_missing_stl_key
      stub_with_game_headers_except("STL")

      assert_nil find_result[:game_by_game].first.stl
    end

    def test_handles_missing_tov_key
      stub_with_game_headers_except("TOV")

      assert_nil find_result[:game_by_game].first.tov
    end

    def test_handles_missing_blk_key
      stub_with_game_headers_except("BLK")

      assert_nil find_result[:game_by_game].first.blk
    end

    def test_handles_missing_pts_key
      stub_with_game_headers_except("PTS")

      assert_nil find_result[:game_by_game].first.pts
    end
  end

  class CumeStatsPlayerTotalMissingKeysBasicTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_player_id_key
      stub_with_total_headers_except("PLAYER_ID")

      assert_nil find_result[:total].player_id
    end

    def test_handles_missing_player_name_key
      stub_with_total_headers_except("PLAYER_NAME")

      assert_nil find_result[:total].player_name
    end

    def test_handles_missing_jersey_num_key
      stub_with_total_headers_except("JERSEY_NUM")

      assert_nil find_result[:total].jersey_num
    end

    def test_handles_missing_season_key
      stub_with_total_headers_except("SEASON")

      assert_nil find_result[:total].season
    end

    def test_handles_missing_gp_key
      stub_with_total_headers_except("GP")

      assert_nil find_result[:total].gp
    end

    def test_handles_missing_gs_key
      stub_with_total_headers_except("GS")

      assert_nil find_result[:total].gs
    end

    def test_handles_missing_actual_minutes_key
      stub_with_total_headers_except("ACTUAL_MINUTES")

      assert_nil find_result[:total].actual_minutes
    end

    def test_handles_missing_actual_seconds_key
      stub_with_total_headers_except("ACTUAL_SECONDS")

      assert_nil find_result[:total].actual_seconds
    end
  end

  class CumeStatsPlayerTotalMissingKeysShotTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_fgm_key
      stub_with_total_headers_except("FGM")

      assert_nil find_result[:total].fgm
    end

    def test_handles_missing_fga_key
      stub_with_total_headers_except("FGA")

      assert_nil find_result[:total].fga
    end

    def test_handles_missing_fg_pct_key
      stub_with_total_headers_except("FG_PCT")

      assert_nil find_result[:total].fg_pct
    end

    def test_handles_missing_fg3m_key
      stub_with_total_headers_except("FG3M")

      assert_nil find_result[:total].fg3m
    end

    def test_handles_missing_fg3a_key
      stub_with_total_headers_except("FG3A")

      assert_nil find_result[:total].fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_with_total_headers_except("FG3_PCT")

      assert_nil find_result[:total].fg3_pct
    end

    def test_handles_missing_ftm_key
      stub_with_total_headers_except("FTM")

      assert_nil find_result[:total].ftm
    end

    def test_handles_missing_fta_key
      stub_with_total_headers_except("FTA")

      assert_nil find_result[:total].fta
    end

    def test_handles_missing_ft_pct_key
      stub_with_total_headers_except("FT_PCT")

      assert_nil find_result[:total].ft_pct
    end
  end

  class CumeStatsPlayerTotalMissingKeysOtherTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_oreb_key
      stub_with_total_headers_except("OREB")

      assert_nil find_result[:total].oreb
    end

    def test_handles_missing_dreb_key
      stub_with_total_headers_except("DREB")

      assert_nil find_result[:total].dreb
    end

    def test_handles_missing_tot_reb_key
      stub_with_total_headers_except("TOT_REB")

      assert_nil find_result[:total].tot_reb
    end

    def test_handles_missing_ast_key
      stub_with_total_headers_except("AST")

      assert_nil find_result[:total].ast
    end

    def test_handles_missing_pf_key
      stub_with_total_headers_except("PF")

      assert_nil find_result[:total].pf
    end

    def test_handles_missing_stl_key
      stub_with_total_headers_except("STL")

      assert_nil find_result[:total].stl
    end

    def test_handles_missing_tov_key
      stub_with_total_headers_except("TOV")

      assert_nil find_result[:total].tov
    end

    def test_handles_missing_blk_key
      stub_with_total_headers_except("BLK")

      assert_nil find_result[:total].blk
    end

    def test_handles_missing_pts_key
      stub_with_total_headers_except("PTS")

      assert_nil find_result[:total].pts
    end
  end

  class CumeStatsPlayerTotalMissingKeysAvgTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_avg_min_key
      stub_with_total_headers_except("AVG_MIN")

      assert_nil find_result[:total].avg_min
    end

    def test_handles_missing_avg_sec_key
      stub_with_total_headers_except("AVG_SEC")

      assert_nil find_result[:total].avg_sec
    end

    def test_handles_missing_avg_fgm_key
      stub_with_total_headers_except("AVG_FGM")

      assert_nil find_result[:total].avg_fgm
    end

    def test_handles_missing_avg_fga_key
      stub_with_total_headers_except("AVG_FGA")

      assert_nil find_result[:total].avg_fga
    end

    def test_handles_missing_avg_fg3m_key
      stub_with_total_headers_except("AVG_FG3M")

      assert_nil find_result[:total].avg_fg3m
    end

    def test_handles_missing_avg_fg3a_key
      stub_with_total_headers_except("AVG_FG3A")

      assert_nil find_result[:total].avg_fg3a
    end

    def test_handles_missing_avg_ftm_key
      stub_with_total_headers_except("AVG_FTM")

      assert_nil find_result[:total].avg_ftm
    end

    def test_handles_missing_avg_fta_key
      stub_with_total_headers_except("AVG_FTA")

      assert_nil find_result[:total].avg_fta
    end

    def test_handles_missing_avg_oreb_key
      stub_with_total_headers_except("AVG_OREB")

      assert_nil find_result[:total].avg_oreb
    end

    def test_handles_missing_avg_dreb_key
      stub_with_total_headers_except("AVG_DREB")

      assert_nil find_result[:total].avg_dreb
    end

    def test_handles_missing_avg_tot_reb_key
      stub_with_total_headers_except("AVG_TOT_REB")

      assert_nil find_result[:total].avg_tot_reb
    end

    def test_handles_missing_avg_ast_key
      stub_with_total_headers_except("AVG_AST")

      assert_nil find_result[:total].avg_ast
    end

    def test_handles_missing_avg_pf_key
      stub_with_total_headers_except("AVG_PF")

      assert_nil find_result[:total].avg_pf
    end

    def test_handles_missing_avg_stl_key
      stub_with_total_headers_except("AVG_STL")

      assert_nil find_result[:total].avg_stl
    end

    def test_handles_missing_avg_tov_key
      stub_with_total_headers_except("AVG_TOV")

      assert_nil find_result[:total].avg_tov
    end

    def test_handles_missing_avg_blk_key
      stub_with_total_headers_except("AVG_BLK")

      assert_nil find_result[:total].avg_blk
    end

    def test_handles_missing_avg_pts_key
      stub_with_total_headers_except("AVG_PTS")

      assert_nil find_result[:total].avg_pts
    end
  end

  class CumeStatsPlayerTotalMissingKeysMaxTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_max_min_key
      stub_with_total_headers_except("MAX_MIN")

      assert_nil find_result[:total].max_min
    end

    def test_handles_missing_max_fgm_key
      stub_with_total_headers_except("MAX_FGM")

      assert_nil find_result[:total].max_fgm
    end

    def test_handles_missing_max_fga_key
      stub_with_total_headers_except("MAX_FGA")

      assert_nil find_result[:total].max_fga
    end

    def test_handles_missing_max_fg3m_key
      stub_with_total_headers_except("MAX_FG3M")

      assert_nil find_result[:total].max_fg3m
    end

    def test_handles_missing_max_fg3a_key
      stub_with_total_headers_except("MAX_FG3A")

      assert_nil find_result[:total].max_fg3a
    end

    def test_handles_missing_max_ftm_key
      stub_with_total_headers_except("MAX_FTM")

      assert_nil find_result[:total].max_ftm
    end

    def test_handles_missing_max_fta_key
      stub_with_total_headers_except("MAX_FTA")

      assert_nil find_result[:total].max_fta
    end

    def test_handles_missing_max_oreb_key
      stub_with_total_headers_except("MAX_OREB")

      assert_nil find_result[:total].max_oreb
    end

    def test_handles_missing_max_dreb_key
      stub_with_total_headers_except("MAX_DREB")

      assert_nil find_result[:total].max_dreb
    end

    def test_handles_missing_max_reb_key
      stub_with_total_headers_except("MAX_REB")

      assert_nil find_result[:total].max_reb
    end

    def test_handles_missing_max_ast_key
      stub_with_total_headers_except("MAX_AST")

      assert_nil find_result[:total].max_ast
    end

    def test_handles_missing_max_pf_key
      stub_with_total_headers_except("MAX_PF")

      assert_nil find_result[:total].max_pf
    end

    def test_handles_missing_max_stl_key
      stub_with_total_headers_except("MAX_STL")

      assert_nil find_result[:total].max_stl
    end

    def test_handles_missing_max_tov_key
      stub_with_total_headers_except("MAX_TOV")

      assert_nil find_result[:total].max_tov
    end

    def test_handles_missing_max_blk_key
      stub_with_total_headers_except("MAX_BLK")

      assert_nil find_result[:total].max_blk
    end

    def test_handles_missing_max_pts_key
      stub_with_total_headers_except("MAX_PTS")

      assert_nil find_result[:total].max_pts
    end
  end
end
