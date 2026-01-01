require_relative "../test_helper"

module NBA
  class ClientTest < Minitest::Test
    cover Client

    def test_default_connection_is_instance_of_connection
      client = Client.new

      assert_instance_of Connection, client.connection
    end

    def test_get_delegates_to_connection
      connection = stub_connection
      client = Client.new(connection: connection)

      result = client.get("path")

      assert_equal "response", result
      assert_equal "path", connection.called_with
    end

    StubConnection = Class.new do
      attr_reader :called_with

      def get(path)
        @called_with = path
        "response"
      end
    end

    private

    def stub_connection = StubConnection.new
  end
end
