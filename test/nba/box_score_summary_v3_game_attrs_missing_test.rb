require_relative "box_score_summary_v3_game_attrs_helper"

module NBA
  class BoxScoreSummaryV3GameAttrsMissingTest < Minitest::Test
    include BoxScoreSummaryV3GameAttrsHelper

    cover BoxScoreSummaryV3

    def test_handles_missing_game_code
      response = full_response
      response[:boxScoreSummary].delete(:gameCode)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").game_code
    end

    def test_handles_missing_duration
      response = full_response
      response[:boxScoreSummary].delete(:duration)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").duration
    end

    def test_handles_missing_game_status
      response = full_response
      response[:boxScoreSummary].delete(:gameStatus)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").game_status
    end

    def test_handles_missing_game_status_text
      response = full_response
      response[:boxScoreSummary].delete(:gameStatusText)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").game_status_text
    end

    def test_handles_missing_period
      response = full_response
      response[:boxScoreSummary].delete(:period)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").period
    end

    def test_handles_missing_game_clock
      response = full_response
      response[:boxScoreSummary].delete(:gameClock)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").game_clock
    end

    def test_handles_missing_game_time_utc
      response = full_response
      response[:boxScoreSummary].delete(:gameTimeUTC)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").game_time_utc
    end

    def test_handles_missing_game_et
      response = full_response
      response[:boxScoreSummary].delete(:gameEt)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").game_et
    end

    def test_handles_missing_attendance
      response = full_response
      response[:boxScoreSummary].delete(:attendance)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").attendance
    end

    def test_handles_missing_sellout
      response = full_response
      response[:boxScoreSummary].delete(:sellout)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").sellout
    end
  end
end
