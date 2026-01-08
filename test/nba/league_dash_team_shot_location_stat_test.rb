require_relative "../test_helper"

module NBA
  class LeagueDashTeamShotLocationStatTest < Minitest::Test
    cover LeagueDashTeamShotLocationStat

    def test_equality_based_on_team_id
      stat1 = LeagueDashTeamShotLocationStat.new(team_id: Team::GSW)
      stat2 = LeagueDashTeamShotLocationStat.new(team_id: Team::GSW)

      assert_equal stat1, stat2
    end

    def test_inequality_when_team_id_differs
      stat1 = LeagueDashTeamShotLocationStat.new(team_id: Team::GSW)
      stat2 = LeagueDashTeamShotLocationStat.new(team_id: Team::LAL)

      refute_equal stat1, stat2
    end

    def test_team_lazy_hydration
      stub_request(:get, /commonteaminfo/).to_return(body: team_response.to_json)
      stat = LeagueDashTeamShotLocationStat.new(team_id: Team::GSW)

      team = stat.team

      assert_equal Team::GSW, team.id
    end

    private

    def team_response
      {resultSets: [{name: "TeamInfoCommon",
                     headers: %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY TEAM_CONFERENCE
                       TEAM_DIVISION],
                     rowSet: [[Team::GSW, "Warriors", "GSW", "Golden State", "West", "Pacific"]]}]}
    end
  end
end
