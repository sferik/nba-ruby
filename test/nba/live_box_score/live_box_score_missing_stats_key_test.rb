require_relative "../../test_helper"
require_relative "../../support/live_box_score_test_helpers"

module NBA
  class LiveBoxScoreMissingStatsKeyTest < Minitest::Test
    include LiveBoxScoreTestHelpers

    cover LiveBoxScore

    # Test missing statistics hash
    def test_handles_missing_statistics_hash
      response = build_response_with_stats(nil)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.points
      assert_nil stat.rebounds_total
      assert_nil stat.assists
    end

    def test_handles_missing_statistics_key_minutes
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.minutes
    end

    def test_handles_missing_statistics_key_basic_stats
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.points
      assert_nil stat.rebounds_total
      assert_nil stat.assists
    end

    def test_handles_missing_statistics_key_defensive_stats
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.steals
      assert_nil stat.blocks
    end

    def test_handles_missing_statistics_key_game_stats
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.turnovers
      assert_nil stat.fouls_personal
      assert_nil stat.plus_minus
    end

    def test_handles_missing_statistics_key_field_goals
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.field_goals_made
      assert_nil stat.field_goals_attempted
      assert_nil stat.field_goals_percentage
    end

    def test_handles_missing_statistics_key_three_pointers
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.three_pointers_made
      assert_nil stat.three_pointers_attempted
      assert_nil stat.three_pointers_percentage
    end

    def test_handles_missing_statistics_key_free_throws
      response = build_response_with_player(base_player_data)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.free_throws_made
      assert_nil stat.free_throws_attempted
      assert_nil stat.free_throws_percentage
    end
  end
end
