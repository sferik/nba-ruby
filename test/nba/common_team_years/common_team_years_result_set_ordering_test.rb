require_relative "common_team_years_edge_cases_helper"

module NBA
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
end
