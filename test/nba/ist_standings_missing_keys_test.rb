require_relative "../test_helper"

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

  class IstStandingsMissingRecordInfoTest < Minitest::Test
    cover IstStandings

    def test_all_handles_missing_wins
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME LOSSES], rowSet: [[Team::LAL, "Lakers", 1]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 1, standing.losses
      assert_nil standing.wins
    end

    def test_all_handles_missing_losses
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME WINS], rowSet: [[Team::LAL, "Lakers", 3]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 3, standing.wins
      assert_nil standing.losses
    end

    def test_all_handles_missing_win_pct
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME WINS], rowSet: [[Team::LAL, "Lakers", 3]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 3, standing.wins
      assert_nil standing.win_pct
    end

    def test_all_handles_missing_clinch_indicator
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME WINS], rowSet: [[Team::LAL, "Lakers", 3]]}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal 3, standing.wins
      assert_nil standing.clinch_indicator
    end
  end

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
