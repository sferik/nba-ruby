require_relative "../../test_helper"

module NBA
  class PlayersFindNilIdTest < Minitest::Test
    cover Players

    def test_find_returns_nil_when_player_id_is_nil
      assert_nil Players.find(nil)
    end

    def test_find_does_not_make_api_call_when_player_id_is_nil
      mock_client = Minitest::Mock.new

      Players.find(nil, client: mock_client)

      mock_client.verify
    end
  end
end
