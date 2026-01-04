require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreMiscV3NilHandlingPlayerTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreMiscV3

    def test_player_stats_returns_nil_for_missing_basic_stat_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.min
    end

    def test_player_stats_returns_nil_for_missing_points_stats
      stat = player_stat_with_empty_stats

      assert_nil stat.pts_off_tov
      assert_nil stat.pts_2nd_chance
      assert_nil stat.pts_fb
      assert_nil stat.pts_paint
    end

    def test_player_stats_returns_nil_for_missing_opponent_stats
      stat = player_stat_with_empty_stats

      assert_nil stat.opp_pts_off_tov
      assert_nil stat.opp_pts_2nd_chance
      assert_nil stat.opp_pts_fb
      assert_nil stat.opp_pts_paint
    end

    def test_player_stats_returns_nil_for_missing_defense_stats
      stat = player_stat_with_empty_stats

      assert_nil stat.blk
      assert_nil stat.blka
      assert_nil stat.pf
      assert_nil stat.pfd
    end

    def test_player_stats_returns_nil_for_missing_player_keys
      stat = player_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
      assert_nil stat.player_id
      assert_equal "", stat.player_name
    end

    def test_player_stats_handles_missing_statistics_key
      player_data = {personId: 201_939, firstName: "Stephen", familyName: "Curry", teamId: Team::GSW}
      response = {boxScoreMisc: {homeTeam: {players: [player_data]}, awayTeam: {players: []}}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stat = BoxScoreMiscV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.pts_off_tov
      assert_nil stat.blk
    end

    private

    def player_stat_with_empty_stats
      stub_player_response(
        {personId: 201_939, firstName: "Stephen",
         familyName: "Curry", teamId: Team::GSW, statistics: {}}
      )
      BoxScoreMiscV3.player_stats(game: "0022400001").first
    end

    def player_stat_with_minimal_data
      stub_player_response({statistics: {minutes: "32:45"}})
      BoxScoreMiscV3.player_stats(game: "0022400001").first
    end

    def stub_player_response(player_data)
      response = {
        boxScoreMisc: {
          homeTeam: {players: [player_data]},
          awayTeam: {players: []}
        }
      }
      stub_request(:get, /boxscoremiscv3/)
        .to_return(body: response.to_json)
    end
  end
end
