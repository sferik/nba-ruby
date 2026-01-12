require_relative "../../test_helper"

module NBA
  class LiveBoxScoreTeamDataEdgeCasesTest < Minitest::Test
    cover LiveBoxScore

    def test_find_handles_missing_home_team_data
      response = {game: {homeTeam: nil, awayTeam: away_team_data}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stats = LiveBoxScore.find(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal "LAL", stats.first.team_tricode
    end

    def test_find_handles_missing_away_team_data
      response = {game: {homeTeam: home_team_data, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stats = LiveBoxScore.find(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal "GSW", stats.first.team_tricode
    end

    def test_find_handles_missing_players_array
      response = {game: {homeTeam: team_without_players, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stats = LiveBoxScore.find(game: "0022400001")

      assert_equal 0, stats.size
    end

    def test_find_handles_missing_players_key
      response = {game: {homeTeam: team_missing_players_key, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stats = LiveBoxScore.find(game: "0022400001")

      assert_equal 0, stats.size
    end

    def test_find_handles_missing_statistics
      response = {game: {homeTeam: team_with_missing_stats, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.points
    end

    def test_find_handles_missing_team_id
      response = {game: {homeTeam: team_without_id, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.team_id
    end

    def test_find_handles_missing_team_tricode
      response = {game: {homeTeam: team_without_tricode, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_nil stat.team_tricode
    end

    private

    def home_team_data
      {
        teamId: 1_610_612_744,
        teamTricode: "GSW",
        players: [basic_player_data]
      }
    end

    def away_team_data
      {
        teamId: 1_610_612_747,
        teamTricode: "LAL",
        players: [basic_player_data]
      }
    end

    def team_without_players
      {teamId: 1_610_612_744, teamTricode: "GSW", players: nil}
    end

    def team_missing_players_key
      {teamId: 1_610_612_744, teamTricode: "GSW"}
    end

    def team_with_missing_stats
      {
        teamId: 1_610_612_744,
        teamTricode: "GSW",
        players: [{personId: 201_939, name: "Stephen Curry", statistics: nil}]
      }
    end

    def team_without_id
      {
        teamTricode: "GSW",
        players: [{personId: 201_939, name: "Stephen Curry", statistics: {points: 32}}]
      }
    end

    def team_without_tricode
      {
        teamId: 1_610_612_744,
        players: [{personId: 201_939, name: "Stephen Curry", statistics: {points: 32}}]
      }
    end

    def basic_player_data
      {
        personId: 201_939,
        name: "Stephen Curry",
        statistics: {points: 30}
      }
    end
  end
end
