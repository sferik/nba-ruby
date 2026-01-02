require_relative "../test_helper"

module NBA
  class CommonTeamYearsFindTest < Minitest::Test
    cover CommonTeamYears

    def test_find_returns_collection
      stub_team_years_request

      result = CommonTeamYears.find(team: Team::GSW)

      assert_instance_of Collection, result
    end

    def test_find_filters_by_team_id
      stub_team_years_request

      years = CommonTeamYears.find(team: Team::GSW)

      assert_equal 1, years.size
      assert_equal Team::GSW, years.first.team_id
    end

    def test_find_accepts_team_object
      stub_team_years_request
      team = Team.new(id: Team::GSW)

      years = CommonTeamYears.find(team: team)

      assert_equal 1, years.size
      assert_equal Team::GSW, years.first.team_id
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_years_response.to_json, [String]

      CommonTeamYears.find(team: Team::GSW, client: mock_client)

      mock_client.verify
    end

    def test_find_returns_empty_when_team_not_found
      stub_team_years_request

      years = CommonTeamYears.find(team: 9_999_999)

      assert_equal 0, years.size
    end

    private

    def stub_team_years_request
      stub_request(:get, /commonteamyears/).to_return(body: team_years_response.to_json)
    end

    def team_years_response
      {resultSets: [{name: "TeamYears", headers: headers, rowSet: rows}]}
    end

    def headers
      %w[LEAGUE_ID TEAM_ID MIN_YEAR MAX_YEAR ABBREVIATION]
    end

    def rows
      [
        ["00", Team::GSW, 1946, 2024, "GSW"],
        ["00", 1_610_612_747, 1948, 2024, "LAL"]
      ]
    end
  end
end
