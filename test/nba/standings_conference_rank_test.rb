require_relative "../test_helper"

module NBA
  class StandingsConferenceRankTest < Minitest::Test
    cover Standings

    def test_parse_conference_rank_uses_conference_record
      stub_standings_with(conference_record: "10-5")

      assert_equal 10, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_uses_playoff_rank_when_no_conference_record
      stub_standings_with(conference_record: nil)

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_uses_playoff_rank_when_empty_split
      stub_standings_with(conference_record: "")

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_handles_integer_conference_record
      stub_standings_with(conference_record: 10)

      assert_equal 10, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_returns_integer
      stub_standings_with(conference_record: "8-5")

      assert_instance_of Integer, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_parses_wins_not_losses
      stub_standings_with(conference_record: "7-10")

      assert_equal 7, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_splits_on_hyphen
      stub_standings_with(conference_record: "12-8")

      assert_equal 12, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_handles_malformed_record
      stub_standings_with(conference_record: "-")

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_handles_leading_hyphen
      stub_standings_with(conference_record: "-5")

      assert_equal 5, Standings.all.first.conference_rank
    end

    def test_conference_rank_is_integer_type
      stub_standings_with(conference_record: "10-5")

      assert_instance_of Integer, Standings.all.first.conference_rank
    end

    def test_parse_conference_rank_returns_integer_directly
      result = Standings.send(:parse_conference_rank, "10-5", 1)

      assert_instance_of Integer, result
    end

    def test_parse_conference_rank_converts_string_wins_to_integer
      result = Standings.send(:parse_conference_rank, "7-3", 1)

      assert_equal 7, result
      refute_equal "7", result
    end

    def test_parse_conference_rank_handles_wins_with_trailing_chars
      result = Standings.send(:parse_conference_rank, "10W-5", 1)

      assert_equal 10, result
    end

    private

    def stub_standings_with(conference_record:)
      headers = standings_headers
      row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]
      unless conference_record == :default
        headers += ["ConferenceRecord"]
        row += [conference_record]
      end
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: headers, rowSet: [row]}]}.to_json)
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]
  end
end
