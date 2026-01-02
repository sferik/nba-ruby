require_relative "../test_helper"

module NBA
  class ConnectionErrorHandlingTest < Minitest::Test
    cover Connection

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
