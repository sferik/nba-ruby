require_relative "../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityAttributeKeysGameTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_uses_correct_event_num_key
      response = build_response_with_values("EVENT_NUM" => 123, "PERIOD" => 456)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 123, point.event_num
    end

    def test_uses_correct_period_key
      response = build_response_with_values("EVENT_NUM" => 123, "PERIOD" => 456)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 456, point.period
    end

    def test_uses_correct_seconds_remaining_key
      response = build_response_with_values("SECONDS_REMAINING" => 789)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 789, point.seconds_remaining
    end

    def test_uses_correct_location_key
      response = build_response_with_values("LOCATION" => "LAL")
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal "LAL", point.location
    end

    def test_uses_correct_home_pct_key
      response = build_response_with_values("HOME_PCT" => 0.88, "VISITOR_PCT" => 0.12)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_in_delta 0.88, point.home_pct
    end

    def test_uses_correct_visitor_pct_key
      response = build_response_with_values("HOME_PCT" => 0.88, "VISITOR_PCT" => 0.12)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_in_delta 0.12, point.visitor_pct
    end

    def test_uses_correct_home_pts_key
      response = build_response_with_values("HOME_PTS" => 111, "VISITOR_PTS" => 222)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 111, point.home_pts
    end

    def test_uses_correct_visitor_pts_key
      response = build_response_with_values("HOME_PTS" => 111, "VISITOR_PTS" => 222)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 222, point.visitor_pts
    end

    def test_uses_correct_home_score_by_key
      response = build_response_with_values("HOME_SCORE_BY" => 10, "VISITOR_SCORE_BY" => 20)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 10, point.home_score_by
    end

    def test_uses_correct_visitor_score_by_key
      response = build_response_with_values("HOME_SCORE_BY" => 10, "VISITOR_SCORE_BY" => 20)
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 20, point.visitor_score_by
    end
  end
end
