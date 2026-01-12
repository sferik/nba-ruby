require_relative "../../test_helper"

module NBA
  class ScoreboardV3TeamsAndDefaultsTest < Minitest::Test
    cover ScoreboardV3

    def test_games_handles_missing_home_team_id
      response = {scoreboard: {games: [{gameId: "0022400001", homeTeam: {score: 110}, awayTeam: {teamId: Team::BOS, score: 105}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_nil game.home_team
      assert_equal 110, game.home_score
    end

    def test_games_handles_missing_away_team_id
      response = {scoreboard: {games: [{gameId: "0022400001", homeTeam: {teamId: Team::LAL, score: 110}, awayTeam: {score: 105}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_nil game.away_team
      assert_equal 105, game.away_score
    end

    def test_games_finds_valid_home_team
      response = {scoreboard: {games: [{gameId: "0022400001", gameStatus: 3,
                                        homeTeam: {teamId: Team::LAL, score: 110},
                                        awayTeam: {teamId: Team::BOS, score: 105}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_instance_of Team, game.home_team
      assert_equal Team::LAL, game.home_team.id
    end

    def test_games_finds_valid_away_team
      response = {scoreboard: {games: [{gameId: "0022400001", gameStatus: 3,
                                        homeTeam: {teamId: Team::LAL, score: 110},
                                        awayTeam: {teamId: Team::BOS, score: 105}}]}}
      stub_request(:get, /scoreboardv3/).to_return(body: response.to_json)

      game = ScoreboardV3.games.first

      assert_instance_of Team, game.away_team
      assert_equal Team::BOS, game.away_team.id
    end

    def test_games_default_date_is_today
      today = Date.today
      stub_request(:get, /scoreboardv3.*GameDate=#{today}/)
        .to_return(body: scoreboard_v3_response.to_json)

      ScoreboardV3.games

      assert_requested :get, /scoreboardv3.*GameDate=#{today}/
    end

    def test_games_default_league_is_nba
      stub_request(:get, /scoreboardv3.*LeagueID=00/)
        .to_return(body: scoreboard_v3_response.to_json)

      ScoreboardV3.games

      assert_requested :get, /scoreboardv3.*LeagueID=00/
    end

    private

    def scoreboard_v3_response
      {scoreboard: {games: [{gameId: "0022400001", gameTimeUTC: "2024-10-22T23:30:00Z",
                             gameStatus: 3, homeTeam: {teamId: Team::LAL, score: 110},
                             awayTeam: {teamId: Team::BOS, score: 105}, arenaName: "Crypto.com Arena"}]}}
    end
  end
end
