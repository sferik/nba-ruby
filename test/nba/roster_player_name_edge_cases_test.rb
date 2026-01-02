require_relative "../test_helper"

module NBA
  class RosterPlayerNameEdgeCasesTest < Minitest::Test
    cover Roster

    def test_find_handles_nil_player_name
      stub_roster_with(player: nil)

      player = Roster.find(team: Team::GSW).first

      assert_nil player.full_name
      assert_nil player.first_name
      assert_equal "", player.last_name
    end

    def test_find_handles_multi_part_last_name
      stub_roster_with(player: "Juan Carlos De La Rosa")

      player = Roster.find(team: Team::GSW).first

      assert_equal "Juan", player.first_name
      assert_equal "Carlos De La Rosa", player.last_name
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
