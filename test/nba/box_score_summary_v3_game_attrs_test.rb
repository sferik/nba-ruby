require_relative "../test_helper"

module NBA
  class BoxScoreSummaryV3GameAttrsTest < Minitest::Test
    cover BoxScoreSummaryV3

    def test_parses_game_id
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "0022400001", BoxScoreSummaryV3.find(game: "0022400001").game_id
    end

    def test_parses_game_code
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "20241022/LALGSW", BoxScoreSummaryV3.find(game: "0022400001").game_code
    end

    def test_parses_game_status
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 3, BoxScoreSummaryV3.find(game: "0022400001").game_status
    end

    def test_parses_game_status_text
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "Final", BoxScoreSummaryV3.find(game: "0022400001").game_status_text
    end

    def test_parses_period
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 4, BoxScoreSummaryV3.find(game: "0022400001").period
    end

    def test_parses_game_clock
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "PT00M00.00S", BoxScoreSummaryV3.find(game: "0022400001").game_clock
    end

    def test_parses_game_time_utc
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "2024-10-23T02:00:00Z", BoxScoreSummaryV3.find(game: "0022400001").game_time_utc
    end

    def test_parses_game_et
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "2024-10-22T22:00:00", BoxScoreSummaryV3.find(game: "0022400001").game_et
    end

    def test_parses_duration
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 138, BoxScoreSummaryV3.find(game: "0022400001").duration
    end

    def test_parses_attendance
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal 18_064, BoxScoreSummaryV3.find(game: "0022400001").attendance
    end

    def test_parses_sellout
      stub_request(:get, /boxscoresummaryv3/).to_return(body: full_response.to_json)

      assert_equal "1", BoxScoreSummaryV3.find(game: "0022400001").sellout
    end

    private

    def full_response
      {boxScoreSummary: {gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3, gameStatusText: "Final",
                         period: 4, gameClock: "PT00M00.00S", gameTimeUTC: "2024-10-23T02:00:00Z",
                         gameEt: "2024-10-22T22:00:00", duration: 138, attendance: 18_064, sellout: "1",
                         homeTeam: {}, awayTeam: {}, officials: []}}
    end
  end

  class BoxScoreSummaryV3GameAttrsMissingTest < Minitest::Test
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

    private

    def full_response
      {boxScoreSummary: {gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3, gameStatusText: "Final",
                         period: 4, gameClock: "PT00M00.00S", gameTimeUTC: "2024-10-23T02:00:00Z",
                         gameEt: "2024-10-22T22:00:00", duration: 138, attendance: 18_064, sellout: "1",
                         homeTeam: {}, awayTeam: {}, officials: []}}
    end
  end

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
