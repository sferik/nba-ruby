require_relative "../test_helper"

module NBA
  class TeamHistoricalLeaderTest < Minitest::Test
    cover TeamHistoricalLeader

    def test_equality_based_on_team_id
      leader1 = TeamHistoricalLeader.new(team_id: 1_610_612_744)
      leader2 = TeamHistoricalLeader.new(team_id: 1_610_612_744)

      assert_equal leader1, leader2
    end

    def test_inequality_based_on_different_team_id
      leader1 = TeamHistoricalLeader.new(team_id: 1_610_612_744)
      leader2 = TeamHistoricalLeader.new(team_id: 1_610_612_745)

      refute_equal leader1, leader2
    end

    def test_team_returns_team_from_teams_find
      stub_request(:get, /commonteamroster/).to_return(body: team_response.to_json)
      leader = TeamHistoricalLeader.new(team_id: 1_610_612_744)

      result = leader.team

      assert_instance_of Team, result
    end

    def test_pts_leader_returns_player_from_players_find
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      leader = TeamHistoricalLeader.new(pts_person_id: 201_939)

      result = leader.pts_leader

      assert_instance_of Player, result
    end

    def test_ast_leader_returns_player_from_players_find
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      leader = TeamHistoricalLeader.new(ast_person_id: 201_939)

      result = leader.ast_leader

      assert_instance_of Player, result
    end

    def test_reb_leader_returns_player_from_players_find
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      leader = TeamHistoricalLeader.new(reb_person_id: 201_142)

      result = leader.reb_leader

      assert_instance_of Player, result
    end

    def test_blk_leader_returns_player_from_players_find
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      leader = TeamHistoricalLeader.new(blk_person_id: 101_106)

      result = leader.blk_leader

      assert_instance_of Player, result
    end

    def test_stl_leader_returns_player_from_players_find
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      leader = TeamHistoricalLeader.new(stl_person_id: 201_939)

      result = leader.stl_leader

      assert_instance_of Player, result
    end

    private

    def team_response
      {resultSets: [{name: "CommonTeamRoster", headers: %w[TeamID PLAYER_ID], rowSet: [[1_610_612_744, 201_939]]}]}
    end

    def player_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME],
                     rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry"]]}]}
    end
  end
end
