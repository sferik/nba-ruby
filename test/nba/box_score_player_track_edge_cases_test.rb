require_relative "../test_helper"

module NBA
  class BoxScorePlayerTrackEdgeCasesTest < Minitest::Test
    cover BoxScorePlayerTrack

    def test_player_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScorePlayerTrack.player_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScorePlayerTrack.team_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScorePlayerTrack.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScorePlayerTrack.team_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScorePlayerTrack.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScorePlayerTrack.team_stats(game: "0022400001").size
    end

    def test_player_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      stats = BoxScorePlayerTrack.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_finds_correct_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      stats = BoxScorePlayerTrack.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end

    def test_team_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      stats = BoxScorePlayerTrack.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "PlayerStats", headers: player_headers}]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScorePlayerTrack.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "TeamStats", headers: team_headers}]}
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: response.to_json)

      assert_equal 0, BoxScorePlayerTrack.team_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScorePlayerTrack.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoreplayertrackv3/).to_return(body: {}.to_json)

      assert_equal 0, BoxScorePlayerTrack.team_stats(game: "0022400001").size
    end

    private

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MIN
        SPD DIST ORBC DRBC RBC TCHS SAST FTAST PASS AST CFGM CFGA CFG_PCT UFGM UFGA UFG_PCT
        DFGM DFGA DFG_PCT]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "", "32:45",
        4.52, 2.67, 5, 12, 17, 65, 2, 1, 42, 8, 3, 8, 0.375, 5, 6, 0.833, 4, 10, 0.400]
    end

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN SPD DIST ORBC DRBC RBC TCHS
        SAST FTAST PASS AST CFGM CFGA CFG_PCT UFGM UFGA UFG_PCT DFGM DFGA DFG_PCT]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 4.38, 24.5, 35, 45, 80, 350,
        12, 5, 285, 28, 18, 45, 0.400, 24, 35, 0.686, 25, 55, 0.455]
    end
  end
end
