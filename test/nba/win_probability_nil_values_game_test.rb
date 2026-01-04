require_relative "../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityNilValuesGameTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_handles_nil_event_num_value
      stub_request_with_nil("EVENT_NUM")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.event_num
    end

    def test_handles_nil_period_value
      stub_request_with_nil("PERIOD")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.period
    end

    def test_handles_nil_seconds_remaining_value
      stub_request_with_nil("SECONDS_REMAINING")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.seconds_remaining
    end

    def test_handles_nil_location_value
      stub_request_with_nil("LOCATION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.location
    end

    def test_handles_nil_home_pct_value
      stub_request_with_nil("HOME_PCT")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_pct
    end

    def test_handles_nil_visitor_pct_value
      stub_request_with_nil("VISITOR_PCT")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_pct
    end

    def test_handles_nil_home_pts_value
      stub_request_with_nil("HOME_PTS")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_pts
    end

    def test_handles_nil_visitor_pts_value
      stub_request_with_nil("VISITOR_PTS")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_pts
    end

    def test_handles_nil_home_score_by_value
      stub_request_with_nil("HOME_SCORE_BY")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_score_by
    end

    def test_handles_nil_visitor_score_by_value
      stub_request_with_nil("VISITOR_SCORE_BY")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_score_by
    end

    private

    def stub_request_with_nil(key_with_nil_value)
      row = build_row_with_nil(key_with_nil_value)
      response = build_win_prob_response(win_prob_headers, row)

      stub_request(:get, /winprobabilitypbp.*GameID=0022400001/)
        .to_return(body: response.to_json)
    end
  end
end
