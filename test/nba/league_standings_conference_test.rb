require_relative "../test_helper"

module NBA
  class LeagueStandingsConferenceTest < Minitest::Test
    cover LeagueStandings

    def test_conference_returns_collection
      stub_standings_request

      result = LeagueStandings.conference("West", season: 2024)

      assert_instance_of Collection, result
    end

    def test_conference_filters_by_conference_name
      stub_standings_request

      west_standings = LeagueStandings.conference("West", season: 2024)

      assert_equal 1, west_standings.size
      assert_equal "West", west_standings.first.conference
    end

    def test_conference_returns_east_standings
      stub_standings_request

      east_standings = LeagueStandings.conference("East", season: 2024)

      assert_equal 1, east_standings.size
      assert_equal "East", east_standings.first.conference
    end

    def test_conference_returns_empty_for_non_matching
      stub_standings_request

      result = LeagueStandings.conference("Central", season: 2024)

      assert_equal 0, result.size
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
