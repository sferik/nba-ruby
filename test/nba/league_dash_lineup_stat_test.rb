require_relative "../test_helper"

module NBA
  class LeagueDashLineupStatTest < Minitest::Test
    cover LeagueDashLineupStat

    def test_equality_based_on_group_id_and_team_id
      stat1 = LeagueDashLineupStat.new(group_id: "201939-203110", team_id: Team::GSW)
      stat2 = LeagueDashLineupStat.new(group_id: "201939-203110", team_id: Team::GSW)

      assert_equal stat1, stat2
    end

    def test_inequality_with_different_group_id
      stat1 = LeagueDashLineupStat.new(group_id: "201939-203110", team_id: Team::GSW)
      stat2 = LeagueDashLineupStat.new(group_id: "201939-1628369", team_id: Team::GSW)

      refute_equal stat1, stat2
    end

    def test_inequality_with_different_team_id
      stat1 = LeagueDashLineupStat.new(group_id: "201939-203110", team_id: Team::GSW)
      stat2 = LeagueDashLineupStat.new(group_id: "201939-203110", team_id: Team::LAL)

      refute_equal stat1, stat2
    end

    def test_team_returns_team_object
      stat = LeagueDashLineupStat.new(team_id: Team::GSW)
      stub_request(:get, /teamdetails/).to_return(body: team_response.to_json)

      assert_instance_of Team, stat.team
    end

    private

    def team_response
      {resultSets: [{name: "TeamBackground",
                     headers: %w[TEAM_ID ABBREVIATION NICKNAME CITY ARENA],
                     rowSet: [[Team::GSW, "GSW", "Warriors", "Golden State", "Chase Center"]]}]}
    end
  end
end
