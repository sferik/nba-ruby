require_relative "../test_helper"

module NBA
  class BoxScoreStarterBenchStatTest < Minitest::Test
    cover BoxScoreStarterBenchStat

    def test_equality_based_on_game_id_team_id_and_starters_bench
      stat1 = BoxScoreStarterBenchStat.new(game_id: "0022400001", team_id: Team::GSW, starters_bench: "starters")
      stat2 = BoxScoreStarterBenchStat.new(game_id: "0022400001", team_id: Team::GSW, starters_bench: "starters")
      stat3 = BoxScoreStarterBenchStat.new(game_id: "0022400001", team_id: Team::GSW, starters_bench: "bench")
      stat4 = BoxScoreStarterBenchStat.new(game_id: "0022400001", team_id: Team::LAL, starters_bench: "starters")

      assert_equal stat1, stat2
      refute_equal stat1, stat3
      refute_equal stat1, stat4
    end

    def test_starters_returns_true_when_starters_bench_is_starters
      stat = BoxScoreStarterBenchStat.new(starters_bench: "starters")

      assert_predicate stat, :starters?
      refute_predicate stat, :bench?
    end

    def test_bench_returns_true_when_starters_bench_is_bench
      stat = BoxScoreStarterBenchStat.new(starters_bench: "bench")

      assert_predicate stat, :bench?
      refute_predicate stat, :starters?
    end

    def test_team_returns_team_object
      stat = BoxScoreStarterBenchStat.new(team_id: Team::GSW)
      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_game_returns_game_object
      stub_request(:get, /boxscoresummaryv2.*GameID=0022400001/)
        .to_return(body: game_summary_response.to_json)
      stat = BoxScoreStarterBenchStat.new(game_id: "0022400001")

      assert_equal "0022400001", stat.game.id
    end

    def test_team_and_game_identifiers_assignable
      stat = sample_stat

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_starters_bench_and_minutes_assignable
      stat = sample_stat

      assert_equal "starters", stat.starters_bench
      assert_equal "120:00", stat.min
    end

    def test_field_goal_stats_assignable
      stat = sample_stat

      assert_equal 25, stat.fgm
      assert_equal 50, stat.fga
      assert_in_delta 0.5, stat.fg_pct
      assert_equal 10, stat.fg3m
    end

    def test_three_point_and_free_throw_stats_assignable
      stat = sample_stat

      assert_in_delta 0.4, stat.fg3_pct
      assert_equal 10, stat.ftm
      assert_equal 12, stat.fta
      assert_in_delta 0.833, stat.ft_pct
    end

    def test_rebound_stats_assignable
      stat = sample_stat

      assert_equal 5, stat.oreb
      assert_equal 20, stat.dreb
      assert_equal 25, stat.reb
    end

    def test_misc_stats_assignable
      stat = sample_stat

      assert_equal 15, stat.ast
      assert_equal 5, stat.stl
      assert_equal 3, stat.blk
      assert_equal 8, stat.tov
      assert_equal 10, stat.pf
    end

    def test_scoring_stats_assignable
      stat = sample_stat

      assert_equal 70, stat.pts
      assert_equal 10, stat.plus_minus
    end

    private

    def sample_stat
      BoxScoreStarterBenchStat.new(game_id: "0022400001", team_id: Team::GSW,
        team_name: "Warriors", team_abbreviation: "GSW", team_city: "Golden State",
        starters_bench: "starters", min: "120:00", fgm: 25, fga: 50, fg_pct: 0.5,
        fg3m: 10, fg3a: 25, fg3_pct: 0.4, ftm: 10, fta: 12, ft_pct: 0.833, oreb: 5,
        dreb: 20, reb: 25, ast: 15, stl: 5, blk: 3, tov: 8, pf: 10, pts: 70, plus_minus: 10)
    end

    def game_summary_response
      {resultSets: [{name: "GameSummary", headers: %w[GAME_DATE_EST GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID],
                     rowSet: [["2024-10-22", "0022400001", Team::GSW, Team::LAL]]}]}
    end
  end
end
