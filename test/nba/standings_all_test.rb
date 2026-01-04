require_relative "../test_helper"

module NBA
  class StandingsAllTest < Minitest::Test
    cover Standings

    def test_all_returns_collection
      stub_standings_request

      assert_instance_of Collection, Standings.all
    end

    def test_all_parses_team_info
      stub_standings_request

      standing = Standings.all.first

      assert_equal Team::GSW, standing.team_id
      assert_equal "Golden State Warriors", standing.team_name
      assert_equal "West", standing.conference
      assert_equal "Pacific", standing.division
    end

    def test_all_parses_record
      stub_standings_request

      standing = Standings.all.first

      assert_equal 45, standing.wins
      assert_equal 30, standing.losses
      assert_in_delta 0.600, standing.win_pct
    end

    def test_all_parses_standings_details
      stub_standings_request

      standing = Standings.all.first

      assert_equal "25-12", standing.home_record
      assert_equal "20-18", standing.road_record
      assert_equal "W3", standing.streak
    end

    def test_all_with_custom_season
      stub_request(:get, /leaguestandings.*Season=2023-24/).to_return(body: standings_response.to_json)

      Standings.all(season: 2023)

      assert_requested :get, /leaguestandings.*Season=2023-24/
    end

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Standings.all(client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, Standings.all.size
    end

    def test_all_returns_empty_collection_when_no_headers
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: nil, rowSet: [["data"]]}]}.to_json)

      assert_equal 0, Standings.all.size
    end

    def test_all_returns_empty_collection_when_no_rows
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: %w[TeamID], rowSet: nil}]}.to_json)

      assert_equal 0, Standings.all.size
    end

    def test_all_handles_minimal_headers
      response = {resultSets: [{headers: %w[TeamID TeamName WINS LOSSES], rowSet: [[Team::GSW, "Warriors", 50, 32]]}]}
      stub_request(:get, /leaguestandings/).to_return(body: response.to_json)

      standing = Standings.all.first

      assert_equal Team::GSW, standing.team_id
      assert_equal "Warriors", standing.team_name
      assert_equal 50, standing.wins
      assert_nil standing.conference
      assert_nil standing.home_record
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{headers: %w[TeamName WINS LOSSES], rowSet: [["Warriors", 50, 32]]}]}
      stub_request(:get, /leaguestandings/).to_return(body: response.to_json)

      standing = Standings.all.first

      assert_nil standing.team_id
      assert_equal "Warriors", standing.team_name
    end

    def test_all_handles_missing_wins
      response = {resultSets: [{headers: %w[TeamID TeamName LOSSES], rowSet: [[Team::GSW, "Warriors", 32]]}]}
      stub_request(:get, /leaguestandings/).to_return(body: response.to_json)

      standing = Standings.all.first

      assert_equal Team::GSW, standing.team_id
      assert_nil standing.wins
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandings/).to_return(body: standings_response.to_json)
    end

    def standings_response
      {resultSets: [{headers: standings_headers, rowSet: [standings_row]}]}
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]

    def standings_row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]
  end
end
