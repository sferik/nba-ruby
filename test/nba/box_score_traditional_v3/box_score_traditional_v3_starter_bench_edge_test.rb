require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3StarterBenchEdgeTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_handles_partial_starter_bench_stats
      response = {
        boxScoreTraditional: {
          homeTeam: {teamId: Team::GSW, statistics: {starters: starter_bench_stats}},
          awayTeam: {teamId: Team::LAL, statistics: {bench: starter_bench_stats}}
        }
      }
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 2, BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").size
    end

    def test_handles_nil_statistics_in_starter_bench
      response = {boxScoreTraditional: {homeTeam: {teamId: Team::GSW, statistics: nil}, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").size
    end

    def test_handles_missing_home_team_for_starter_bench
      response = {boxScoreTraditional: {awayTeam: {teamId: Team::LAL, statistics: {starters: starter_bench_stats}}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      result = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001")

      assert_equal 1, result.size
      assert_equal Team::LAL, result.first.team_id
    end

    def test_handles_missing_away_team_for_starter_bench
      response = {boxScoreTraditional: {homeTeam: {teamId: Team::GSW, statistics: {bench: starter_bench_stats}}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      result = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001")

      assert_equal 1, result.size
      assert_equal Team::GSW, result.first.team_id
    end

    def test_starter_bench_nil_for_missing_stats_keys
      response = {boxScoreTraditional: {homeTeam: starter_bench_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      stat = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.fgm
      assert_nil stat.fga
    end

    def test_starter_bench_nil_for_missing_team_keys
      response = {boxScoreTraditional: {homeTeam: {statistics: {starters: starter_bench_stats}}, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      stat = BoxScoreTraditionalV3.starter_bench_stats(game: "0022400001").first

      assert_nil stat.team_id
      assert_nil stat.team_name
      assert_nil stat.team_abbreviation
    end

    private

    def starter_bench_with_empty_stats
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: {starters: {}}}
    end
  end
end
