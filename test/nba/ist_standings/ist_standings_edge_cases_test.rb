require_relative "../../test_helper"

module NBA
  class IstStandingsEdgeCasesTest < Minitest::Test
    cover IstStandings

    def test_all_handles_nil_response
      stub_request(:get, /iststandings/).to_return(body: nil)

      result = IstStandings.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /iststandings/).to_return(body: {resultSets: []}.to_json)

      result = IstStandings.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      result = IstStandings.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID TEAM_NAME], rowSet: []}]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      result = IstStandings.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_default_league_is_nba
      stub_request(:get, /iststandings.*LeagueID=00/)
        .to_return(body: ist_standings_response.to_json)

      IstStandings.all

      assert_requested :get, /iststandings.*LeagueID=00/
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "Standings", headers: all_headers, rowSet: [full_row]}
      ]}
      stub_request(:get, /iststandings/).to_return(body: response.to_json)

      standing = IstStandings.all.first

      assert_equal Team::LAL, standing.team_id
      assert_equal "Lakers", standing.team_name
    end

    private

    def all_headers
      %w[SEASON_ID TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION TEAM_SLUG
        CONFERENCE IST_GROUP IST_GROUP_RANK WINS LOSSES WIN_PCT PTS_FOR PTS_AGAINST
        PTS_DIFF CLINCH_INDICATOR]
    end

    def full_row
      ["2023-24", Team::LAL, "Los Angeles", "Lakers", "LAL", "lakers",
        "West", "West Group A", 1, 3, 1, 0.750, 450, 420, 30, "z"]
    end

    def ist_standings_response
      {resultSets: [{name: "Standings",
                     headers: %w[SEASON_ID TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION TEAM_SLUG
                       CONFERENCE IST_GROUP IST_GROUP_RANK WINS LOSSES WIN_PCT PTS_FOR PTS_AGAINST
                       PTS_DIFF CLINCH_INDICATOR],
                     rowSet: [["2023-24", Team::LAL, "Los Angeles", "Lakers", "LAL", "lakers",
                       "West", "West Group A", 1, 3, 1, 0.750, 450, 420, 30, "z"]]}]}
    end
  end
end
