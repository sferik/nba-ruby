require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreMiscV3NilHandlingTeamTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreMiscV3

    def test_team_stats_returns_nil_for_missing_basic_stat_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.min
    end

    def test_team_stats_returns_nil_for_missing_points_stats
      stat = team_stat_with_empty_stats

      assert_nil stat.pts_off_tov
      assert_nil stat.pts_2nd_chance
      assert_nil stat.pts_fb
      assert_nil stat.pts_paint
    end

    def test_team_stats_returns_nil_for_missing_opponent_stats
      stat = team_stat_with_empty_stats

      assert_nil stat.opp_pts_off_tov
      assert_nil stat.opp_pts_2nd_chance
      assert_nil stat.opp_pts_fb
      assert_nil stat.opp_pts_paint
    end

    def test_team_stats_returns_nil_for_missing_defense_stats
      stat = team_stat_with_empty_stats

      assert_nil stat.blk
      assert_nil stat.blka
      assert_nil stat.pf
      assert_nil stat.pfd
    end

    def test_team_stats_handles_missing_statistics_key
      team_data = {teamId: Team::GSW, teamName: "Warriors"}
      response = {boxScoreMisc: {homeTeam: team_data, awayTeam: nil}}
      stub_request(:get, /boxscoremiscv3/).to_return(body: response.to_json)

      stat = BoxScoreMiscV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.pts_off_tov
      assert_nil stat.blk
    end

    def test_team_stats_returns_nil_for_missing_team_keys
      stat = team_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_name
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
    end

    private

    def team_stat_with_empty_stats
      stub_team_response(
        {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      )
      BoxScoreMiscV3.team_stats(game: "0022400001").first
    end

    def team_stat_with_minimal_data
      stub_team_response({statistics: {minutes: "240:00"}})
      BoxScoreMiscV3.team_stats(game: "0022400001").first
    end

    def stub_team_response(team_data)
      response = {
        boxScoreMisc: {homeTeam: team_data, awayTeam: nil}
      }
      stub_request(:get, /boxscoremiscv3/)
        .to_return(body: response.to_json)
    end
  end
end
