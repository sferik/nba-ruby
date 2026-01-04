require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreMiscV3PlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreMiscV3

    def test_player_stats_returns_collection
      stub_misc_v3_request

      result = BoxScoreMiscV3.player_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_player_stats_parses_identity
      stub_misc_v3_request

      stat = BoxScoreMiscV3.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
    end

    def test_player_stats_parses_minutes
      stub_misc_v3_request

      stat = BoxScoreMiscV3.player_stats(game: "0022400001").first

      assert_equal "32:45", stat.min
    end

    def test_player_stats_parses_points_stats
      stub_misc_v3_request

      stat = BoxScoreMiscV3.player_stats(game: "0022400001").first

      assert_equal 8, stat.pts_off_tov
      assert_equal 4, stat.pts_2nd_chance
      assert_equal 6, stat.pts_fb
      assert_equal 10, stat.pts_paint
    end

    def test_player_stats_parses_opponent_stats
      stub_misc_v3_request

      stat = BoxScoreMiscV3.player_stats(game: "0022400001").first

      assert_equal 2, stat.opp_pts_off_tov
      assert_equal 2, stat.opp_pts_2nd_chance
      assert_equal 4, stat.opp_pts_fb
      assert_equal 6, stat.opp_pts_paint
    end

    def test_player_stats_parses_defense_stats
      stub_misc_v3_request

      stat = BoxScoreMiscV3.player_stats(game: "0022400001").first

      assert_equal 0, stat.blk
      assert_equal 1, stat.blka
      assert_equal 2, stat.pf
      assert_equal 3, stat.pfd
    end

    private

    def stub_misc_v3_request
      stub_request(:get, /boxscoremiscv3.*GameID=0022400001/)
        .to_return(body: misc_v3_response.to_json)
    end

    def misc_v3_response
      {
        boxScoreMisc: {
          homeTeam: home_team_data,
          awayTeam: away_team_data
        }
      }
    end

    def home_team_data
      {
        teamId: Team::GSW,
        teamName: "Warriors",
        teamTricode: "GSW",
        teamCity: "Golden State",
        statistics: misc_team_stats,
        players: [misc_player_data]
      }
    end

    def away_team_data
      {
        teamId: Team::LAL,
        teamName: "Lakers",
        teamTricode: "LAL",
        teamCity: "Los Angeles",
        statistics: misc_team_stats,
        players: []
      }
    end
  end
end
