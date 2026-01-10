require_relative "box_score_summary_v3_edge_cases_helper"

module NBA
  class BoxScoreSummaryV3ArenaTest < Minitest::Test
    include BoxScoreSummaryV3BaseTestHelpers

    cover BoxScoreSummaryV3

    def test_handles_missing_arena_key
      response = base_response
      response[:boxScoreSummary].delete(:arena)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").arena_id
    end

    def test_handles_empty_arena_hash
      response = base_response
      response[:boxScoreSummary][:arena] = {}
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").arena_name
    end

    def test_parses_arena_id
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal 10, BoxScoreSummaryV3.find(game: "0022400001").arena_id
    end

    def test_parses_arena_name
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "Chase Center", BoxScoreSummaryV3.find(game: "0022400001").arena_name
    end

    def test_parses_arena_city
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "San Francisco", BoxScoreSummaryV3.find(game: "0022400001").arena_city
    end

    def test_parses_arena_state
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "CA", BoxScoreSummaryV3.find(game: "0022400001").arena_state
    end

    def test_parses_arena_country
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "US", BoxScoreSummaryV3.find(game: "0022400001").arena_country
    end

    def test_parses_arena_timezone
      stub_request(:get, /boxscoresummaryv3/).to_return(body: base_response.to_json)

      assert_equal "America/Los_Angeles", BoxScoreSummaryV3.find(game: "0022400001").arena_timezone
    end
  end
end
