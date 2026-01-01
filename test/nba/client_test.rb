require_relative "../test_helper"

module NBA
  class ClientTest < Minitest::Test
    cover Client

    def test_default_connection_is_instance_of_connection
      client = Client.new

      assert_instance_of Connection, client.connection
    end

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
