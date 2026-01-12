require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreUsageV3TeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreUsageV3

    def test_team_stats_returns_collection
      stub_usage_v3_request

      assert_instance_of Collection, BoxScoreUsageV3.team_stats(game: "0022400001")
    end

    def test_team_stats_parses_identity_fields
      stub_usage_v3_request
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
    end

    def test_team_stats_parses_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_in_delta 100.0, stat.usg_pct
      assert_in_delta 1.0, stat.pct_fgm
      assert_in_delta 1.0, stat.pct_reb
      assert_in_delta 1.0, stat.pct_pts
    end

    def test_team_stats_parses_shot_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_in_delta 1.0, stat.pct_fga
      assert_in_delta 1.0, stat.pct_fg3m
      assert_in_delta 1.0, stat.pct_fg3a
      assert_in_delta 1.0, stat.pct_ftm
      assert_in_delta 1.0, stat.pct_fta
    end

    def test_team_stats_parses_rebound_and_assist_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_in_delta 1.0, stat.pct_oreb
      assert_in_delta 1.0, stat.pct_dreb
      assert_in_delta 1.0, stat.pct_ast
      assert_in_delta 1.0, stat.pct_tov
    end

    def test_team_stats_parses_misc_percentages
      stub_usage_v3_request
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_in_delta 1.0, stat.pct_stl
      assert_in_delta 1.0, stat.pct_blk
      assert_in_delta 1.0, stat.pct_blka
      assert_in_delta 1.0, stat.pct_pf
      assert_in_delta 1.0, stat.pct_pfd
    end

    def test_team_stats_parses_minutes
      stub_usage_v3_request
      stat = BoxScoreUsageV3.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
    end

    def test_constants_defined
      assert_equal "PlayerStats", BoxScoreUsageV3::PLAYER_STATS
      assert_equal "TeamStats", BoxScoreUsageV3::TEAM_STATS
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
