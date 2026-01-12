require_relative "../../test_helper"

module NBA
  class IstStandingsMissingTeamInfoTest < Minitest::Test
    cover IstStandings

    def test_all_handles_missing_season_id
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::LAL, "Lakers"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_nil standing.season_id
      assert_equal Team::LAL, standing.team_id
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "Standings", headers: %w[SEASON_ID TEAM_NAME], rowSet: [%w[2023-24 Lakers]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal "2023-24", standing.season_id
      assert_nil standing.team_id
    end

    def test_all_handles_missing_team_city
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::LAL, "Lakers"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal "Lakers", standing.team_name
      assert_nil standing.team_city
    end

    def test_all_handles_missing_team_name
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_CITY], rowSet: [[Team::LAL, "Los Angeles"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal Team::LAL, standing.team_id
      assert_nil standing.team_name
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::LAL, "Lakers"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal "Lakers", standing.team_name
      assert_nil standing.team_abbreviation
    end

    def test_all_handles_missing_team_slug
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::LAL, "Lakers"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal "Lakers", standing.team_name
      assert_nil standing.team_slug
    end
  end
end
