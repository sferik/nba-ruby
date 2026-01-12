require_relative "../../test_helper"

module NBA
  class CommonTeamYearsAllTest < Minitest::Test
    cover CommonTeamYears

    def test_all_returns_collection
      stub_team_years_request

      result = CommonTeamYears.all

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_path
      stub_team_years_request

      CommonTeamYears.all

      assert_requested :get, /commonteamyears\?LeagueID=00/
    end

    def test_all_parses_team_years_successfully
      stub_team_years_request

      years = CommonTeamYears.all

      assert_equal 2, years.size
      assert_equal Team::GSW, years.first.team_id
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, team_years_response.to_json, [String]

      CommonTeamYears.all(client: mock_client)

      mock_client.verify
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
