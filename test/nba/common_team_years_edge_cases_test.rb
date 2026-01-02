require_relative "../test_helper"

module NBA
  module CommonTeamYearsTestHelpers
    private

    def headers
      %w[LEAGUE_ID TEAM_ID MIN_YEAR MAX_YEAR ABBREVIATION]
    end

    def rows
      [["00", Team::GSW, 1946, 2024, "GSW"]]
    end
  end

  class CommonTeamYearsNilResponseTest < Minitest::Test
    include CommonTeamYearsTestHelpers

    cover CommonTeamYears

    def test_all_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CommonTeamYears.all(client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_all_returns_empty_when_no_result_sets
      stub_request(:get, /commonteamyears/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_result_sets_key_missing
      stub_request(:get, /commonteamyears/).to_return(body: {}.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamYears", rowSet: [[1]]}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamYears", headers: %w[TEAM_ID]}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamYears", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamYears", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end
  end

  class CommonTeamYearsResultSetOrderingTest < Minitest::Test
    include CommonTeamYearsTestHelpers

    cover CommonTeamYears

    def test_all_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamYears", headers: headers, rowSet: rows}
      ]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      years = CommonTeamYears.all

      assert_equal 1, years.size
      assert_equal Team::GSW, years.first.team_id
    end

    def test_all_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamYears", headers: headers, rowSet: rows},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      years = CommonTeamYears.all

      assert_equal 1, years.size
      assert_equal Team::GSW, years.first.team_id
    end
  end

  class CommonTeamYearsYearParsingTest < Minitest::Test
    include CommonTeamYearsTestHelpers

    cover CommonTeamYears

    def test_year_returned_as_integer_when_string
      rows = [["00", Team::GSW, 1946, "2024", "GSW"]]
      response = {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      years = CommonTeamYears.all

      assert_equal 2024, years.first.year
      assert_kind_of Integer, years.first.year
    end

    def test_handles_nil_year
      rows = [["00", Team::GSW, 1946, nil, "GSW"]]
      response = {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_nil CommonTeamYears.all.first.year
    end

    def test_handles_valid_year
      rows = [["00", Team::GSW, 1946, "2024", "GSW"]]
      response = {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 2024, CommonTeamYears.all.first.year
    end
  end

  class CommonTeamYearsFindTest < Minitest::Test
    include CommonTeamYearsTestHelpers

    cover CommonTeamYears

    def test_find_returns_only_matching_team
      stub_request(:get, /commonteamyears/).to_return(body: multi_team_response.to_json)

      years = CommonTeamYears.find(team: Team::LAL)

      assert_equal 1, years.size
      assert_equal Team::LAL, years.first.team_id
    end

    def test_find_returns_empty_when_no_match
      response = {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.find(team: 999_999).size
    end

    private

    def multi_team_response
      rows = [
        ["00", Team::GSW, 1946, 2024, "GSW"],
        ["00", Team::LAL, 1948, 2024, "LAL"]
      ]
      {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
    end
  end
end
