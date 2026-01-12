require_relative "../../test_helper"

module NBA
  class GamesFindTest < Minitest::Test
    cover Games

    def test_find_returns_game_object
      stub_box_score_summary_request("0022400001")

      game = Games.find("0022400001")

      assert_instance_of Game, game
    end

    def test_find_uses_correct_game_id_in_path
      stub_box_score_summary_request("0022400001")

      Games.find("0022400001")

      assert_requested :get, /boxscoresummaryv2.*GameID=0022400001/
    end

    def test_find_returns_nil_when_game_id_is_nil
      assert_nil Games.find(nil)
    end

    def test_find_parses_game_id
      stub_box_score_summary_request("0022400001")

      game = Games.find("0022400001")

      assert_equal "0022400001", game.id
    end

    def test_find_parses_game_date
      stub_box_score_summary_request("0022400001")

      game = Games.find("0022400001")

      assert_equal "2024-10-22T00:00:00", game.date
    end

    def test_find_parses_arena
      stub_box_score_summary_request("0022400001")

      game = Games.find("0022400001")

      assert_equal "Chase Center", game.arena
    end

    private

    def stub_box_score_summary_request(game_id)
      stub_request(:get, /boxscoresummaryv2.*GameID=#{game_id}/).to_return(body: box_score_summary_response.to_json)
    end

    def box_score_summary_response
      {resultSets: [{name: "GameSummary", headers: game_summary_headers, rowSet: [game_summary_row]}]}
    end

    def game_summary_headers
      %w[GAME_DATE_EST GAME_ID GAME_STATUS_ID HOME_TEAM_ID VISITOR_TEAM_ID ARENA]
    end

    def game_summary_row
      ["2024-10-22T00:00:00", "0022400001", 3, Team::GSW, Team::LAL, "Chase Center"]
    end
  end
end
