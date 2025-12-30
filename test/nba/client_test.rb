require_relative "../test_helper"

module NBA
  class ClientTest < Minitest::Test
    cover Client

    def test_get_delegates_to_connection
      connection = Minitest::Mock.new
      connection.expect(:get, "response", ["path"])
      client = Client.new(connection: connection)

      result = client.get("path")

      assert_equal "response", result
      connection.verify
    end
  end
end
