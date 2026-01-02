require_relative "../test_helper"

module NBA
  class GamesFindStatusTest < Minitest::Test
    cover Games

    def test_find_parses_scheduled_status
      stub_request(:get, /boxscoresummaryv2/).to_return(body: status_response(1).to_json)

      game = Games.find("0022400001")

      assert_equal "Scheduled", game.status
    end

    def test_find_parses_in_progress_status
      stub_request(:get, /boxscoresummaryv2/).to_return(body: status_response(2).to_json)

      game = Games.find("0022400001")

      assert_equal "In Progress", game.status
    end

    def test_find_parses_final_status
      stub_request(:get, /boxscoresummaryv2/).to_return(body: status_response(3).to_json)

      game = Games.find("0022400001")

      assert_equal "Final", game.status
    end

    def test_find_parses_unknown_status
      stub_request(:get, /boxscoresummaryv2/).to_return(body: status_response(99).to_json)

      game = Games.find("0022400001")

      assert_equal "Unknown", game.status
    end

    private

    def status_response(status_id)
      {resultSets: [{name: "GameSummary", headers: %w[GAME_ID GAME_STATUS_ID], rowSet: [["0022400001", status_id]]}]}
    end
  end
end
