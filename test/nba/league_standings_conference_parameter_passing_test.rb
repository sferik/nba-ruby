require_relative "../test_helper"

module NBA
  class LeagueStandingsConferenceParameterPassingTest < Minitest::Test
    cover LeagueStandings

    def test_conference_passes_season_parameter
      stub_standings_request

      LeagueStandings.conference("West", season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_conference_passes_season_type_parameter
      stub_standings_request

      LeagueStandings.conference("West", season: 2024, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_conference_passes_league_id_parameter
      stub_standings_request

      LeagueStandings.conference("West", season: 2024, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_conference_uses_default_league_id
      stub_standings_request

      LeagueStandings.conference("West", season: 2024)

      assert_requested :get, /LeagueID=00/
    end

    def test_conference_uses_default_season_type
      stub_standings_request

      LeagueStandings.conference("West", season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandingsv3/).to_return(body: standings_response.to_json)
    end

    def standings_response
      {resultSets: [{name: "Standings", headers: standing_headers, rowSet: [west_row]}]}
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
  end
end
