require_relative "../../test_helper"

module NBA
  class LiveScoreboardTest < Minitest::Test
    cover LiveScoreboard

    def test_today_returns_collection
      stub_live_scoreboard_request

      assert_instance_of Collection, LiveScoreboard.today
    end

    def test_today_parses_basic_game_info
      stub_live_scoreboard_request

      game = LiveScoreboard.today.first

      assert_equal "0022400001", game.game_id
      assert_equal "20241022/LALGSW", game.game_code
      assert_equal 3, game.game_status
      assert_equal "Final", game.game_status_text
    end

    def test_today_parses_game_timing_info
      stub_live_scoreboard_request

      game = LiveScoreboard.today.first

      assert_equal 4, game.period
      assert_equal "PT00M00.00S", game.game_clock
      assert_equal "2024-10-22T23:30:00Z", game.game_time_utc
      assert_equal "2024-10-22T19:30:00", game.game_et
    end

    def test_today_parses_home_team_data
      stub_live_scoreboard_request

      game = LiveScoreboard.today.first

      assert_equal 1_610_612_744, game.home_team_id
      assert_equal "Warriors", game.home_team_name
      assert_equal "Golden State", game.home_team_city
      assert_equal "GSW", game.home_team_tricode
      assert_equal 112, game.home_team_score
    end

    def test_today_parses_away_team_data
      stub_live_scoreboard_request

      game = LiveScoreboard.today.first

      assert_equal 1_610_612_747, game.away_team_id
      assert_equal "Lakers", game.away_team_name
      assert_equal "Los Angeles", game.away_team_city
      assert_equal "LAL", game.away_team_tricode
      assert_equal 108, game.away_team_score
    end

    private

    def stub_live_scoreboard_request
      stub_request(:get, %r{scoreboard/todaysScoreboard_00.json})
        .to_return(body: live_scoreboard_response.to_json)
    end

    def live_scoreboard_response
      {scoreboard: {games: [game_data]}}
    end

    def game_data
      {
        gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3,
        gameStatusText: "Final", period: 4, gameClock: "PT00M00.00S",
        gameTimeUTC: "2024-10-22T23:30:00Z", gameEt: "2024-10-22T19:30:00",
        homeTeam: home_team_data, awayTeam: away_team_data
      }
    end

    def home_team_data
      {
        teamId: 1_610_612_744, teamName: "Warriors", teamCity: "Golden State",
        teamTricode: "GSW", score: 112
      }
    end

    def away_team_data
      {
        teamId: 1_610_612_747, teamName: "Lakers", teamCity: "Los Angeles",
        teamTricode: "LAL", score: 108
      }
    end
  end
end
