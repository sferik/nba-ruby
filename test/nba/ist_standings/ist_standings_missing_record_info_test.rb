require_relative "../../test_helper"

module NBA
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
end
