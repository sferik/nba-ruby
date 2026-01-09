require_relative "../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3NilStatsTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_handles_missing_matchup_minutes
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.matchup_minutes
      assert_nil stat.matchup_minutes_sort
    end

    def test_handles_missing_partial_possessions
      stub_response_with_identity_only

      assert_nil BoxScoreMatchupsV3.find(game: "0022400001").first.partial_possessions
    end

    def test_handles_missing_time_percentages
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.percentage_defender_total_time
      assert_nil stat.percentage_offensive_total_time
      assert_nil stat.percentage_total_time_both_on
    end

    def test_handles_missing_switches_on
      stub_response_with_identity_only

      assert_nil BoxScoreMatchupsV3.find(game: "0022400001").first.switches_on
    end

    def test_handles_missing_player_and_team_points
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.player_points
      assert_nil stat.team_points
    end

    def test_handles_missing_matchup_assists
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.matchup_assists
      assert_nil stat.matchup_potential_assists
    end

    def test_handles_missing_matchup_turnovers_and_blocks
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.matchup_turnovers
      assert_nil stat.matchup_blocks
    end

    def test_handles_missing_field_goal_stats
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.matchup_field_goals_made
      assert_nil stat.matchup_field_goals_attempted
      assert_nil stat.matchup_field_goals_percentage
    end

    def test_handles_missing_three_point_stats
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.matchup_three_pointers_made
      assert_nil stat.matchup_three_pointers_attempted
      assert_nil stat.matchup_three_pointers_percentage
    end

    def test_handles_missing_help_defense_stats
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.help_blocks
      assert_nil stat.help_field_goals_made
    end

    def test_handles_missing_help_defense_fg_stats
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.help_field_goals_attempted
      assert_nil stat.help_field_goals_percentage
    end

    def test_handles_missing_free_throw_stats
      stub_response_with_identity_only

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.matchup_free_throws_made
      assert_nil stat.matchup_free_throws_attempted
      assert_nil stat.shooting_fouls
    end

    private

    def stub_response_with_identity_only
      data = team_identity_data.merge(offensive_player_data, defensive_player_data)
      response = {boxScoreMatchups: {homeTeam: {players: [data]}, awayTeam: {players: []}}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)
    end
  end
end
