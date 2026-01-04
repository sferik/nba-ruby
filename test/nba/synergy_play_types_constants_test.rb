require_relative "../test_helper"

module NBA
  class SynergyPlayTypesConstantsTest < Minitest::Test
    cover SynergyPlayTypes

    def test_basic_constants_defined
      assert_equal "SynergyPlayType", SynergyPlayTypes::SYNERGY_PLAY_TYPE
      assert_equal "Regular Season", SynergyPlayTypes::REGULAR_SEASON
      assert_equal "Playoffs", SynergyPlayTypes::PLAYOFFS
      assert_equal "offensive", SynergyPlayTypes::OFFENSIVE
      assert_equal "defensive", SynergyPlayTypes::DEFENSIVE
    end

    def test_per_mode_constants_defined
      assert_equal "PerGame", SynergyPlayTypes::PER_GAME
      assert_equal "Totals", SynergyPlayTypes::TOTALS
    end

    def test_play_type_constants_defined
      assert_equal "Isolation", SynergyPlayTypes::ISOLATION
      assert_equal "Transition", SynergyPlayTypes::TRANSITION
      assert_equal "PRBallHandler", SynergyPlayTypes::PICK_AND_ROLL_BALL_HANDLER
      assert_equal "PRRollman", SynergyPlayTypes::PICK_AND_ROLL_ROLL_MAN
      assert_equal "Postup", SynergyPlayTypes::POST_UP
    end

    def test_additional_play_type_constants_defined
      assert_equal "Spotup", SynergyPlayTypes::SPOT_UP
      assert_equal "Handoff", SynergyPlayTypes::HANDOFF
      assert_equal "Cut", SynergyPlayTypes::CUT
      assert_equal "OffScreen", SynergyPlayTypes::OFF_SCREEN
      assert_equal "OffRebound", SynergyPlayTypes::PUTBACKS
    end

    def test_miscellaneous_constant_defined
      assert_equal "Misc", SynergyPlayTypes::MISCELLANEOUS
    end
  end
end
