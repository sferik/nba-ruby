require_relative "../test_helper"

module NBA
  class PlayByPlayGameObjectTest < Minitest::Test
    cover PlayByPlay

    def test_find_accepts_game_object
      stub_request(:get, /playbyplayv2/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      PlayByPlay.find(game: game)

      assert_requested :get, /playbyplayv2.*GameID=0022400001/
    end

    private

    def response
      {resultSets: [
        {name: "PlayByPlay", headers: [], rowSet: []}
      ]}
    end
  end
end
