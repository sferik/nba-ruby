require_relative "../test_helper"

module NBA
  class BoxScorePlayerStatGameHydrationTest < Minitest::Test
    cover BoxScorePlayerStat

    def test_game_returns_hydrated_game_object
      stub_box_score_summary_request("0022400001")
      stat = BoxScorePlayerStat.new(game_id: "0022400001")

      game = stat.game

      assert_instance_of Game, game
      assert_equal "0022400001", game.id
    end

    def test_game_calls_api_with_correct_game_id
      stub_box_score_summary_request("0022400001")
      stat = BoxScorePlayerStat.new(game_id: "0022400001")

      stat.game

      assert_requested :get, /boxscoresummaryv2.*GameID=0022400001/
    end

    def test_game_returns_nil_when_game_id_is_nil
      stat = BoxScorePlayerStat.new(game_id: nil)

      assert_nil stat.game
    end

    private

    def stub_box_score_summary_request(game_id)
      response = {resultSets: [{name: "GameSummary", headers: %w[GAME_ID HOME_TEAM_ID VISITOR_TEAM_ID],
                                rowSet: [[game_id, Team::GSW, Team::LAL]]}]}
      stub_request(:get, /boxscoresummaryv2.*GameID=#{game_id}/).to_return(body: response.to_json)
    end
  end
end
