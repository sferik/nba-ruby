require_relative "../../test_helper"

module NBA
  class LeagueStandingsMissingAttributeKeysTest < Minitest::Test
    cover LeagueStandings

    def test_raises_when_l10_key_missing
      response = {resultSets: [{name: "Standings", headers: headers_without("L10"), rowSet: [row_without("L10")]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_raises(KeyError) { LeagueStandings.all(season: 2024) }
    end

    def test_raises_when_long_win_streak_key_missing
      response = {resultSets: [{name: "Standings", headers: headers_without("LongWinStreak"), rowSet: [row_without("LongWinStreak")]}]}
      stub_request(:get, /leaguestandingsv3/).to_return(body: response.to_json)

      assert_raises(KeyError) { LeagueStandings.all(season: 2024) }
    end

    private

    def full_headers
      %w[LeagueID SeasonID TeamID TeamCity TeamName TeamSlug Conference ConferenceRecord
        PlayoffRank ClinchIndicator Division DivisionRecord DivisionRank WINS LOSSES
        WinPCT LeagueRank Record HOME ROAD L10 LongWinStreak LongLossStreak CurrentStreak
        ConferenceGamesBack ClinchedConferenceTitle ClinchedPlayoffBirth EliminatedConference
        PointsPG OppPointsPG DiffPointsPG]
    end

    def full_row
      ["00", "22024", Team::GSW, "Golden State", "Warriors", "warriors", "West", "30-22",
        10, "", "Pacific", "9-7", 3, 46, 36, 0.561, 15, "46-36", "28-13", "18-23", "6-4",
        7, 5, "W2", 9.0, 0, 1, 0, 118.7, 115.2, 3.5]
    end

    def headers_without(key)
      idx = full_headers.index(key)
      full_headers.reject.with_index { |_, i| i == idx }
    end

    def row_without(key)
      idx = full_headers.index(key)
      full_row.reject.with_index { |_, i| i == idx }
    end
  end
end
