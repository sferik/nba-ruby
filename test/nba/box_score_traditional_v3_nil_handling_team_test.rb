require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3NilHandlingTeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_handles_missing_home_team_for_teams
      response = {boxScoreTraditional: {awayTeam: team_with_stats(Team::LAL)}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreTraditionalV3.team_stats(game: "0022400001").size
    end

    def test_team_stats_nil_for_missing_minutes_key
      response = {boxScoreTraditional: {homeTeam: team_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_nil BoxScoreTraditionalV3.team_stats(game: "0022400001").first.min
    end

    def test_team_stats_nil_for_missing_shooting_keys
      response = {boxScoreTraditional: {homeTeam: team_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.fgm
      assert_nil stat.fga
      assert_nil stat.fg_pct
      assert_nil stat.fg3m
      assert_nil stat.fg3a
    end

    def test_team_stats_nil_for_missing_free_throw_keys
      response = {boxScoreTraditional: {homeTeam: team_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.ftm
      assert_nil stat.fta
      assert_nil stat.ft_pct
    end

    def test_team_stats_nil_for_missing_rebound_keys
      response = {boxScoreTraditional: {homeTeam: team_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.oreb
      assert_nil stat.dreb
      assert_nil stat.reb
    end

    def test_team_stats_nil_for_missing_playmaking_stat_keys
      response = {boxScoreTraditional: {homeTeam: team_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.ast
      assert_nil stat.stl
      assert_nil stat.blk
      assert_nil stat.tov
    end

    def test_team_stats_nil_for_missing_scoring_stat_keys
      response = {boxScoreTraditional: {homeTeam: team_with_empty_stats, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.pf
      assert_nil stat.pts
      assert_nil stat.plus_minus
    end

    def test_team_stats_nil_for_missing_team_keys
      response = {boxScoreTraditional: {homeTeam: {statistics: {minutes: "240:00"}}, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.team_id
      assert_nil stat.team_name
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
    end

    def test_team_stats_handles_missing_statistics_key
      team_data = {teamId: Team::GSW, teamName: "Warriors"}
      response = {boxScoreTraditional: {homeTeam: team_data, awayTeam: nil}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.fgm
    end

    private

    def team_with_empty_stats
      {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
    end

    def team_with_stats(team_id)
      {teamId: team_id, teamName: "Lakers", statistics: traditional_team_stats}
    end
  end
end
