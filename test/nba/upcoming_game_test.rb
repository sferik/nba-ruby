require_relative "../test_helper"

module NBA
  class UpcomingGameTest < Minitest::Test
    cover UpcomingGame

    def test_equality_based_on_game_id
      game1 = UpcomingGame.new(game_id: "0022400001", home_team_name: "Warriors")
      game2 = UpcomingGame.new(game_id: "0022400001", home_team_name: "Different")

      assert_equal game1, game2
    end

    def test_inequality_when_game_ids_differ
      game1 = UpcomingGame.new(game_id: "0022400001")
      game2 = UpcomingGame.new(game_id: "0022400002")

      refute_equal game1, game2
    end

    def test_home_team_fetches_team_by_id
      stub_request(:get, /teamdetails\?TeamID=1610612744/).to_return(body: team_response.to_json)

      game = UpcomingGame.new(home_team_id: 1_610_612_744)
      team = game.home_team

      assert_equal 1_610_612_744, team.id
    end

    def test_visitor_team_fetches_team_by_id
      stub_request(:get, /teamdetails\?TeamID=1610612747/).to_return(body: team_response(1_610_612_747).to_json)

      game = UpcomingGame.new(visitor_team_id: 1_610_612_747)
      team = game.visitor_team

      assert_equal 1_610_612_747, team.id
    end

    private

    def team_response(team_id = 1_610_612_744)
      {
        resultSets: [{
          name: "TeamBackground",
          headers: %w[TEAM_ID ABBREVIATION NICKNAME CITY ARENA OWNER GENERALMANAGER HEADCOACH],
          rowSet: [[team_id, "GSW", "Warriors", "Golden State", "Chase Center", "Joe Lacob", "Mike Dunleavy Jr.", "Steve Kerr"]]
        }]
      }
    end
  end
end
