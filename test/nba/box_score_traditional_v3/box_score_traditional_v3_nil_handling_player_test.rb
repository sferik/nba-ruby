require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreTraditionalV3NilHandlingPlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreTraditionalV3

    def test_handles_nil_players_in_team
      response = {boxScoreTraditional: {homeTeam: {players: nil}, awayTeam: {players: nil}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditionalV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_home_team_for_players
      response = {boxScoreTraditional: {awayTeam: {players: [traditional_player_data]}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreTraditionalV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_away_team_for_players
      response = {boxScoreTraditional: {homeTeam: {players: [traditional_player_data]}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreTraditionalV3.player_stats(game: "0022400001").size
    end

    def test_player_stats_nil_for_missing_minutes_key
      response = player_with_empty_stats
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)

      assert_nil BoxScoreTraditionalV3.player_stats(game: "0022400001").first.min
    end

    def test_player_stats_nil_for_missing_shooting_keys
      response = player_with_empty_stats
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.fgm
      assert_nil stat.fga
      assert_nil stat.fg_pct
      assert_nil stat.fg3m
      assert_nil stat.fg3a
    end

    def test_player_stats_nil_for_missing_free_throw_keys
      response = player_with_empty_stats
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.ftm
      assert_nil stat.fta
      assert_nil stat.ft_pct
    end

    def test_player_stats_nil_for_missing_rebound_keys
      response = player_with_empty_stats
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.oreb
      assert_nil stat.dreb
      assert_nil stat.reb
    end

    def test_player_stats_nil_for_missing_playmaking_stat_keys
      response = player_with_empty_stats
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.ast
      assert_nil stat.stl
      assert_nil stat.blk
      assert_nil stat.tov
    end

    def test_player_stats_nil_for_missing_scoring_stat_keys
      response = player_with_empty_stats
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.pf
      assert_nil stat.pts
      assert_nil stat.plus_minus
    end

    def test_player_stats_nil_for_missing_player_keys
      player_data = {statistics: {minutes: "32:45"}}
      response = {boxScoreTraditional: {homeTeam: {players: [player_data]}, awayTeam: {players: []}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.team_id
      assert_nil stat.player_id
      assert_equal "", stat.player_name
    end

    def test_player_stats_handles_missing_statistics_key
      player_data = {personId: 201_939, firstName: "Stephen", familyName: "Curry"}
      response = {boxScoreTraditional: {homeTeam: {players: [player_data]}, awayTeam: {players: []}}}
      stub_request(:get, /boxscoretraditionalv3/).to_return(body: response.to_json)
      stat = BoxScoreTraditionalV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.fgm
    end

    private

    def player_with_empty_stats
      player = {personId: 201_939, firstName: "Stephen", familyName: "Curry",
                teamId: Team::GSW, statistics: {}}
      {boxScoreTraditional: {homeTeam: {players: [player]}, awayTeam: {players: []}}}
    end
  end
end
