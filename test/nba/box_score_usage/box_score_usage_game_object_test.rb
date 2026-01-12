require_relative "../../test_helper"

module NBA
  class BoxScoreUsageGameObjectTest < Minitest::Test
    cover BoxScoreUsage

    def test_player_stats_accepts_game_object
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      BoxScoreUsage.player_stats(game: game)

      assert_requested :get, /boxscoreusagev2.*GameID=0022400001/
    end

    def test_team_stats_accepts_game_object
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      BoxScoreUsage.team_stats(game: game)

      assert_requested :get, /boxscoreusagev2.*GameID=0022400001/
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
