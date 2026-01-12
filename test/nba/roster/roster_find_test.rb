require_relative "../../test_helper"

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

    def test_find_handles_minimal_headers
      response = {resultSets: [{headers: %w[PLAYER_ID PLAYER], rowSet: [[201_939, "Stephen Curry"]]}]}
      stub_request(:get, /commonteamroster/).to_return(body: response.to_json)

      player = Roster.find(team: Team::GSW).first

      assert_equal 201_939, player.id
      assert_equal "Stephen Curry", player.full_name
      assert_nil player.jersey_number
      assert_nil player.height
      assert_nil player.weight
    end

    def test_find_handles_missing_player_id
      response = {resultSets: [{headers: %w[PLAYER], rowSet: [["Stephen Curry"]]}]}
      stub_request(:get, /commonteamroster/).to_return(body: response.to_json)

      player = Roster.find(team: Team::GSW).first

      assert_nil player.id
      assert_equal "Stephen Curry", player.full_name
    end

    def test_find_handles_missing_player_name
      response = {resultSets: [{headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}
      stub_request(:get, /commonteamroster/).to_return(body: response.to_json)

      player = Roster.find(team: Team::GSW).first

      assert_equal 201_939, player.id
      assert_nil player.full_name
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
end
