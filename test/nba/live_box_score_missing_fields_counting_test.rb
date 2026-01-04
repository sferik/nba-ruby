require_relative "../test_helper"
require_relative "../support/live_box_score_test_helpers"

module NBA
  class LiveBoxScoreMissingFieldsCountingTest < Minitest::Test
    include LiveBoxScoreTestHelpers

    cover LiveBoxScore

    def test_handles_missing_points
      stats = all_stats.except("points")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.points
    end

    def test_handles_missing_rebounds_total
      stats = all_stats.except("reboundsTotal")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.rebounds_total
    end

    def test_handles_missing_rebounds_offensive
      stats = all_stats.except("reboundsOffensive")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.rebounds_offensive
    end

    def test_handles_missing_rebounds_defensive
      stats = all_stats.except("reboundsDefensive")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.rebounds_defensive
    end

    def test_handles_missing_assists
      stats = all_stats.except("assists")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.assists
    end

    def test_handles_missing_steals
      stats = all_stats.except("steals")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.steals
    end

    def test_handles_missing_blocks
      stats = all_stats.except("blocks")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.blocks
    end

    def test_handles_missing_turnovers
      stats = all_stats.except("turnovers")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.turnovers
    end

    def test_handles_missing_fouls_personal
      stats = all_stats.except("foulsPersonal")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.fouls_personal
    end

    def test_handles_missing_plus_minus
      stats = all_stats.except("plusMinusPoints")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.plus_minus
    end

    def test_handles_missing_minutes
      stats = all_stats.except("minutes")
      response = build_response_with_stats(stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.minutes
    end

    def test_parses_minutes_value
      response = build_response_with_stats(all_stats)
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal "PT36M15.00S", stat.minutes
    end
  end
end
