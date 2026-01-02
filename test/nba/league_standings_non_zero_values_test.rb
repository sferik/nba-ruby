require_relative "../test_helper"

module NBA
  class LeagueStandingsNonZeroValuesTest < Minitest::Test
    cover LeagueStandings

    def test_clinched_conference_title_with_value_one
      response = {resultSets: [{name: "Standings", headers: standing_headers, rowSet: [row_with_clinched_title]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      standing = LeagueStandings.all(season: 2024).first

      assert_equal 1, standing.clinched_conference_title
    end

    def test_eliminated_conference_with_value_one
      response = {resultSets: [{name: "Standings", headers: standing_headers, rowSet: [row_with_eliminated]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      standing = LeagueStandings.all(season: 2024).first

      assert_equal 1, standing.eliminated_conference
    end

    private

    def standing_headers
      %w[LeagueID SeasonID TeamID TeamCity TeamName TeamSlug Conference ConferenceRecord
        PlayoffRank ClinchIndicator Division DivisionRecord DivisionRank WINS LOSSES
        WinPCT LeagueRank Record HOME ROAD L10 LongWinStreak LongLossStreak CurrentStreak
        ConferenceGamesBack ClinchedConferenceTitle ClinchedPlayoffBirth EliminatedConference
        PointsPG OppPointsPG DiffPointsPG]
    end

    def row_with_clinched_title
      ["00", "22024", Team::GSW, "Golden State", "Warriors", "warriors", "West", "30-22",
        10, "", "Pacific", "9-7", 3, 46, 36, 0.561, 15, "46-36", "28-13", "18-23", "6-4",
        7, 5, "W2", 9.0, 1, 1, 0, 118.7, 115.2, 3.5]
    end

    def row_with_eliminated
      ["00", "22024", Team::GSW, "Golden State", "Warriors", "warriors", "West", "30-22",
        10, "", "Pacific", "9-7", 3, 46, 36, 0.561, 15, "46-36", "28-13", "18-23", "6-4",
        7, 5, "W2", 9.0, 0, 1, 1, 118.7, 115.2, 3.5]
    end
  end
end
