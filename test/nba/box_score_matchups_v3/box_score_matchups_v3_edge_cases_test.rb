require_relative "../../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3EdgeCasesTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_find_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreMatchupsV3.find(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_find_returns_empty_when_no_box_score
      stub_request(:get, /boxscorematchupsv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreMatchupsV3.find(game: "0022400001").size
    end

    def test_handles_empty_players_array
      response = {boxScoreMatchups: {homeTeam: {players: []}, awayTeam: {players: []}}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMatchupsV3.find(game: "0022400001").size
    end

    def test_handles_nil_away_team
      response = {boxScoreMatchups: {homeTeam: home_team_matchups, awayTeam: nil}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreMatchupsV3.find(game: "0022400001").size
    end

    def test_handles_nil_players_in_team
      response = {boxScoreMatchups: {homeTeam: {players: nil}, awayTeam: {players: nil}}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMatchupsV3.find(game: "0022400001").size
    end

    def test_handles_missing_home_team
      response = {boxScoreMatchups: {awayTeam: {players: [matchup_data]}}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreMatchupsV3.find(game: "0022400001").size
    end

    def test_handles_missing_away_team
      response = {boxScoreMatchups: {homeTeam: {players: [matchup_data]}}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)

      assert_equal 1, BoxScoreMatchupsV3.find(game: "0022400001").size
    end

    def test_handles_game_object_for_game_param
      stub_matchups_request
      game = Game.new(id: "0022400001")

      result = BoxScoreMatchupsV3.find(game: game)

      assert_equal 1, result.size
    end

    private

    def stub_matchups_request
      stub_request(:get, /boxscorematchupsv3.*GameID=0022400001/)
        .to_return(body: matchups_v3_response.to_json)
    end
  end
end
