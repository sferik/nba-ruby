require_relative "../test_helper"

module NBA
  class PlayerCareerStatsEdgeCasesTest < Minitest::Test
    cover PlayerCareerStats

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, PlayerCareerStats.find(player: 201_939, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_sets
      stub_request(:get, /playercareerstats/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /playercareerstats/).to_return(body: {}.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_result_set_not_found
      stub_request(:get, /playercareerstats/).to_return(body: {resultSets: [{name: "Other", headers: [], rowSet: []}]}.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_no_headers
      response = {resultSets: [{name: "SeasonTotalsRegularSeason", headers: nil, rowSet: []}]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{name: "SeasonTotalsRegularSeason", rowSet: [["2024-25"]]}]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_no_rows
      response = {resultSets: [{name: "SeasonTotalsRegularSeason", headers: %w[SEASON_ID], rowSet: nil}]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{name: "SeasonTotalsRegularSeason", headers: %w[SEASON_ID]}]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      assert_equal 0, PlayerCareerStats.find(player: 201_939).size
    end

    def test_find_uses_correct_result_set_name
      correct_set = {name: "SeasonTotalsRegularSeason", headers: %w[SEASON_ID], rowSet: [["2024-25"]]}
      wrong_set = {name: "CareerTotalsRegularSeason", headers: %w[SEASON_ID], rowSet: [["CAREER"]]}
      response = {resultSets: [wrong_set, correct_set]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal "2024-25", stats.season_id
    end

    def test_find_handles_missing_season_id_header
      response = {resultSets: [{name: "SeasonTotalsRegularSeason", headers: %w[TEAM_ID], rowSet: [[Team::GSW]]}]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_nil stats.season_id
      assert_equal Team::GSW, stats.team_id
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      correct_set = {name: "SeasonTotalsRegularSeason", headers: %w[SEASON_ID], rowSet: [["2024-25"]]}
      response = {resultSets: [unnamed_set, correct_set]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal "2024-25", stats.season_id
    end

    def test_find_uses_find_not_last_for_result_set
      first_set = {name: "CareerTotalsRegularSeason", headers: %w[SEASON_ID], rowSet: [["CAREER"]]}
      correct_set = {name: "SeasonTotalsRegularSeason", headers: %w[SEASON_ID], rowSet: [["2024-25"]]}
      last_set = {name: "CareerTotalsPostSeason", headers: %w[SEASON_ID], rowSet: [["CAREER_POST"]]}
      response = {resultSets: [first_set, correct_set, last_set]}
      stub_request(:get, /playercareerstats/).to_return(body: response.to_json)

      stats = PlayerCareerStats.find(player: 201_939).first

      assert_equal "2024-25", stats.season_id
    end
  end
end
