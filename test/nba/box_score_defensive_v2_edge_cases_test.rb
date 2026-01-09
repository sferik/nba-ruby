require_relative "../test_helper"

module NBA
  class BoxScoreDefensiveV2EdgeCasesTest < Minitest::Test
    cover BoxScoreDefensiveV2

    def test_player_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreDefensiveV2.player_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreDefensiveV2.team_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoredefensivev2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreDefensiveV2.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoredefensivev2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreDefensiveV2.team_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreDefensiveV2.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreDefensiveV2.team_stats(game: "0022400001").size
    end

    def test_player_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      stats = BoxScoreDefensiveV2.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_finds_correct_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      stats = BoxScoreDefensiveV2.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal "Stephen", stats.first.first_name
    end

    def test_team_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      stats = BoxScoreDefensiveV2.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "PlayerStats", headers: player_headers}]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreDefensiveV2.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "TeamStats", headers: team_headers}]}
      stub_request(:get, /boxscoredefensivev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreDefensiveV2.team_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoredefensivev2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreDefensiveV2.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoredefensivev2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreDefensiveV2.team_stats(game: "0022400001").size
    end

    private

    def player_headers
      %w[gameId teamId teamCity teamName teamTricode teamSlug personId firstName familyName
        nameI playerSlug position comment jerseyNum matchupMinutes partialPossessions
        switchesOn playerPoints defensiveRebounds matchupAssists matchupTurnovers steals
        blocks matchupFieldGoalsMade matchupFieldGoalsAttempted matchupFieldGoalPercentage
        matchupThreePointersMade matchupThreePointersAttempted matchupThreePointerPercentage]
    end

    def player_row
      ["0022400001", Team::GSW, "Golden State", "Warriors", "GSW", "warriors", 201_939,
        "Stephen", "Curry", "S. Curry", "stephen-curry", "G", "", "30", 24.5, 15.2, 8,
        12, 5, 3, 2, 2, 1, 5, 12, 0.417, 2, 5, 0.4]
    end

    def team_headers
      %w[gameId teamId teamCity teamName teamTricode teamSlug minutes]
    end

    def team_row
      ["0022400001", Team::GSW, "Golden State", "Warriors", "GSW", "warriors", "240:00"]
    end
  end
end
