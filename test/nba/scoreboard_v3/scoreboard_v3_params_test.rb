require_relative "../../test_helper"

module NBA
  class ScoreboardV3ParamsTest < Minitest::Test
    cover ScoreboardV3

    def test_games_with_custom_date
      stub_request(:get, /scoreboardv3.*GameDate=2024-01-15/)
        .to_return(body: scoreboard_v3_response.to_json)

      ScoreboardV3.games(date: Date.new(2024, 1, 15))

      assert_requested :get, /scoreboardv3.*GameDate=2024-01-15/
    end

    def test_games_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /scoreboardv3.*LeagueID=00/)
        .to_return(body: scoreboard_v3_response.to_json)

      ScoreboardV3.games(league: league)

      assert_requested :get, /scoreboardv3.*LeagueID=00/
    end

    def test_games_with_league_string
      stub_request(:get, /scoreboardv3.*LeagueID=00/)
        .to_return(body: scoreboard_v3_response.to_json)

      ScoreboardV3.games(league: "00")

      assert_requested :get, /scoreboardv3.*LeagueID=00/
    end

    private

    def scoreboard_v3_response
      {scoreboard: {games: [game_data]}}
    end

    def game_data
      {gameId: "0022400001", gameTimeUTC: "2024-10-22T23:30:00Z", gameStatus: 3,
       homeTeam: {teamId: Team::LAL, score: 110}, awayTeam: {teamId: Team::BOS, score: 105},
       arenaName: "Crypto.com Arena"}
    end
  end
end
