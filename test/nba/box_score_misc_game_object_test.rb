require_relative "../test_helper"

module NBA
  class BoxScoreMiscGameObjectTest < Minitest::Test
    cover BoxScoreMisc

    def test_player_stats_accepts_game_object
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      BoxScoreMisc.player_stats(game: game)

      assert_requested :get, /boxscoremiscv2.*GameID=0022400001/
    end

    def test_team_stats_accepts_game_object
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      BoxScoreMisc.team_stats(game: game)

      assert_requested :get, /boxscoremiscv2.*GameID=0022400001/
    end

    private

    def response
      {resultSets: [
        {name: "PlayerStats", headers: [], rowSet: []},
        {name: "TeamStats", headers: [], rowSet: []}
      ]}
    end
  end
end
