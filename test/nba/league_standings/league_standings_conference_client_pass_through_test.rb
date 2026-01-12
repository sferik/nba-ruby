require_relative "../../test_helper"

module NBA
  class LeagueStandingsConferenceClientPassThroughTest < Minitest::Test
    cover LeagueStandings

    def test_conference_passes_client_to_all
      mock_client = Minitest::Mock.new
      mock_client.expect :get, standings_response.to_json, [String]

      LeagueStandings.conference("West", season: 2024, client: mock_client)

      mock_client.verify
    end

    private

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
