require_relative "common_team_years_edge_cases_helper"

module NBA
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
end
