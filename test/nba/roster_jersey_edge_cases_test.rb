require_relative "../test_helper"

module NBA
  class RosterJerseyEdgeCasesTest < Minitest::Test
    cover Roster

    def test_find_handles_empty_jersey
      stub_roster_with(num: "")

      assert_nil Roster.find(team: Team::GSW).first.jersey_number
    end

    def test_find_handles_non_numeric_jersey
      stub_roster_with(num: "N/A")

      assert_nil Roster.find(team: Team::GSW).first.jersey_number
    end

    def test_find_handles_whitespace_jersey
      stub_roster_with(num: "   ")

      assert_nil Roster.find(team: Team::GSW).first.jersey_number
    end

    def test_find_parses_jersey_from_string
      stub_roster_with(num: "30")

      assert_equal 30, Roster.find(team: Team::GSW).first.jersey_number
    end

    private

    def stub_roster_with(overrides)
      row = [201_939, "Stephen Curry", "30", "6-2", 185, "Davidson", "March 14, 1988"]
      field_map = {player: 1, num: 2, weight: 4, birth_date: 6}
      overrides.each { |k, v| row[field_map.fetch(k)] = v }
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: [{headers: roster_headers, rowSet: [row]}]}.to_json)
    end

    def roster_headers = %w[PLAYER_ID PLAYER NUM HEIGHT WEIGHT SCHOOL BIRTH_DATE]
  end
end
