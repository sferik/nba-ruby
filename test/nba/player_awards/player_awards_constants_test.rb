require_relative "../../test_helper"

module NBA
  class PlayerAwardsConstantsTest < Minitest::Test
    cover PlayerAwards

    def test_player_awards_constant
      assert_equal "PlayerAwards", PlayerAwards::PLAYER_AWARDS
    end
  end
end
