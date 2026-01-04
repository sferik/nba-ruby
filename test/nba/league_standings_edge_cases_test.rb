require_relative "../test_helper"

module NBA
  class LeagueStandingsEdgeCasesTest < Minitest::Test
    cover LeagueStandings

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueStandings.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguestandingsv3/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguestandingsv3/).to_return(body: {}.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "Standings", rowSet: [[1]]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "Standings", headers: %w[TEAM_ID]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: standing_headers, rowSet: [standing_row]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "Standings", headers: standing_headers, rowSet: [standing_row]}
      ]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      standings = LeagueStandings.all(season: 2024)

      assert_equal 1, standings.size
      assert_equal Team::GSW, standings.first.team_id
    end

    def test_finds_standings_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "Standings", headers: standing_headers, rowSet: [standing_row]}
      ]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      standings = LeagueStandings.all(season: 2024)

      assert_equal 1, standings.size
      assert_equal Team::GSW, standings.first.team_id
    end

    def test_finds_standings_result_set_when_not_last
      response = {resultSets: [
        {name: "Standings", headers: standing_headers, rowSet: [standing_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      standings = LeagueStandings.all(season: 2024)

      assert_equal 1, standings.size
      assert_equal Team::GSW, standings.first.team_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "Standings", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "Standings", headers: %w[TeamID], rowSet: nil}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_equal 0, LeagueStandings.all(season: 2024).size
    end

    private

    def standing_headers
      %w[LeagueID SeasonID TeamID TeamCity TeamName TeamSlug Conference ConferenceRecord
        PlayoffRank ClinchIndicator Division DivisionRecord DivisionRank WINS LOSSES
        WinPCT LeagueRank Record HOME ROAD L10 LongWinStreak LongLossStreak CurrentStreak
        ConferenceGamesBack ClinchedConferenceTitle ClinchedPlayoffBirth EliminatedConference
        PointsPG OppPointsPG DiffPointsPG]
    end

    def standing_row
      ["00", "22024", Team::GSW, "Golden State", "Warriors", "warriors", "West", "30-22",
        10, "", "Pacific", "9-7", 3, 46, 36, 0.561, 15, "46-36", "28-13", "18-23", "6-4",
        7, 5, "W2", 9.0, 0, 1, 0, 118.7, 115.2, 3.5]
    end
  end
end
