require_relative "box_score_summary_v3_game_attrs_helper"

module NBA
  class BoxScoreSummaryV3GameAttrsTest < Minitest::Test
    include BoxScoreSummaryV3GameAttrsHelper

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
  end
end
