require_relative "../../test_helper"

module NBA
  class CommonPlayerInfoConstantsTest < Minitest::Test
    cover CommonPlayerInfo

    def test_common_player_info_constant
      assert_equal "CommonPlayerInfo", CommonPlayerInfo::COMMON_PLAYER_INFO
    end
  end
end
