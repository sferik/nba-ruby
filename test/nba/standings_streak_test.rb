require_relative "../test_helper"

module NBA
  class StandingsStreakTest < Minitest::Test
    cover Standings

    def test_format_streak_handles_nil
      stub_standings_with(streak: nil)

      assert_nil Standings.all.first.streak
    end

    def test_format_streak_converts_integer_to_string
      stub_standings_with(streak: 5)

      streak = Standings.all.first.streak

      assert_instance_of String, streak
      assert_equal "5", streak
    end

    def test_format_streak_returns_string_representation
      stub_standings_with(streak: "W5")

      streak = Standings.all.first.streak

      assert_equal "W5", streak
      assert_instance_of String, streak
    end

    private

    def stub_standings_with(streak:)
      headers = standings_headers
      row = [Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", streak]
      stub_request(:get, /leaguestandings/).to_return(body: {resultSets: [{headers: headers, rowSet: [row]}]}.to_json)
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]
  end
end
