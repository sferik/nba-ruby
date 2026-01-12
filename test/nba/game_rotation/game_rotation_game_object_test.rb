require_relative "../../test_helper"

module NBA
  class GameRotationGameObjectTest < Minitest::Test
    cover GameRotation

    def test_home_team_accepts_game_object
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      GameRotation.home_team(game: game)

      assert_requested :get, /gamerotation.*GameID=0022400001/
    end

    def test_away_team_accepts_game_object
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      GameRotation.away_team(game: game)

      assert_requested :get, /gamerotation.*GameID=0022400001/
    end

    def test_all_accepts_game_object
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)
      game = Game.new(id: "0022400001")

      GameRotation.all(game: game)

      assert_requested :get, /gamerotation.*GameID=0022400001/, times: 2
    end

    private

    def response
      {resultSets: [
        {name: "HomeTeam", headers: [], rowSet: []},
        {name: "AwayTeam", headers: [], rowSet: []}
      ]}
    end
  end
end
