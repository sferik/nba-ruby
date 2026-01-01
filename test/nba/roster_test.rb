require_relative "../test_helper"

module NBA
  class RosterFindTest < Minitest::Test
    cover Roster

    def test_find_returns_collection_of_players
      stub_roster_request

      roster = Roster.find(team: Team::GSW)

      assert_instance_of Collection, roster
    end

    def test_find_parses_player_identity
      stub_roster_request

      curry = Roster.find(team: Team::GSW).first

      assert_equal 201_939, curry.id
      assert_equal "Stephen Curry", curry.full_name
      assert_equal "Stephen", curry.first_name
      assert_equal "Curry", curry.last_name
    end

    def test_find_parses_player_physical
      stub_roster_request

      curry = Roster.find(team: Team::GSW).first

      assert_equal 30, curry.jersey_number
      assert_equal "6-2", curry.height
      assert_equal 185, curry.weight
    end

    def test_find_parses_player_background
      stub_roster_request

      curry = Roster.find(team: Team::GSW).first

      assert_equal "Davidson", curry.college
      assert curry.is_active
    end

    def test_find_with_team_object
      stub_request(:get, /commonteamroster.*TeamID=#{Team::GSW}/o).to_return(body: roster_response.to_json)
      team = Team.new(id: Team::GSW)

      roster = Roster.find(team: team)

      assert_instance_of Collection, roster
    end

    def test_find_with_custom_season
      stub_request(:get, /commonteamroster.*Season=2023-24/).to_return(body: roster_response.to_json)

      Roster.find(team: Team::GSW, season: 2023)

      assert_requested :get, /commonteamroster.*Season=2023-24/
    end

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Roster.find(team: Team::GSW, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_sets
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, Roster.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_no_headers
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: [{headers: nil, rowSet: [["data"]]}]}.to_json)

      assert_equal 0, Roster.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_no_rows
      stub_request(:get, /commonteamroster/).to_return(body: {resultSets: [{headers: %w[PLAYER_ID PLAYER], rowSet: nil}]}.to_json)

      assert_equal 0, Roster.find(team: Team::GSW).size
    end

    private

    def stub_roster_request
      stub_request(:get, /commonteamroster/).to_return(body: roster_response.to_json)
    end

    def roster_response
      {resultSets: [{headers: roster_headers, rowSet: [[201_939, "Stephen Curry", "30", "6-2", 185, "Davidson", "March 14, 1988"]]}]}
    end

    def roster_headers = %w[PLAYER_ID PLAYER NUM HEIGHT WEIGHT SCHOOL BIRTH_DATE]
  end

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
