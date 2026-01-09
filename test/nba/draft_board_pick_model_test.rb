require_relative "../test_helper"

module NBA
  class DraftBoardPickModelTest < Minitest::Test
    cover DraftBoardPick

    def test_objects_with_same_person_id_are_equal
      pick0 = DraftBoardPick.new(person_id: 1_630_162)
      pick1 = DraftBoardPick.new(person_id: 1_630_162)

      assert_equal pick0, pick1
    end

    def test_objects_with_different_person_id_are_not_equal
      pick0 = DraftBoardPick.new(person_id: 1_630_162)
      pick1 = DraftBoardPick.new(person_id: 1_630_163)

      refute_equal pick0, pick1
    end

    def test_player_returns_nil_when_person_id_is_nil
      pick = DraftBoardPick.new(person_id: nil)

      assert_nil pick.player
    end

    def test_player_returns_player_object_when_person_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      pick = DraftBoardPick.new(person_id: 1_630_162)
      player = pick.player

      assert_instance_of Player, player
      assert_equal 1_630_162, player.id
    end

    def test_player_uses_person_id_attribute
      stub_request(:get, /commonplayerinfo\?PlayerID=1630162/).to_return(body: player_response.to_json)

      pick = DraftBoardPick.new(person_id: 1_630_162)
      pick.player

      assert_requested :get, /PlayerID=1630162/
    end

    def test_team_returns_nil_when_team_id_is_nil
      pick = DraftBoardPick.new(team_id: nil)

      assert_nil pick.team
    end

    def test_team_returns_team_object_when_team_id_valid
      pick = DraftBoardPick.new(team_id: Team::SAS)
      team = pick.team

      assert_instance_of Team, team
      assert_equal Team::SAS, team.id
    end

    def test_team_uses_team_id_attribute
      pick = DraftBoardPick.new(team_id: Team::SAS)

      assert_equal Team::SAS, pick.team.id
    end

    private

    def player_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME]
      row = [1_630_162, "Victor Wembanyama", "Victor", "Wembanyama"]
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
