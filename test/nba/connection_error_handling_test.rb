require_relative "../test_helper"

module NBA
  class ConnectionErrorHandlingTest < Minitest::Test
    cover Connection

    def test_get_raises_argument_error_for_uri_without_hostname
      mock_uri = Minitest::Mock.new
      mock_uri.expect(:hostname, nil)
      mock_uri.expect(:to_s, "invalid://uri")

      URI.stub(:join, mock_uri) do
        connection = Connection.new
        error = assert_raises(ArgumentError) { connection.get("test") }
        assert_equal "Invalid URI: invalid://uri", error.message
      end

      mock_uri.verify
    end

    def test_get_returns_nil_for_500_error
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 500, body: "System.Net.WebException: Error", headers: {})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_nil response
    end

    def test_get_returns_nil_for_404_error
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 404, body: "Not Found", headers: {})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_nil response
    end

    def test_get_returns_nil_for_503_error
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 503, body: "Service Unavailable", headers: {})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_nil response
    end

    def test_get_returns_body_for_200_response
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: '{"data":"test"}', headers: {})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_equal '{"data":"test"}', response
    end
  end
end
