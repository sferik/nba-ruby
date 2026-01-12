require_relative "../../test_helper"

module NBA
  class BoxScoreFourFactorsTeamEdgeCasesTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreFourFactors.team_stats(game: "001").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)
      stats = BoxScoreFourFactors.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)
      stats = BoxScoreFourFactors.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    private

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN EFG_PCT FTA_RATE
        TM_TOV_PCT OREB_PCT OPP_EFG_PCT OPP_FTA_RATE OPP_TOV_PCT OPP_OREB_PCT]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        0.56, 0.30, 0.14, 0.22, 0.48, 0.28, 0.16, 0.20]
    end
  end
end
