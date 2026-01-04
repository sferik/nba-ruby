require_relative "../test_helper"
require_relative "../support/live_box_score_test_helpers"

module NBA
  class LiveBoxScoreMissingFieldsShootingTest < Minitest::Test
    include LiveBoxScoreTestHelpers

    cover LiveBoxScore

    def test_handles_missing_field_goals_made
      stats = all_stats.except("fieldGoalsMade")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.field_goals_made
    end

    def test_handles_missing_field_goals_attempted
      stats = all_stats.except("fieldGoalsAttempted")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.field_goals_attempted
    end

    def test_handles_missing_field_goals_percentage
      stats = all_stats.except("fieldGoalsPercentage")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.field_goals_percentage
    end

    def test_handles_missing_three_pointers_made
      stats = all_stats.except("threePointersMade")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.three_pointers_made
    end

    def test_handles_missing_three_pointers_attempted
      stats = all_stats.except("threePointersAttempted")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.three_pointers_attempted
    end

    def test_handles_missing_three_pointers_percentage
      stats = all_stats.except("threePointersPercentage")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.three_pointers_percentage
    end

    def test_handles_missing_free_throws_made
      stats = all_stats.except("freeThrowsMade")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.free_throws_made
    end

    def test_handles_missing_free_throws_attempted
      stats = all_stats.except("freeThrowsAttempted")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.free_throws_attempted
    end

    def test_handles_missing_free_throws_percentage
      stats = all_stats.except("freeThrowsPercentage")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.free_throws_percentage
    end
  end
end
