require_relative "../test_helper"

module NBA
  class TeamOnOffOverallStatTest < Minitest::Test
    cover TeamOnOffOverallStat

    def test_group_set
      stat = TeamOnOffOverallStat.new(group_set: "Overall")

      assert_equal "Overall", stat.group_set
    end

    def test_group_value
      stat = TeamOnOffOverallStat.new(group_value: "On Court")

      assert_equal "On Court", stat.group_value
    end

    def test_team_id
      stat = TeamOnOffOverallStat.new(team_id: 1_610_612_744)

      assert_equal 1_610_612_744, stat.team_id
    end

    def test_team_abbreviation
      stat = TeamOnOffOverallStat.new(team_abbreviation: "GSW")

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_team_name
      stat = TeamOnOffOverallStat.new(team_name: "Warriors")

      assert_equal "Warriors", stat.team_name
    end

    def test_gp
      stat = TeamOnOffOverallStat.new(gp: 82)

      assert_equal 82, stat.gp
    end

    def test_w
      stat = TeamOnOffOverallStat.new(w: 46)

      assert_equal 46, stat.w
    end

    def test_l
      stat = TeamOnOffOverallStat.new(l: 36)

      assert_equal 36, stat.l
    end

    def test_w_pct
      stat = TeamOnOffOverallStat.new(w_pct: 0.561)

      assert_in_delta 0.561, stat.w_pct
    end

    def test_min
      stat = TeamOnOffOverallStat.new(min: 240.0)

      assert_in_delta 240.0, stat.min
    end

    def test_pts
      stat = TeamOnOffOverallStat.new(pts: 111.8)

      assert_in_delta 111.8, stat.pts
    end

    def test_plus_minus
      stat = TeamOnOffOverallStat.new(plus_minus: 2.5)

      assert_in_delta 2.5, stat.plus_minus
    end

    def test_pts_rank
      stat = TeamOnOffOverallStat.new(pts_rank: 2)

      assert_equal 2, stat.pts_rank
    end

    def test_plus_minus_rank
      stat = TeamOnOffOverallStat.new(plus_minus_rank: 6)

      assert_equal 6, stat.plus_minus_rank
    end

    def test_team_returns_team_object
      stub_request(:get, /commonteamroster/).to_return(body: team_response.to_json)

      stat = TeamOnOffOverallStat.new(team_id: 1_610_612_744)
      result = stat.team

      assert_kind_of Team, result
    end

    def test_equality_by_team_id_and_group_value
      stat1 = TeamOnOffOverallStat.new(team_id: 1, group_value: "On")
      stat2 = TeamOnOffOverallStat.new(team_id: 1, group_value: "On")

      assert_equal stat1, stat2
    end

    def test_inequality_by_different_group_value
      stat1 = TeamOnOffOverallStat.new(team_id: 1, group_value: "On")
      stat2 = TeamOnOffOverallStat.new(team_id: 1, group_value: "Off")

      refute_equal stat1, stat2
    end

    private

    def team_response
      {resultSets: [{name: "CommonTeamRoster", headers: ["TEAM_ID"], rowSet: [[1_610_612_744]]}]}
    end
  end
end
