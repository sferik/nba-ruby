require_relative "../test_helper"

module NBA
  class LeagueStandingsAllTest < Minitest::Test
    cover LeagueStandings

    def test_all_returns_collection
      stub_standings_request

      result = LeagueStandings.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_standings_request

      LeagueStandings.all(season: 2024)

      assert_requested :get, /leaguestandingsv3.*Season=2024-25/
    end

    def test_all_uses_correct_league_id_in_path
      stub_standings_request

      LeagueStandings.all(season: 2024)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_standings_successfully
      stub_standings_request

      standings = LeagueStandings.all(season: 2024)

      assert_equal 2, standings.size
      assert_equal Team::GSW, standings.first.team_id
    end

    def test_all_accepts_season_type_parameter
      stub_standings_request

      LeagueStandings.all(season: 2024, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_accepts_league_object
      stub_standings_request
      league = League.new(id: "10", name: "WNBA")

      LeagueStandings.all(season: 2024, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandingsv3/).to_return(body: standings_response.to_json)
    end

    def standings_response
      {resultSets: [{name: "Standings", headers: standing_headers, rowSet: [west_row, east_row]}]}
    end

    def standing_headers
      %w[LeagueID SeasonID TeamID TeamCity TeamName TeamSlug Conference ConferenceRecord
        PlayoffRank ClinchIndicator Division DivisionRecord DivisionRank WINS LOSSES
        WinPCT LeagueRank Record HOME ROAD L10 LongWinStreak LongLossStreak CurrentStreak
        ConferenceGamesBack ClinchedConferenceTitle ClinchedPlayoffBirth EliminatedConference
        PointsPG OppPointsPG DiffPointsPG]
    end

    def west_row
      ["00", "22024", Team::GSW, "Golden State", "Warriors", "warriors", "West", "30-22",
        10, "", "Pacific", "9-7", 3, 46, 36, 0.561, 15, "46-36", "28-13", "18-23", "6-4",
        7, 5, "W2", 9.0, 0, 1, 0, 118.7, 115.2, 3.5]
    end

    def east_row
      ["00", "22024", Team::BOS, "Boston", "Celtics", "celtics", "East", "35-17",
        1, "x", "Atlantic", "12-4", 1, 64, 18, 0.780, 1, "64-18", "37-4", "27-14", "8-2",
        11, 3, "W5", 0.0, 1, 1, 0, 120.6, 109.2, 11.4]
    end
  end
end
