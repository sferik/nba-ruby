require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3StarterBenchBasicTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_starter_bench_stats_returns_collection
      stub_traditional_v3_with_starter_bench_request

      assert_instance_of Collection, BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001")
    end

    def test_starter_bench_stats_parses_identity
      stub_traditional_v3_with_starter_bench_request

      starter = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").first

      assert_predicate starter, :starters?
      assert_equal "0022400001", starter.game_id
      assert_equal Team::GSW, starter.team_id
      assert_equal "starters", starter.starters_bench
    end

    def test_starter_bench_stats_parses_team_info
      stub_traditional_v3_with_starter_bench_request

      starter = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").first

      assert_equal "Warriors", starter.team_name
      assert_equal "GSW", starter.team_abbreviation
      assert_equal "Golden State", starter.team_city
    end

    def test_starter_bench_stats_parses_shooting
      stub_traditional_v3_with_starter_bench_request

      starter = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").first

      assert_equal "120:00", starter.min
      assert_equal 25, starter.fgm
      assert_equal 50, starter.fga
      assert_in_delta 0.5, starter.fg_pct
      assert_equal 10, starter.fg3m
    end

    def test_starter_bench_stats_parses_counting
      stub_traditional_v3_with_starter_bench_request

      starter = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").first

      assert_equal 5, starter.oreb
      assert_equal 20, starter.dreb
      assert_equal 25, starter.reb
      assert_equal 14, starter.ast
      assert_equal 4, starter.stl
    end

    def test_starter_bench_stats_includes_bench
      stub_traditional_v3_with_starter_bench_request

      stats = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001")

      assert_equal 2, stats.size
      assert_predicate stats.last, :bench?
    end

    private

    def stub_traditional_v3_with_starter_bench_request
      stub_request(:get, /boxscoretraditionalv3.*GameID=0022400001/)
        .to_return(body: traditional_v3_with_starter_bench_response.to_json)
    end

    def traditional_v3_with_starter_bench_response
      {boxScoreTraditional: {homeTeam: home_team_with_starter_bench, awayTeam: nil}}
    end

    def home_team_with_starter_bench
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: {starters: starter_bench_stats, bench: starter_bench_stats},
       players: []}
    end
  end
end
