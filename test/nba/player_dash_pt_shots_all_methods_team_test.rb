require_relative "../test_helper"

module NBA
  class PlayerDashPtShotsAllMethodsTeamTest < Minitest::Test
    cover PlayerDashPtShots

    def test_general_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshots.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.general(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_dribble_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshots.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.dribble(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_touch_time_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshots.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.touch_time(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_shot_clock_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshots.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.shot_clock(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_closest_defender_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshots.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_closest_defender_10ft_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshots.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender_10ft(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    private

    def empty_response
      {resultSets: [{name: "Overall", headers: [], rowSet: []}]}
    end
  end
end
