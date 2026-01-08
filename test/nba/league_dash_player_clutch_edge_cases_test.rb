require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchEdgeCasesTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashPlayerClutch.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: {}.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueDashPlayerClutch", rowSet: [[1]]}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "LeagueDashPlayerClutch", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "LeagueDashPlayerClutch", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "LeagueDashPlayerClutch", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerClutch.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "LeagueDashPlayerClutch", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      stats = LeagueDashPlayerClutch.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "LeagueDashPlayerClutch", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      stats = LeagueDashPlayerClutch.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end

    private

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 74, 46, 28, 0.622, 5.2,
        1.2, 2.8, 0.429, 0.5, 1.4, 0.357, 0.8, 0.9, 0.889,
        0.1, 0.5, 0.6, 1.0, 0.4, 0.2, 0.1, 0.3, 3.7, 1.2]
    end
  end
end
