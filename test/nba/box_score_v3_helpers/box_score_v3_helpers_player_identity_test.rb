require_relative "../../test_helper"

module NBA
  class BoxScoreV3HelpersPlayerIdentityTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_player_identity_with_all_keys
      player = {"teamId" => 1_610_612_744, "teamTricode" => "GSW",
                "teamCity" => "Golden State", "personId" => 201_939,
                "firstName" => "Stephen", "familyName" => "Curry",
                "position" => "G", "comment" => "DNP - Rest"}

      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_equal "0022400001", identity[:game_id]
      assert_equal 1_610_612_744, identity[:team_id]
      assert_equal "GSW", identity[:team_abbreviation]
      assert_equal "Golden State", identity[:team_city]
      assert_equal 201_939, identity[:player_id]
    end

    def test_player_identity_parses_name_and_position
      player = {"firstName" => "Stephen", "familyName" => "Curry",
                "position" => "G", "comment" => "DNP - Rest"}

      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_equal "Stephen Curry", identity[:player_name]
      assert_equal "G", identity[:start_position]
      assert_equal "DNP - Rest", identity[:comment]
    end

    def test_player_identity_with_missing_team_id_key
      player = {"firstName" => "Stephen", "familyName" => "Curry"}
      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_nil identity[:team_id]
    end

    def test_player_identity_with_missing_team_tricode_key
      player = {"firstName" => "Stephen", "familyName" => "Curry"}
      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_nil identity[:team_abbreviation]
    end

    def test_player_identity_with_missing_team_city_key
      player = {"firstName" => "Stephen", "familyName" => "Curry"}
      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_nil identity[:team_city]
    end

    def test_player_identity_with_missing_person_id_key
      player = {"firstName" => "Stephen", "familyName" => "Curry"}
      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_nil identity[:player_id]
    end

    def test_player_identity_with_missing_position_key
      player = {"firstName" => "Stephen", "familyName" => "Curry"}
      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_nil identity[:start_position]
    end

    def test_player_identity_with_missing_comment_key
      player = {"firstName" => "Stephen", "familyName" => "Curry"}
      identity = BoxScoreV3Helpers.player_identity(player, "0022400001")

      assert_nil identity[:comment]
    end
  end
end
