require_relative "../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_find_returns_collection
      stub_win_probability_request

      assert_instance_of Collection, WinProbability.find(game: "0022400001")
    end

    def test_find_parses_event_attributes
      stub_win_probability_request
      point = WinProbability.find(game: "0022400001").first

      assert_equal "0022400001", point.game_id
      assert_equal 42, point.event_num
      assert_equal 4, point.period
      assert_equal 120, point.seconds_remaining
      assert_equal "GSW", point.location
    end

    def test_find_parses_win_probability
      stub_win_probability_request
      point = WinProbability.find(game: "0022400001").first

      assert_in_delta 0.75, point.home_pct
      assert_in_delta 0.25, point.visitor_pct
    end

    def test_find_parses_score_info
      stub_win_probability_request
      point = WinProbability.find(game: "0022400001").first

      assert_equal 100, point.home_pts
      assert_equal 95, point.visitor_pts
      assert_equal 3, point.home_score_by
      assert_equal 0, point.visitor_score_by
    end

    def test_find_parses_description_attributes
      stub_win_probability_request
      point = WinProbability.find(game: "0022400001").first

      assert_equal "Curry 3PT Shot", point.home_description
      assert_nil point.neutral_description
      assert_nil point.visitor_description
    end

    def test_find_accepts_game_object
      response = build_win_prob_response(win_prob_headers, win_prob_row)
      stub_request(:get, /winprobabilitypbp.*GameID=0022400001/)
        .to_return(body: response.to_json)

      game = Game.new(id: "0022400001")
      WinProbability.find(game: game)

      assert_requested :get, /winprobabilitypbp.*GameID=0022400001/
    end

    def test_find_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = WinProbability.find(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_constant_defined
      assert_equal "WinProbPBP", WinProbability::WIN_PROB_PBP
    end

    def test_finds_correct_result_set_among_multiple
      response = {
        resultSets: [
          {name: "OtherSet", headers: ["FIELD"], rowSet: [[1]]},
          {name: "WinProbPBP", headers: win_prob_headers, rowSet: [win_prob_row]},
          {name: "AnotherSet", headers: ["FIELD"], rowSet: [[2]]}
        ]
      }
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal 42, point.event_num
    end

    private

    def stub_win_probability_request
      response = build_win_prob_response(win_prob_headers, win_prob_row)
      stub_request(:get, /winprobabilitypbp.*GameID=0022400001/)
        .to_return(body: response.to_json)
    end
  end
end
