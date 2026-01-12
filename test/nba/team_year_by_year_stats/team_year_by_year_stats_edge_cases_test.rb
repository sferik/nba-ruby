require_relative "../../test_helper"

module NBA
  class TeamYearByYearStatsEdgeCasesTest < Minitest::Test
    cover TeamYearByYearStats

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamYearByYearStats.find(team: Team::GSW, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /teamyearbyyearstats/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /teamyearbyyearstats/).to_return(body: {}.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamStats", headers: %w[TEAM_ID]}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "TeamStats", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      stats = TeamYearByYearStats.find(team: Team::GSW)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamStats", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      assert_equal 0, TeamYearByYearStats.find(team: Team::GSW).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      stats = TeamYearByYearStats.find(team: Team::GSW)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamStats", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      stats = TeamYearByYearStats.find(team: Team::GSW)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    private

    def stat_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME YEAR GP WINS LOSSES WIN_PCT CONF_RANK DIV_RANK PO_WINS PO_LOSSES
        NBA_FINALS_APPEARANCE FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST PF STL TOV BLK PTS PTS_RANK]
    end

    def stat_row
      [Team::GSW, "Golden State", "Warriors", "2024-25", 82, 46, 36, 0.561, 10, 3, 0, 0,
        "N/A", 43.2, 91.5, 0.472, 14.8, 40.2, 0.368, 17.5, 22.1, 0.792,
        10.5, 33.8, 44.3, 28.1, 19.5, 7.8, 14.2, 5.2, 118.7, 5]
    end
  end
end
