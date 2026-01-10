require_relative "../test_helper"

module NBA
  class IstStandingsMissingPointsInfoTest < Minitest::Test
    cover IstStandings

    def test_all_handles_missing_pts_for
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME PTS_AGAINST], rowSet: [[Team::LAL, "Lakers", 420]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 420, standing.pts_against
      assert_nil standing.pts_for
    end

    def test_all_handles_missing_pts_against
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME PTS_FOR], rowSet: [[Team::LAL, "Lakers", 450]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 450, standing.pts_for
      assert_nil standing.pts_against
    end

    def test_all_handles_missing_pts_diff
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME PTS_FOR], rowSet: [[Team::LAL, "Lakers", 450]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 450, standing.pts_for
      assert_nil standing.pts_diff
    end
  end
end
