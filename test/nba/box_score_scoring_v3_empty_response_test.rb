require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreScoringV3EmptyResponseTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreScoringV3

    def test_team_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreScoringV3.team_stats(
        game: "0022400001",
        client: mock_client
      )

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: {}.to_json)

      result = BoxScoreScoringV3.team_stats(game: "0022400001")

      assert_equal 0, result.size
    end

    def test_player_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: {}.to_json)

      result = BoxScoreScoringV3.player_stats(game: "0022400001")

      assert_equal 0, result.size
    end

    def test_player_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreScoringV3.player_stats(
        game: "0022400001",
        client: mock_client
      )

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_handles_empty_players_array
      response = {
        boxScoreScoring: {
          homeTeam: {players: []},
          awayTeam: {players: []}
        }
      }
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: response.to_json)

      result = BoxScoreScoringV3.player_stats(game: "0022400001")

      assert_equal 0, result.size
    end

    def test_handles_nil_away_team
      team_data = {
        teamId: Team::GSW,
        teamName: "Warriors",
        statistics: scoring_team_stats
      }
      stub_team_response(team_data, nil)

      stats = BoxScoreScoringV3.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_handles_nil_players_in_team
      response = {
        boxScoreScoring: {
          homeTeam: {players: nil},
          awayTeam: {players: nil}
        }
      }
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: response.to_json)

      stats = BoxScoreScoringV3.player_stats(game: "0022400001")

      assert_equal 0, stats.size
    end

    def test_handles_missing_home_team
      response = {
        boxScoreScoring: {
          awayTeam: {players: [scoring_player_data]}
        }
      }
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: response.to_json)

      stats = BoxScoreScoringV3.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_handles_missing_away_team
      response = {
        boxScoreScoring: {
          homeTeam: {players: [scoring_player_data]}
        }
      }
      stub_request(:get, /boxscorescoringv3/)
        .to_return(body: response.to_json)

      stats = BoxScoreScoringV3.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_handles_missing_home_team_for_teams
      team_data = {
        teamId: Team::LAL,
        teamName: "Lakers",
        statistics: scoring_team_stats
      }
      stub_team_response(nil, team_data)

      stats = BoxScoreScoringV3.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end
  end
end
