require_relative "../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3ShootingTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_find_parses_field_goal_stats
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 3, stat.matchup_field_goals_made
      assert_equal 6, stat.matchup_field_goals_attempted
      assert_in_delta 0.5, stat.matchup_field_goals_percentage
    end

    def test_find_parses_three_point_stats
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 1, stat.matchup_three_pointers_made
      assert_equal 3, stat.matchup_three_pointers_attempted
      assert_in_delta 0.333, stat.matchup_three_pointers_percentage
    end

    def test_find_parses_help_defense_stats
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 1, stat.help_blocks
      assert_equal 2, stat.help_field_goals_made
      assert_equal 4, stat.help_field_goals_attempted
      assert_in_delta 0.5, stat.help_field_goals_percentage
    end

    def test_find_parses_free_throw_stats
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 2, stat.matchup_free_throws_made
      assert_equal 2, stat.matchup_free_throws_attempted
    end

    def test_find_parses_shooting_fouls
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 1, stat.shooting_fouls
    end

    private

    def stub_matchups_request
      stub_request(:get, /boxscorematchupsv3.*GameID=0022400001/)
        .to_return(body: matchups_v3_response.to_json)
    end
  end
end
