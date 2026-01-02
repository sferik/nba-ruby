require_relative "../test_helper"

module NBA
  class PlayerInfoModelTest < Minitest::Test
    cover PlayerInfo

    def test_objects_with_same_player_id_are_equal
      info0 = PlayerInfo.new(player_id: 201_939)
      info1 = PlayerInfo.new(player_id: 201_939)

      assert_equal info0, info1
    end

    def test_objects_with_different_player_id_are_not_equal
      info0 = PlayerInfo.new(player_id: 201_939)
      info1 = PlayerInfo.new(player_id: 2544)

      refute_equal info0, info1
    end

    def test_player_returns_nil_when_player_id_is_nil
      info = PlayerInfo.new(player_id: nil)

      assert_nil info.player
    end

    def test_team_returns_nil_when_team_id_is_nil
      info = PlayerInfo.new(team_id: nil)

      assert_nil info.team
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      info = PlayerInfo.new(player_id: 201_939)
      result = info.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    def test_team_returns_team_object_when_team_id_valid
      info = PlayerInfo.new(team_id: Team::GSW)

      result = info.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_full_name_returns_display_name_when_present
      info = PlayerInfo.new(display_name: "The Chef", first_name: "Stephen", last_name: "Curry")

      assert_equal "The Chef", info.full_name
    end

    def test_full_name_returns_combined_name_when_display_name_nil
      info = PlayerInfo.new(display_name: nil, first_name: "Stephen", last_name: "Curry")

      assert_equal "Stephen Curry", info.full_name
    end

    def test_full_name_handles_missing_first_name
      info = PlayerInfo.new(display_name: nil, first_name: nil, last_name: "Curry")

      assert_equal "Curry", info.full_name
    end

    def test_full_name_handles_missing_last_name
      info = PlayerInfo.new(display_name: nil, first_name: "Stephen", last_name: nil)

      assert_equal "Stephen", info.full_name
    end

    def test_greatest_75_returns_true_when_flag_is_y
      info = PlayerInfo.new(greatest_75_flag: "Y")

      assert_predicate info, :greatest_75?
    end

    def test_greatest_75_returns_false_when_flag_is_n
      info = PlayerInfo.new(greatest_75_flag: "N")

      refute_predicate info, :greatest_75?
    end

    def test_greatest_75_returns_false_when_flag_is_nil
      info = PlayerInfo.new(greatest_75_flag: nil)

      refute_predicate info, :greatest_75?
    end

    private

    def player_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME]
      row = [201_939, "Stephen Curry", "Stephen", "Curry"]
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
