require_relative "../../test_helper"

module NBA
  class StandingsNilHandlingTest < Minitest::Test
    cover Standings

    def test_handles_missing_team_name
      standing = standing_with_missing_header("TeamName")

      assert_nil standing.team_name
    end

    def test_handles_missing_conference
      standing = standing_with_missing_header("Conference")

      assert_nil standing.conference
    end

    def test_handles_missing_division
      standing = standing_with_missing_header("Division")

      assert_nil standing.division
    end

    def test_handles_missing_losses
      standing = standing_with_missing_header("LOSSES")

      assert_nil standing.losses
    end

    def test_handles_missing_win_pct
      standing = standing_with_missing_header("WinPCT")

      assert_nil standing.win_pct
    end

    def test_handles_missing_home_record
      standing = standing_with_missing_header("HOME")

      assert_nil standing.home_record
    end

    def test_handles_missing_road_record
      standing = standing_with_missing_header("ROAD")

      assert_nil standing.road_record
    end

    def test_handles_missing_streak
      standing = standing_with_missing_header("strCurrentStreak")

      assert_nil standing.streak
    end

    def test_handles_missing_conference_record
      standing = standing_with_missing_header("ConferenceRecord")

      assert_equal 5, standing.conference_rank
    end

    def test_handles_missing_playoff_rank
      standing = standing_with_missing_header("PlayoffRank")

      assert_equal 8, standing.conference_rank
    end

    def test_handles_missing_both_conference_record_and_playoff_rank
      standing = standing_with_missing_headers(%w[ConferenceRecord PlayoffRank])

      assert_nil standing.conference_rank
    end

    private

    def standing_with_missing_header(header_to_remove)
      standing_with_missing_headers([header_to_remove])
    end

    def standing_with_missing_headers(headers_to_remove)
      headers = standings_headers.reject { |h| headers_to_remove.include?(h) }
      row = build_row_without_headers(headers_to_remove)
      stub_standings_response(headers, row)
    end

    def build_row_without_headers(headers_to_remove)
      row = standings_row.dup
      indices = headers_to_remove.map { |h| standings_headers.index(h) }.compact.sort.reverse
      indices.each { |idx| row.delete_at(idx) }
      row
    end

    def stub_standings_response(headers, row)
      response = {resultSets: [{headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguestandings/).to_return(body: response.to_json)
      Standings.all.first
    end

    def standings_headers
      %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank ConferenceRecord HOME ROAD
        strCurrentStreak]
    end

    def standings_row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "8-4", "25-12", "20-18", "W3"]
  end
end
