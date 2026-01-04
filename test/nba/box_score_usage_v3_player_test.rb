require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreUsageV3PlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreUsageV3

    def test_player_stats_returns_collection
      stub_usage_v3_request

      assert_instance_of Collection, BoxScoreUsageV3.player_stats(game: "0022400001")
    end

    def test_player_stats_parses_identity_fields
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
    end

    def test_player_stats_parses_team_and_position
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "G", stat.start_position
      assert_equal "32:45", stat.min
    end

    def test_player_stats_parses_shooting_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_in_delta 32.4, stat.usg_pct
      assert_in_delta 0.25, stat.pct_fgm
      assert_in_delta 0.30, stat.pct_fga
      assert_in_delta 0.40, stat.pct_fg3m
    end

    def test_player_stats_parses_rebound_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_in_delta 0.10, stat.pct_oreb
      assert_in_delta 0.12, stat.pct_dreb
      assert_in_delta 0.11, stat.pct_reb
    end

    def test_player_stats_parses_other_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_in_delta 0.28, stat.pct_ast
      assert_in_delta 0.25, stat.pct_tov
      assert_in_delta 0.05, stat.pct_blk
      assert_in_delta 0.40, stat.pct_pts
    end

    def test_player_stats_parses_free_throw_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_in_delta 0.35, stat.pct_fg3a
      assert_in_delta 0.20, stat.pct_ftm
      assert_in_delta 0.22, stat.pct_fta
    end

    def test_player_stats_parses_misc_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.player_stats(game: "0022400001").first

      assert_in_delta 0.15, stat.pct_stl
      assert_in_delta 0.08, stat.pct_blka
      assert_in_delta 0.18, stat.pct_pf
      assert_in_delta 0.20, stat.pct_pfd
    end

    private

    def stub_usage_v3_request
      stub_request(:get, /boxscoreusagev3.*GameID=0022400001/)
        .to_return(body: usage_v3_response.to_json)
    end

    def usage_v3_response
      {
        boxScoreUsage: {
          homeTeam: home_team_data,
          awayTeam: away_team_data
        }
      }
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamTricode: "GSW",
       teamCity: "Golden State", statistics: usage_team_stats,
       players: [usage_player_data]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamTricode: "LAL",
       teamCity: "Los Angeles", statistics: usage_team_stats, players: []}
    end
  end
end
