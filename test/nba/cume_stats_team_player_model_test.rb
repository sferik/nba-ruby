require_relative "../test_helper"

module NBA
  class CumeStatsTeamPlayerModelTest < Minitest::Test
    cover CumeStatsTeamPlayer

    def test_objects_with_same_person_id_are_equal
      player0 = CumeStatsTeamPlayer.new(person_id: 201_939)
      player1 = CumeStatsTeamPlayer.new(person_id: 201_939)

      assert_equal player0, player1
    end

    def test_objects_with_different_person_id_are_not_equal
      player0 = CumeStatsTeamPlayer.new(person_id: 201_939)
      player1 = CumeStatsTeamPlayer.new(person_id: 2544)

      refute_equal player0, player1
    end

    def test_player_returns_nil_when_person_id_is_nil
      player = CumeStatsTeamPlayer.new(person_id: nil)

      assert_nil player.player
    end

    def test_team_returns_nil_when_team_id_is_nil
      player = CumeStatsTeamPlayer.new(team_id: nil)

      assert_nil player.team
    end

    def test_player_returns_player_object_when_person_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      player = CumeStatsTeamPlayer.new(person_id: 201_939)
      result = player.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_team_object_when_team_id_valid
      player = CumeStatsTeamPlayer.new(team_id: Team::GSW)

      result = player.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    private

    def player_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME]
      row = [201_939, "Stephen Curry", "Stephen", "Curry"]
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
