require_relative "../test_helper"

module NBA
  class BoxScoreMiscTeamEdgeCasesTest < Minitest::Test
    cover BoxScoreMisc

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreMisc.team_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoremiscv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreMisc.team_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoremiscv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreMisc.team_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.team_stats(game: "001").size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.team_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.team_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreMisc.team_stats(game: "001").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stats = BoxScoreMisc.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stats = BoxScoreMisc.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_handles_missing_game_id
      headers = team_headers.reject { |h| h == "GAME_ID" }
      row = team_row[1..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoremiscv2/).to_return(body: response.to_json)
      stat = BoxScoreMisc.team_stats(game: "001").first

      assert_nil stat.game_id
      assert_equal Team::GSW, stat.team_id
    end

    private

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PTS_OFF_TOV PTS_2ND_CHANCE
        PTS_FB PTS_PAINT OPP_PTS_OFF_TOV OPP_PTS_2ND_CHANCE OPP_PTS_FB OPP_PTS_PAINT BLK BLKA PF PFD]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        18, 12, 22, 48, 14, 10, 16, 44, 6, 4, 22, 18]
    end
  end
end
