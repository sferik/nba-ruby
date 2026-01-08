require_relative "../test_helper"

module NBA
  class TeamShotStatMoreTest < Minitest::Test
    cover TeamShotStat

    def test_has_fg3m_attribute
      stat = TeamShotStat.new(fg3m: 4.8)

      assert_in_delta 4.8, stat.fg3m
    end

    def test_has_fg3a_attribute
      stat = TeamShotStat.new(fg3a: 11.2)

      assert_in_delta 11.2, stat.fg3a
    end

    def test_has_fg3_pct_attribute
      stat = TeamShotStat.new(fg3_pct: 0.428)

      assert_in_delta 0.428, stat.fg3_pct
    end

    def test_team_returns_team_object
      stub_request(:get, /commonteaminfo/).to_return(body: team_info_response.to_json)
      stat = TeamShotStat.new(team_id: 1_610_612_744)

      result = stat.team

      assert_kind_of Team, result
    end

    def test_equality_based_on_team_id_shot_type_and_g
      stat1 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Catch and Shoot", g: 82)
      stat2 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Catch and Shoot", g: 82)

      assert_equal stat1, stat2
    end

    def test_inequality_when_team_id_differs
      stat1 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Catch and Shoot", g: 82)
      stat2 = TeamShotStat.new(team_id: 1_610_612_745, shot_type: "Catch and Shoot", g: 82)

      refute_equal stat1, stat2
    end

    def test_inequality_when_shot_type_differs
      stat1 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Catch and Shoot", g: 82)
      stat2 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Pull Up", g: 82)

      refute_equal stat1, stat2
    end

    def test_inequality_when_g_differs
      stat1 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Catch and Shoot", g: 82)
      stat2 = TeamShotStat.new(team_id: 1_610_612_744, shot_type: "Catch and Shoot", g: 81)

      refute_equal stat1, stat2
    end

    private

    def team_info_response
      {resultSets: [{name: "TeamInfoCommon", headers: %w[TEAM_ID TEAM_NAME],
                     rowSet: [[1_610_612_744, "Golden State Warriors"]]}]}
    end
  end
end
