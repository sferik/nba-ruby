require_relative "../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3StatsTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_find_parses_matchup_minutes
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "05:30", stat.matchup_minutes
      assert_in_delta 5.5, stat.matchup_minutes_sort
    end

    def test_find_parses_partial_possessions
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_in_delta 12.5, stat.partial_possessions
    end

    def test_find_parses_time_percentages
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_in_delta 0.15, stat.percentage_defender_total_time
      assert_in_delta 0.18, stat.percentage_offensive_total_time
      assert_in_delta 0.25, stat.percentage_total_time_both_on
    end

    def test_find_parses_switches_on
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 3, stat.switches_on
    end

    def test_find_parses_player_and_team_points
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 8, stat.player_points
      assert_equal 12, stat.team_points
    end

    def test_find_parses_matchup_assists
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 2, stat.matchup_assists
      assert_equal 3, stat.matchup_potential_assists
    end

    def test_find_parses_matchup_turnovers_and_blocks
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 1, stat.matchup_turnovers
      assert_equal 0, stat.matchup_blocks
    end

    private

    def stub_matchups_request
      stub_request(:get, /boxscorematchupsv3.*GameID=0022400001/)
        .to_return(body: matchups_v3_response.to_json)
    end
  end
end
