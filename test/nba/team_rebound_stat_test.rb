require_relative "../test_helper"

module NBA
  class TeamReboundStatTest < Minitest::Test
    cover TeamReboundStat

    def test_equality_based_on_team_id_g_and_reb
      stat1 = TeamReboundStat.new(team_id: 1_610_612_744, g: 82, reb: 45.5)
      stat2 = TeamReboundStat.new(team_id: 1_610_612_744, g: 82, reb: 45.5)

      assert_equal stat1, stat2
    end

    def test_inequality_based_on_different_team_id
      stat1 = TeamReboundStat.new(team_id: 1_610_612_744, g: 82, reb: 45.5)
      stat2 = TeamReboundStat.new(team_id: 1_610_612_745, g: 82, reb: 45.5)

      refute_equal stat1, stat2
    end

    def test_inequality_based_on_different_reb
      stat1 = TeamReboundStat.new(team_id: 1_610_612_744, g: 82, reb: 45.5)
      stat2 = TeamReboundStat.new(team_id: 1_610_612_744, g: 82, reb: 50.0)

      refute_equal stat1, stat2
    end

    def test_team_returns_team_from_teams_find
      stub_request(:get, /commonteamroster/).to_return(body: team_response.to_json)
      stat = TeamReboundStat.new(team_id: 1_610_612_744)

      result = stat.team

      assert_instance_of Team, result
    end

    private

    def team_response
      {resultSets: [{name: "CommonTeamRoster", headers: %w[TeamID PLAYER_ID], rowSet: [[1_610_612_744, 201_939]]}]}
    end
  end
end
