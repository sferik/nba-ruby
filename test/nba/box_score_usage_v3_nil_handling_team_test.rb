require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreUsageV3NilHandlingTeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreUsageV3

    def test_team_stats_returns_nil_for_missing_usage_stats
      team = {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.usg_pct
    end

    def test_team_stats_returns_nil_for_missing_shooting_stats
      team = {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.pct_fgm
      assert_nil stat.pct_fga
      assert_nil stat.pct_fg3m
      assert_nil stat.pct_fg3a
    end

    def test_team_stats_returns_nil_for_missing_other_stats
      team = {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.pct_reb
      assert_nil stat.pct_ast
      assert_nil stat.pct_blk
      assert_nil stat.pct_pts
    end

    def test_team_stats_returns_nil_for_missing_rebound_stats
      team = {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.pct_oreb
      assert_nil stat.pct_dreb
      assert_nil stat.pct_tov
    end

    def test_team_stats_returns_nil_for_missing_misc_stats
      team = {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.pct_stl
      assert_nil stat.pct_blka
      assert_nil stat.pct_pf
      assert_nil stat.pct_pfd
    end

    def test_team_stats_handles_missing_statistics_key
      team = {teamId: Team::GSW, teamName: "Warriors"}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.usg_pct
      assert_nil stat.pct_fgm
    end

    def test_team_stats_returns_nil_for_missing_team_keys
      team = {statistics: {minutes: "240:00"}}
      stub_team_response(team)
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_nil stat.team_id
      assert_nil stat.team_name
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
    end

    private

    def stub_team_response(team)
      response = {boxScoreUsage: {homeTeam: team, awayTeam: nil}}
      stub_request(:get, /boxscoreusagev3/).to_return(body: response.to_json)
    end
  end
end
