require_relative "../../test_helper"

module NBA
  class RosterBirthDateEdgeCasesTest < Minitest::Test
    cover Roster

    def test_find_handles_nil_birth_date
      stub_roster_with(birth_date: nil)

      assert_nil Roster.find(team: Team::GSW).first.country
    end

    def test_find_handles_birth_date_without_comma
      stub_roster_with(birth_date: "March 14")

      assert_equal "March 14", Roster.find(team: Team::GSW).first.country
    end

    def test_find_handles_birth_date_only_comma
      stub_roster_with(birth_date: ",")

      assert_nil Roster.find(team: Team::GSW).first.country
    end

    def test_find_handles_empty_birth_date
      stub_roster_with(birth_date: "")

      assert_nil Roster.find(team: Team::GSW).first.country
    end

    def test_find_parses_country_from_birth_date
      stub_roster_with(birth_date: "March 14, 1988")

      assert_equal "1988", Roster.find(team: Team::GSW).first.country
    end

    def test_find_strips_whitespace_from_country
      stub_roster_with(birth_date: "March 14,   USA  ")

      assert_equal "USA", Roster.find(team: Team::GSW).first.country
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
