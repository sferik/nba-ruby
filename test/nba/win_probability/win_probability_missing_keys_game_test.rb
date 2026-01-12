require_relative "../../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityMissingKeysGameTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_handles_missing_event_num_key
      stub_request_without("EVENT_NUM")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.event_num
    end

    def test_handles_missing_period_key
      stub_request_without("PERIOD")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.period
    end

    def test_handles_missing_seconds_remaining_key
      stub_request_without("SECONDS_REMAINING")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.seconds_remaining
    end

    def test_handles_missing_location_key
      stub_request_without("LOCATION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.location
    end

    def test_handles_missing_home_pct_key
      stub_request_without("HOME_PCT")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_pct
    end

    def test_handles_missing_visitor_pct_key
      stub_request_without("VISITOR_PCT")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_pct
    end

    def test_handles_missing_home_pts_key
      stub_request_without("HOME_PTS")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_pts
    end

    def test_handles_missing_visitor_pts_key
      stub_request_without("VISITOR_PTS")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_pts
    end

    def test_handles_missing_home_score_by_key
      stub_request_without("HOME_SCORE_BY")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_score_by
    end

    def test_handles_missing_visitor_score_by_key
      stub_request_without("VISITOR_SCORE_BY")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_score_by
    end

    private

    def stub_request_without(excluded_key)
      headers = win_prob_headers.reject { |h| h.eql?(excluded_key) }
      row = build_row_without(excluded_key)
      response = build_win_prob_response(headers, row)

      stub_request(:get, /winprobabilitypbp.*GameID=0022400001/)
        .to_return(body: response.to_json)
    end
  end
end
