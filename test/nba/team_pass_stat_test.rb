require_relative "../test_helper"

module NBA
  class TeamPassStatTest < Minitest::Test
    cover TeamPassStat

    def test_equality_based_on_team_id_and_pass_teammate_player_id
      stat1 = TeamPassStat.new(team_id: 1_610_612_744, pass_teammate_player_id: 201_939)
      stat2 = TeamPassStat.new(team_id: 1_610_612_744, pass_teammate_player_id: 201_939)

      assert_equal stat1, stat2
    end

    def test_inequality_based_on_different_team_id
      stat1 = TeamPassStat.new(team_id: 1_610_612_744, pass_teammate_player_id: 201_939)
      stat2 = TeamPassStat.new(team_id: 1_610_612_745, pass_teammate_player_id: 201_939)

      refute_equal stat1, stat2
    end

    def test_inequality_based_on_different_pass_teammate_player_id
      stat1 = TeamPassStat.new(team_id: 1_610_612_744, pass_teammate_player_id: 201_939)
      stat2 = TeamPassStat.new(team_id: 1_610_612_744, pass_teammate_player_id: 202_691)

      refute_equal stat1, stat2
    end

    def test_teammate_returns_player_from_players_find
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = TeamPassStat.new(pass_teammate_player_id: 201_939)

      result = stat.teammate

      assert_instance_of Player, result
    end

    def test_team_returns_team_from_teams_find
      stub_request(:get, /commonteamroster/).to_return(body: team_response.to_json)
      stat = TeamPassStat.new(team_id: 1_610_612_744)

      result = stat.team

      assert_instance_of Team, result
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST], rowSet: [[201_939, "Stephen Curry"]]}]}
    end

    def team_response
      {resultSets: [{name: "CommonTeamRoster", headers: %w[TeamID PLAYER_ID], rowSet: [[1_610_612_744, 201_939]]}]}
    end
  end
end
