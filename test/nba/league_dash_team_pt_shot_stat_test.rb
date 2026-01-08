require_relative "../test_helper"

module NBA
  class LeagueDashTeamPtShotStatTest < Minitest::Test
    cover LeagueDashTeamPtShotStat

    def test_equality_based_on_team_id_and_g
      stat1 = LeagueDashTeamPtShotStat.new(team_id: Team::GSW, g: 82)
      stat2 = LeagueDashTeamPtShotStat.new(team_id: Team::GSW, g: 82)

      assert_equal stat1, stat2
    end

    def test_inequality_with_different_team_id
      stat1 = LeagueDashTeamPtShotStat.new(team_id: Team::GSW, g: 82)
      stat2 = LeagueDashTeamPtShotStat.new(team_id: Team::LAL, g: 82)

      refute_equal stat1, stat2
    end

    def test_inequality_with_different_g
      stat1 = LeagueDashTeamPtShotStat.new(team_id: Team::GSW, g: 82)
      stat2 = LeagueDashTeamPtShotStat.new(team_id: Team::GSW, g: 74)

      refute_equal stat1, stat2
    end

    def test_team_returns_team_object
      stat = LeagueDashTeamPtShotStat.new(team_id: Team::GSW)
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
