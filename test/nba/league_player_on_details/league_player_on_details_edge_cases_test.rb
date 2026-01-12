require_relative "../../test_helper"

module NBA
  class LeaguePlayerOnDetailsEdgeCasesTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leagueplayerondetails/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leagueplayerondetails/).to_return(body: {}.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayersOnCourtLeaguePlayerDetails", rowSet: [[1]]}]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PlayersOnCourtLeaguePlayerDetails", headers: %w[TEAM_ID]}]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayersOnCourtLeaguePlayerDetails", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayersOnCourtLeaguePlayerDetails", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      assert_equal 0, LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayersOnCourtLeaguePlayerDetails", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      stats = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayersOnCourtLeaguePlayerDetails", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /leagueplayerondetails/).to_return(body: response.to_json)

      stats = LeaguePlayerOnDetails.all(team: Team::GSW, season: 2024)

      assert_equal 1, stats.size
      assert_equal "Golden State Warriors", stats.first.team_name
    end

    private

    def stat_headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME COURT_STATUS
        GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def stat_row
      ["Overall", Team::GSW, "GSW", "Golden State Warriors", 201_939, "Stephen Curry", "On",
        74, 46, 28, 0.622, 32.5, 9.8, 20.2, 0.485, 4.8, 11.7, 0.411, 4.2, 4.6, 0.913,
        0.7, 5.4, 6.1, 6.3, 3.2, 0.9, 0.4, 0.3, 2.0, 3.8, 28.6, 7.4]
    end
  end
end
