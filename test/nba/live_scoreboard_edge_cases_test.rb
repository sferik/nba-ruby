require_relative "../test_helper"

module NBA
  class LiveScoreboardEdgeCasesTest < Minitest::Test
    cover LiveScoreboard

    def test_today_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, LiveScoreboard.today(client: mock_client).size
      mock_client.verify
    end

    def test_today_returns_empty_collection_when_no_scoreboard
      stub_request(:get, /cdn.nba.com/).to_return(body: {}.to_json)

      assert_equal 0, LiveScoreboard.today.size
    end

    def test_today_returns_empty_collection_when_no_games
      response = {scoreboard: {games: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      assert_equal 0, LiveScoreboard.today.size
    end

    def test_today_handles_missing_home_team_data
      stub_missing_home_team_response

      game = LiveScoreboard.today.first

      assert_nil game.home_team_id
    end

    def test_today_handles_missing_away_team_data
      stub_missing_away_team_response

      game = LiveScoreboard.today.first

      assert_nil game.away_team_id
    end

    private

    def stub_missing_home_team_response
      response = {
        scoreboard: {
          games: [{
            gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3,
            homeTeam: nil, awayTeam: {teamId: 1_610_612_747, teamName: "Lakers"}
          }]
        }
      }
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)
    end

    def stub_missing_away_team_response
      response = {
        scoreboard: {
          games: [{
            gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3,
            homeTeam: {teamId: 1_610_612_744, teamName: "Warriors"}, awayTeam: nil
          }]
        }
      }
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)
    end
  end
end
