require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV3OtherStatsTest < Minitest::Test
    cover BoxScoreSummaryV3

    def test_parses_lead_changes
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 12, BoxScoreSummaryV3.find(game: "0022400001").lead_changes
    end

    def test_parses_times_tied
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 8, BoxScoreSummaryV3.find(game: "0022400001").times_tied
    end

    def test_parses_largest_lead
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 15, BoxScoreSummaryV3.find(game: "0022400001").largest_lead
    end

    def test_handles_missing_lead_changes
      response = full_response
      response[:boxScoreSummary].delete(:leadChanges)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").lead_changes
    end

    def test_handles_missing_times_tied
      response = full_response
      response[:boxScoreSummary].delete(:timesTied)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").times_tied
    end

    def test_handles_missing_largest_lead
      response = full_response
      response[:boxScoreSummary].delete(:largestLead)
      stub_request(:get, /boxscoresummaryv3/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001").largest_lead
    end

    private

    def full_response
      {boxScoreSummary: {gameId: "0022400001", gameStatus: 3, homeTeam: {}, awayTeam: {},
                         leadChanges: 12, timesTied: 8, largestLead: 15, officials: []}}
    end
  end
end
