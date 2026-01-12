require_relative "../../test_helper"

module NBA
  class CommonTeamYearsAttributeMappingTest < Minitest::Test
    cover CommonTeamYears

    def test_maps_team_id
      stub_team_years_request

      year = CommonTeamYears.all.first

      assert_equal Team::GSW, year.team_id
    end

    def test_maps_year
      stub_team_years_request

      year = CommonTeamYears.all.first

      assert_equal 2024, year.year
    end

    def test_maps_abbreviation
      stub_team_years_request

      year = CommonTeamYears.all.first

      assert_equal "GSW", year.abbreviation
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
      [["00", Team::GSW, 1946, 2024, "GSW"]]
    end
  end
end
