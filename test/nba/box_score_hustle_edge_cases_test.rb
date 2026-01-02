require_relative "../test_helper"

module NBA
  class BoxScoreHustleEdgeCasesTest < Minitest::Test
    cover BoxScoreHustle

    def test_player_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreHustle.player_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = BoxScoreHustle.team_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscorehustlev2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreHustle.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscorehustlev2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreHustle.team_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreHustle.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreHustle.team_stats(game: "0022400001").size
    end

    def test_player_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      stats = BoxScoreHustle.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_finds_correct_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      stats = BoxScoreHustle.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end

    def test_team_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      stats = BoxScoreHustle.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "PlayerStats", headers: player_headers}]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreHustle.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "TeamStats", headers: team_headers}]}
      stub_request(:get, /boxscorehustlev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreHustle.team_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscorehustlev2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreHustle.player_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscorehustlev2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreHustle.team_stats(game: "0022400001").size
    end

    private

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MIN PTS
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
        SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "", "32:45", 28,
        8, 5, 3, 4, 1, 3, 6, 2, 1, 1, 3, 1, 2]
    end

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PTS CONTESTED_SHOTS CONTESTED_SHOTS_2PT
        CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 118,
        45, 30, 15, 12, 2, 18, 36, 8, 3, 5, 25, 8, 17]
    end
  end
end
