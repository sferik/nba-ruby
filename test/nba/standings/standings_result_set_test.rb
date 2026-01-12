require_relative "../../test_helper"

module NBA
  class StandingsResultSetTest < Minitest::Test
    cover Standings

    def test_standings_uses_first_result_set
      response = {resultSets: [first_result_set, {headers: %w[OTHER], rowSet: [["other"]]}]}
      stub_request(:get, /leaguestandings/).to_return(body: response.to_json)

      standing = Standings.all.first

      assert_equal "Golden State Warriors", standing.team_name
    end

    private

    def first_result_set
      {headers: standings_headers, rowSet: [[Team::GSW, "Golden State Warriors", "West", "Pacific", 45, 30, 0.600, 5, "25-12", "20-18", "W3"]]}
    end

    def standings_headers = %w[TeamID TeamName Conference Division WINS LOSSES WinPCT PlayoffRank HOME ROAD strCurrentStreak]
  end
end
