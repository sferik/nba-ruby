require_relative "common_team_years_edge_cases_helper"

module NBA
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

    def test_find_accepts_team_object
      stub_request(:get, /commonteamyears/).to_return(body: multi_team_response.to_json)
      team = Team.new(id: Team::LAL)

      years = CommonTeamYears.find(team: team)

      assert_equal 1, years.size
      assert_equal Team::LAL, years.first.team_id
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
