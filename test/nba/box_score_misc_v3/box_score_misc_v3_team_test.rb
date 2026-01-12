require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreMiscV3TeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreMiscV3

    def test_team_stats_returns_collection
      stub_misc_v3_request

      result = BoxScoreMiscV3.team_stats(game: "0022400001")

      assert_instance_of Collection, result
    end

    def test_team_stats_parses_identity
      stub_misc_v3_request

      stat = BoxScoreMiscV3.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_team_stats_parses_points_stats
      stub_misc_v3_request

      stat = BoxScoreMiscV3.team_stats(game: "0022400001").first

      assert_equal "240:00", stat.min
      assert_equal 20, stat.pts_off_tov
      assert_equal 14, stat.pts_2nd_chance
      assert_equal 18, stat.pts_fb
      assert_equal 48, stat.pts_paint
    end

    def test_team_stats_parses_opponent_stats
      stub_misc_v3_request

      stat = BoxScoreMiscV3.team_stats(game: "0022400001").first

      assert_equal 12, stat.opp_pts_off_tov
      assert_equal 10, stat.opp_pts_2nd_chance
      assert_equal 14, stat.opp_pts_fb
      assert_equal 40, stat.opp_pts_paint
    end

    def test_team_stats_parses_defense_stats
      stub_misc_v3_request

      stat = BoxScoreMiscV3.team_stats(game: "0022400001").first

      assert_equal 5, stat.blk
      assert_equal 3, stat.blka
      assert_equal 18, stat.pf
      assert_equal 22, stat.pfd
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
