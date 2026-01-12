require_relative "../../test_helper"

module NBA
  class IstStandingsMissingGroupInfoTest < Minitest::Test
    cover IstStandings

    def test_all_handles_missing_conference
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::LAL, "Lakers"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal "Lakers", standing.team_name
      assert_nil standing.conference
    end

    def test_all_handles_missing_ist_group
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::LAL, "Lakers"]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal "Lakers", standing.team_name
      assert_nil standing.ist_group
    end

    def test_all_handles_missing_ist_group_rank
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME WINS], rowSet: [[Team::LAL, "Lakers", 3]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 3, standing.wins
      assert_nil standing.ist_group_rank
    end
  end
end
