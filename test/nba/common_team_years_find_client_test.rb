require_relative "common_team_years_edge_cases_helper"

module NBA
  class CommonTeamYearsFindClientTest < Minitest::Test
    include CommonTeamYearsTestHelpers

    cover CommonTeamYears

    def test_find_passes_client_to_all
      custom_client = Minitest::Mock.new
      response = {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
      custom_client.expect :get, response.to_json, ["commonteamyears?LeagueID=00"]

      CommonTeamYears.find(team: Team::GSW, client: custom_client)

      custom_client.verify
    end

    def test_find_returns_collection_instance
      response = {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      result = CommonTeamYears.find(team: Team::GSW)

      assert_instance_of Collection, result
    end
  end
end
