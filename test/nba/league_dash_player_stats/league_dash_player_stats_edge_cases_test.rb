require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerStatsEdgeCasesTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashPlayerStats.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguedashplayerstats/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguedashplayerstats/).to_return(body: {}.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueDashPlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "LeagueDashPlayerStats", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "LeagueDashPlayerStats", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      stats = LeagueDashPlayerStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "LeagueDashPlayerStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "LeagueDashPlayerStats", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashPlayerStats.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "LeagueDashPlayerStats", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      stats = LeagueDashPlayerStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "LeagueDashPlayerStats", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      stats = LeagueDashPlayerStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    private

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS
        PLUS_MINUS NBA_FANTASY_PTS DD2 TD3]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 72, 46, 26, 0.639, 34.5, 9.2, 19.8, 0.465,
        4.8, 11.2, 0.429, 5.1, 5.5, 0.927, 0.5, 4.3, 4.8, 5.1, 3.2, 0.9, 0.4, 0.3, 2.1, 4.2, 28.3,
        5.2, 45.6, 12, 0]
    end
  end
end
