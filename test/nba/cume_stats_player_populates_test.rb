require_relative "../test_helper"

module NBA
  module CumeStatsPlayerPopulatesHelper
    GAME_BY_GAME_STATS = CumeStatsPlayer::GAME_BY_GAME_STATS
    TOTAL_PLAYER_STATS = CumeStatsPlayer::TOTAL_PLAYER_STATS

    GAME_HEADERS = %w[GAME_ID MATCHUP GAME_DATE VS_TEAM_ID VS_TEAM_CITY VS_TEAM_NAME MIN SEC
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS].freeze

    GAME_ROW = ["0022400001", "GSW vs. LAL", "2024-10-22", 1_610_612_747, "Los Angeles", "Lakers",
      35, 42, 10, 20, 0.500, 3, 8, 0.375, 7, 8, 0.875, 2, 6, 8, 5, 3, 2, 3, 1, 30].freeze

    TOTAL_HEADERS = %w[PLAYER_ID PLAYER_NAME JERSEY_NUM SEASON GP GS ACTUAL_MINUTES ACTUAL_SECONDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB TOT_REB AST PF STL TOV BLK PTS
      AVG_MIN AVG_SEC AVG_FGM AVG_FGA AVG_FG3M AVG_FG3A AVG_FTM AVG_FTA AVG_OREB AVG_DREB
      AVG_TOT_REB AVG_AST AVG_PF AVG_STL AVG_TOV AVG_BLK AVG_PTS
      MAX_MIN MAX_FGM MAX_FGA MAX_FG3M MAX_FG3A MAX_FTM MAX_FTA MAX_OREB MAX_DREB MAX_REB
      MAX_AST MAX_PF MAX_STL MAX_TOV MAX_BLK MAX_PTS].freeze

    TOTAL_ROW = [201_939, "Stephen Curry", "30", "2024-25", 2, 2, 67, 57,
      18, 38, 0.474, 5, 15, 0.333, 12, 14, 0.857, 3, 11, 14, 12, 5, 3, 5, 1, 53,
      33.5, 28.5, 9.0, 19.0, 2.5, 7.5, 6.0, 7.0, 1.5, 5.5,
      7.0, 6.0, 2.5, 1.5, 2.5, 0.5, 26.5,
      35, 10, 20, 3, 8, 7, 8, 2, 6, 8,
      7, 3, 2, 3, 1, 30].freeze

    def response
      {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: GAME_HEADERS, rowSet: [GAME_ROW]},
        {name: TOTAL_PLAYER_STATS, headers: TOTAL_HEADERS, rowSet: [TOTAL_ROW]}
      ]}
    end

    def find_result
      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")
    end
  end

  class CumeStatsPlayerPopulatesGameBasicTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_game_game_id
      assert_equal "0022400001", find_result[:game_by_game].first.game_id
    end

    def test_populates_game_matchup
      assert_equal "GSW vs. LAL", find_result[:game_by_game].first.matchup
    end

    def test_populates_game_game_date
      assert_equal "2024-10-22", find_result[:game_by_game].first.game_date
    end

    def test_populates_game_vs_team_id
      assert_equal 1_610_612_747, find_result[:game_by_game].first.vs_team_id
    end

    def test_populates_game_vs_team_city
      assert_equal "Los Angeles", find_result[:game_by_game].first.vs_team_city
    end

    def test_populates_game_vs_team_name
      assert_equal "Lakers", find_result[:game_by_game].first.vs_team_name
    end

    def test_populates_game_min
      assert_equal 35, find_result[:game_by_game].first.min
    end

    def test_populates_game_sec
      assert_equal 42, find_result[:game_by_game].first.sec
    end
  end

  class CumeStatsPlayerPopulatesGameShotTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_game_fgm
      assert_equal 10, find_result[:game_by_game].first.fgm
    end

    def test_populates_game_fga
      assert_equal 20, find_result[:game_by_game].first.fga
    end

    def test_populates_game_fg_pct
      assert_in_delta 0.500, find_result[:game_by_game].first.fg_pct
    end

    def test_populates_game_fg3m
      assert_equal 3, find_result[:game_by_game].first.fg3m
    end

    def test_populates_game_fg3a
      assert_equal 8, find_result[:game_by_game].first.fg3a
    end

    def test_populates_game_fg3_pct
      assert_in_delta 0.375, find_result[:game_by_game].first.fg3_pct
    end

    def test_populates_game_ftm
      assert_equal 7, find_result[:game_by_game].first.ftm
    end

    def test_populates_game_fta
      assert_equal 8, find_result[:game_by_game].first.fta
    end

    def test_populates_game_ft_pct
      assert_in_delta 0.875, find_result[:game_by_game].first.ft_pct
    end
  end

  class CumeStatsPlayerPopulatesGameOtherTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_game_oreb
      assert_equal 2, find_result[:game_by_game].first.oreb
    end

    def test_populates_game_dreb
      assert_equal 6, find_result[:game_by_game].first.dreb
    end

    def test_populates_game_reb
      assert_equal 8, find_result[:game_by_game].first.reb
    end

    def test_populates_game_ast
      assert_equal 5, find_result[:game_by_game].first.ast
    end

    def test_populates_game_pf
      assert_equal 3, find_result[:game_by_game].first.pf
    end

    def test_populates_game_stl
      assert_equal 2, find_result[:game_by_game].first.stl
    end

    def test_populates_game_tov
      assert_equal 3, find_result[:game_by_game].first.tov
    end

    def test_populates_game_blk
      assert_equal 1, find_result[:game_by_game].first.blk
    end

    def test_populates_game_pts
      assert_equal 30, find_result[:game_by_game].first.pts
    end
  end

  class CumeStatsPlayerPopulatesTotalBasicTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_player_id
      assert_equal 201_939, find_result[:total].player_id
    end

    def test_populates_total_player_name
      assert_equal "Stephen Curry", find_result[:total].player_name
    end

    def test_populates_total_jersey_num
      assert_equal "30", find_result[:total].jersey_num
    end

    def test_populates_total_season
      assert_equal "2024-25", find_result[:total].season
    end

    def test_populates_total_gp
      assert_equal 2, find_result[:total].gp
    end

    def test_populates_total_gs
      assert_equal 2, find_result[:total].gs
    end

    def test_populates_total_actual_minutes
      assert_equal 67, find_result[:total].actual_minutes
    end

    def test_populates_total_actual_seconds
      assert_equal 57, find_result[:total].actual_seconds
    end
  end

  class CumeStatsPlayerPopulatesTotalShotTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_fgm
      assert_equal 18, find_result[:total].fgm
    end

    def test_populates_total_fga
      assert_equal 38, find_result[:total].fga
    end

    def test_populates_total_fg_pct
      assert_in_delta 0.474, find_result[:total].fg_pct
    end

    def test_populates_total_fg3m
      assert_equal 5, find_result[:total].fg3m
    end

    def test_populates_total_fg3a
      assert_equal 15, find_result[:total].fg3a
    end

    def test_populates_total_fg3_pct
      assert_in_delta 0.333, find_result[:total].fg3_pct
    end

    def test_populates_total_ftm
      assert_equal 12, find_result[:total].ftm
    end

    def test_populates_total_fta
      assert_equal 14, find_result[:total].fta
    end

    def test_populates_total_ft_pct
      assert_in_delta 0.857, find_result[:total].ft_pct
    end
  end

  class CumeStatsPlayerPopulatesTotalOtherTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_oreb
      assert_equal 3, find_result[:total].oreb
    end

    def test_populates_total_dreb
      assert_equal 11, find_result[:total].dreb
    end

    def test_populates_total_tot_reb
      assert_equal 14, find_result[:total].tot_reb
    end

    def test_populates_total_ast
      assert_equal 12, find_result[:total].ast
    end

    def test_populates_total_pf
      assert_equal 5, find_result[:total].pf
    end

    def test_populates_total_stl
      assert_equal 3, find_result[:total].stl
    end

    def test_populates_total_tov
      assert_equal 5, find_result[:total].tov
    end

    def test_populates_total_blk
      assert_equal 1, find_result[:total].blk
    end

    def test_populates_total_pts
      assert_equal 53, find_result[:total].pts
    end
  end

  class CumeStatsPlayerPopulatesTotalAvgTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_avg_min
      assert_in_delta 33.5, find_result[:total].avg_min
    end

    def test_populates_total_avg_sec
      assert_in_delta 28.5, find_result[:total].avg_sec
    end

    def test_populates_total_avg_fgm
      assert_in_delta 9.0, find_result[:total].avg_fgm
    end

    def test_populates_total_avg_fga
      assert_in_delta 19.0, find_result[:total].avg_fga
    end

    def test_populates_total_avg_fg3m
      assert_in_delta 2.5, find_result[:total].avg_fg3m
    end

    def test_populates_total_avg_fg3a
      assert_in_delta 7.5, find_result[:total].avg_fg3a
    end

    def test_populates_total_avg_ftm
      assert_in_delta 6.0, find_result[:total].avg_ftm
    end

    def test_populates_total_avg_fta
      assert_in_delta 7.0, find_result[:total].avg_fta
    end

    def test_populates_total_avg_oreb
      assert_in_delta 1.5, find_result[:total].avg_oreb
    end

    def test_populates_total_avg_dreb
      assert_in_delta 5.5, find_result[:total].avg_dreb
    end

    def test_populates_total_avg_tot_reb
      assert_in_delta 7.0, find_result[:total].avg_tot_reb
    end

    def test_populates_total_avg_ast
      assert_in_delta 6.0, find_result[:total].avg_ast
    end

    def test_populates_total_avg_pf
      assert_in_delta 2.5, find_result[:total].avg_pf
    end

    def test_populates_total_avg_stl
      assert_in_delta 1.5, find_result[:total].avg_stl
    end

    def test_populates_total_avg_tov
      assert_in_delta 2.5, find_result[:total].avg_tov
    end

    def test_populates_total_avg_blk
      assert_in_delta 0.5, find_result[:total].avg_blk
    end

    def test_populates_total_avg_pts
      assert_in_delta 26.5, find_result[:total].avg_pts
    end
  end

  class CumeStatsPlayerPopulatesTotalMaxTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_max_min
      assert_equal 35, find_result[:total].max_min
    end

    def test_populates_total_max_fgm
      assert_equal 10, find_result[:total].max_fgm
    end

    def test_populates_total_max_fga
      assert_equal 20, find_result[:total].max_fga
    end

    def test_populates_total_max_fg3m
      assert_equal 3, find_result[:total].max_fg3m
    end

    def test_populates_total_max_fg3a
      assert_equal 8, find_result[:total].max_fg3a
    end

    def test_populates_total_max_ftm
      assert_equal 7, find_result[:total].max_ftm
    end

    def test_populates_total_max_fta
      assert_equal 8, find_result[:total].max_fta
    end

    def test_populates_total_max_oreb
      assert_equal 2, find_result[:total].max_oreb
    end

    def test_populates_total_max_dreb
      assert_equal 6, find_result[:total].max_dreb
    end

    def test_populates_total_max_reb
      assert_equal 8, find_result[:total].max_reb
    end

    def test_populates_total_max_ast
      assert_equal 7, find_result[:total].max_ast
    end

    def test_populates_total_max_pf
      assert_equal 3, find_result[:total].max_pf
    end

    def test_populates_total_max_stl
      assert_equal 2, find_result[:total].max_stl
    end

    def test_populates_total_max_tov
      assert_equal 3, find_result[:total].max_tov
    end

    def test_populates_total_max_blk
      assert_equal 1, find_result[:total].max_blk
    end

    def test_populates_total_max_pts
      assert_equal 30, find_result[:total].max_pts
    end
  end
end
