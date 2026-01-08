require_relative "../test_helper"

module NBA
  class TeamOnOffPlayerStatTest < Minitest::Test
    cover TeamOnOffPlayerStat

    def test_group_set
      stat = TeamOnOffPlayerStat.new(group_set: "Off")

      assert_equal "Off", stat.group_set
    end

    def test_team_id
      stat = TeamOnOffPlayerStat.new(team_id: 1_610_612_744)

      assert_equal 1_610_612_744, stat.team_id
    end

    def test_team_abbreviation
      stat = TeamOnOffPlayerStat.new(team_abbreviation: "GSW")

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_team_name
      stat = TeamOnOffPlayerStat.new(team_name: "Warriors")

      assert_equal "Warriors", stat.team_name
    end

    def test_vs_player_id
      stat = TeamOnOffPlayerStat.new(vs_player_id: 201_566)

      assert_equal 201_566, stat.vs_player_id
    end

    def test_vs_player_name
      stat = TeamOnOffPlayerStat.new(vs_player_name: "Russell Westbrook")

      assert_equal "Russell Westbrook", stat.vs_player_name
    end

    def test_court_status
      stat = TeamOnOffPlayerStat.new(court_status: "On")

      assert_equal "On", stat.court_status
    end

    def test_gp
      stat = TeamOnOffPlayerStat.new(gp: 82)

      assert_equal 82, stat.gp
    end

    def test_pts
      stat = TeamOnOffPlayerStat.new(pts: 111.8)

      assert_in_delta 111.8, stat.pts
    end

    def test_plus_minus
      stat = TeamOnOffPlayerStat.new(plus_minus: 2.5)

      assert_in_delta 2.5, stat.plus_minus
    end

    def test_pts_rank
      stat = TeamOnOffPlayerStat.new(pts_rank: 2)

      assert_equal 2, stat.pts_rank
    end

    def test_team_returns_team_object
      stub_request(:get, /commonteamroster/).to_return(body: team_response.to_json)

      stat = TeamOnOffPlayerStat.new(team_id: 1_610_612_744)
      result = stat.team

      assert_kind_of Team, result
    end

    def test_vs_player_returns_player_object
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      stat = TeamOnOffPlayerStat.new(vs_player_id: 201_566)
      result = stat.vs_player

      assert_kind_of Player, result
    end

    def test_on_court_returns_true_when_status_is_on
      stat = TeamOnOffPlayerStat.new(court_status: "On")

      assert_predicate stat, :on_court?
    end

    def test_on_court_returns_false_when_status_is_off
      stat = TeamOnOffPlayerStat.new(court_status: "Off")

      refute_predicate stat, :on_court?
    end

    def test_off_court_returns_true_when_status_is_off
      stat = TeamOnOffPlayerStat.new(court_status: "Off")

      assert_predicate stat, :off_court?
    end

    def test_off_court_returns_false_when_status_is_on
      stat = TeamOnOffPlayerStat.new(court_status: "On")

      refute_predicate stat, :off_court?
    end

    def test_equality_by_team_id_vs_player_id_and_court_status
      stat1 = TeamOnOffPlayerStat.new(team_id: 1, vs_player_id: 2, court_status: "On")
      stat2 = TeamOnOffPlayerStat.new(team_id: 1, vs_player_id: 2, court_status: "On")

      assert_equal stat1, stat2
    end

    def test_inequality_by_different_court_status
      stat1 = TeamOnOffPlayerStat.new(team_id: 1, vs_player_id: 2, court_status: "On")
      stat2 = TeamOnOffPlayerStat.new(team_id: 1, vs_player_id: 2, court_status: "Off")

      refute_equal stat1, stat2
    end

    private

    def team_response
      {resultSets: [{name: "CommonTeamRoster", headers: ["TEAM_ID"], rowSet: [[1_610_612_744]]}]}
    end

    def player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: ["PERSON_ID"], rowSet: [[201_566]]}]}
    end
  end
end
