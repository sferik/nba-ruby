require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreAdvancedV3EdgeCasesTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreAdvancedV3

    def test_player_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreAdvancedV3.player_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreAdvancedV3.team_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreAdvancedV3.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_no_box_score
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreAdvancedV3.team_stats(game: "0022400001").size
    end

    def test_handles_empty_players_array
      response = {boxScoreAdvanced: {homeTeam: {players: []}, awayTeam: {players: []}}}
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvancedV3.player_stats(game: "0022400001").size
    end

    def test_handles_nil_away_team
      response = {boxScoreAdvanced: {homeTeam: team_with_stats, awayTeam: nil}}
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreAdvancedV3.team_stats(game: "0022400001").size
    end

    def test_handles_nil_players_in_team
      response = {boxScoreAdvanced: {homeTeam: {players: nil}, awayTeam: {players: nil}}}
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvancedV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_home_team
      response = {boxScoreAdvanced: {awayTeam: {players: [player_advanced_data]}}}
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreAdvancedV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_away_team
      response = {boxScoreAdvanced: {homeTeam: {players: [player_advanced_data]}}}
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreAdvancedV3.player_stats(game: "0022400001").size
    end

    def test_handles_missing_home_team_for_teams
      response = {boxScoreAdvanced: {awayTeam: team_with_stats(Team::LAL, "Lakers")}}
      stub_request(:get, /boxscoreadvancedv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreAdvancedV3.team_stats(game: "0022400001").size
    end

    private

    def team_with_stats(team_id = Team::GSW, name = "Warriors")
      {teamId: team_id, teamName: name, statistics: team_advanced_stats}
    end
  end
end
