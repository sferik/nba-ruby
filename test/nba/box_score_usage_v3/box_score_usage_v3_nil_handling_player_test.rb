require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreUsageV3NilHandlingPlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreUsageV3

    def test_player_stats_returns_nil_for_missing_usage_stats
      player = {personId: 201_939, firstName: "Stephen", familyName: "Curry",
                teamId: Team::GSW, statistics: {}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.usg_pct
    end

    def test_player_stats_returns_nil_for_missing_shooting_stats
      player = {personId: 201_939, statistics: {}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.pct_fgm
      assert_nil stat.pct_fga
      assert_nil stat.pct_fg3m
      assert_nil stat.pct_fg3a
    end

    def test_player_stats_returns_nil_for_missing_free_throw_stats
      player = {personId: 201_939, statistics: {}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.pct_ftm
      assert_nil stat.pct_fta
    end

    def test_player_stats_returns_nil_for_missing_rebound_stats
      player = {personId: 201_939, statistics: {}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.pct_oreb
      assert_nil stat.pct_dreb
      assert_nil stat.pct_reb
    end

    def test_player_stats_returns_nil_for_missing_other_stats
      player = {personId: 201_939, statistics: {}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.pct_ast
      assert_nil stat.pct_tov
      assert_nil stat.pct_blk
      assert_nil stat.pct_pts
    end

    def test_player_stats_returns_nil_for_missing_additional_stats
      player = {personId: 201_939, statistics: {}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.pct_stl
      assert_nil stat.pct_blka
      assert_nil stat.pct_pf
      assert_nil stat.pct_pfd
    end

    def test_player_stats_handles_missing_statistics_key
      player = {personId: 201_939, firstName: "Stephen", familyName: "Curry"}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.usg_pct
      assert_nil stat.pct_fgm
    end

    def test_player_stats_returns_nil_for_missing_player_keys
      player = {statistics: {minutes: "32:45"}}
      stub_player_response([player])
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_nil stat.team_id
      assert_nil stat.player_id
      assert_equal "", stat.player_name
      assert_nil stat.start_position
    end

    private

    def stub_player_response(players)
      response = {boxScoreUsage: {homeTeam: {players: players}, awayTeam: {players: []}}}
      stub_request(:get, /boxscoreusagev3/).to_return(body: response.to_json)
    end
  end
end
