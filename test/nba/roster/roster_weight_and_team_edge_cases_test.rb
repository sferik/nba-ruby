require_relative "../../test_helper"

module NBA
  class RosterWeightAndTeamEdgeCasesTest < Minitest::Test
    cover Roster

    def test_find_handles_integer_weight_directly
      stub_roster_with(weight: 200)

      assert_equal 200, Roster.find(team: Team::GSW).first.weight
    end

    def test_find_handles_nil_weight
      stub_roster_with(weight: nil)

      assert_nil Roster.find(team: Team::GSW).first.weight
    end

    def test_find_parses_weight_from_string
      stub_roster_with(weight: "185")

      assert_equal 185, Roster.find(team: Team::GSW).first.weight
    end

    def test_find_handles_non_numeric_weight
      stub_roster_with(weight: "N/A")

      assert_nil Roster.find(team: Team::GSW).first.weight
    end

    def test_find_with_integer_team_id
      stub_request(:get, /commonteamroster.*TeamID=1610612744/).to_return(body: roster_response.to_json)

      roster = Roster.find(team: 1_610_612_744)

      assert_instance_of Collection, roster
    end

    def test_find_extracts_team_id_from_team_object
      team = Team.new(id: 1_610_612_744)
      stub_request(:get, /commonteamroster.*TeamID=1610612744/).to_return(body: roster_response.to_json)

      roster = Roster.find(team: team)

      assert_instance_of Collection, roster
    end

    def test_find_uses_first_result_set
      response = {resultSets: [first_result_set, {headers: %w[OTHER], rowSet: [["other"]]}]}
      stub_request(:get, /commonteamroster/).to_return(body: response.to_json)

      assert_equal "Stephen Curry", Roster.find(team: Team::GSW).first.full_name
    end

    private

    def first_result_set
      {headers: roster_headers, rowSet: [[201_939, "Stephen Curry", "30", "6-2", 185, "Davidson", "March 14, 1988"]]}
    end

    def stub_roster_with(overrides)
      row = [201_939, "Stephen Curry", "30", "6-2", 185, "Davidson", "March 14, 1988"]
      field_map = {player: 1, num: 2, weight: 4, birth_date: 6}
      overrides.each { |k, v| row[field_map.fetch(k)] = v }
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: [{headers: roster_headers, rowSet: [row]}]}.to_json)
    end

    def roster_response
      {resultSets: [{headers: roster_headers, rowSet: [[201_939, "Stephen Curry", "30", "6-2", 185, "Davidson", "March 14, 1988"]]}]}
    end

    def roster_headers = %w[PLAYER_ID PLAYER NUM HEIGHT WEIGHT SCHOOL BIRTH_DATE]
  end
end
