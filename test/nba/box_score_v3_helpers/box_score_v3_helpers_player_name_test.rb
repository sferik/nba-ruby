require_relative "../../test_helper"

module NBA
  class BoxScoreV3HelpersPlayerNameTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_build_player_name_with_both_names
      player = {"firstName" => "Stephen", "familyName" => "Curry"}

      assert_equal "Stephen Curry", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_missing_first_name_key
      player = {"familyName" => "Curry"}

      assert_equal "Curry", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_missing_family_name_key
      player = {"firstName" => "Stephen"}

      assert_equal "Stephen", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_missing_both_name_keys
      assert_equal "", BoxScoreV3Helpers.build_player_name({})
    end

    def test_build_player_name_with_nil_first_name
      player = {"firstName" => nil, "familyName" => "Curry"}

      assert_equal "Curry", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_nil_family_name
      player = {"firstName" => "Stephen", "familyName" => nil}

      assert_equal "Stephen", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_empty_first_name
      player = {"firstName" => "", "familyName" => "Curry"}

      assert_equal "Curry", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_empty_family_name
      player = {"firstName" => "Stephen", "familyName" => ""}

      assert_equal "Stephen", BoxScoreV3Helpers.build_player_name(player)
    end

    def test_build_player_name_with_both_empty_names
      player = {"firstName" => "", "familyName" => ""}

      assert_equal "", BoxScoreV3Helpers.build_player_name(player)
    end
  end
end
