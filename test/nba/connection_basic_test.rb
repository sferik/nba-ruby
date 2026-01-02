require_relative "../test_helper"

module NBA
  class ConnectionTest < Minitest::Test
    cover Connection

    def test_default_base_url_is_nba_stats_api
      connection = Connection.new

      assert_equal "https://stats.nba.com/stats/", connection.base_url
    end

    def test_get_makes_http_request
      connection = Connection.new(base_url: "https://stats.nba.com/")
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: '{"teams":[]}', headers: {})

      response = connection.get("teams")

      assert_equal '{"teams":[]}', response
    end

    def test_get_uses_ssl_for_https_urls
      connection = Connection.new(base_url: "https://stats.nba.com/")
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: "{}", headers: {})

      connection.get("teams")

      assert_requested(:get, "https://stats.nba.com/teams")
    end

    def test_get_does_not_use_ssl_for_http_urls
      connection = Connection.new(base_url: "http://example.com/")
      stub_request(:get, "http://example.com/teams")
        .to_return(status: 200, body: "{}", headers: {})

      connection.get("teams")

      assert_requested(:get, "http://example.com/teams")
    end

    def test_get_requests_correct_path
      connection = Connection.new(base_url: "https://stats.nba.com/stats/")
      stub_request(:get, "https://stats.nba.com/stats/commonallplayers")
        .to_return(status: 200, body: "{}", headers: {})

      connection.get("commonallplayers")

      assert_requested(:get, "https://stats.nba.com/stats/commonallplayers")
    end

    def test_get_uses_correct_port_for_https
      connection = Connection.new(base_url: "https://stats.nba.com:443/")
      stub_request(:get, "https://stats.nba.com:443/teams")
        .to_return(status: 200, body: "{}", headers: {})

      connection.get("teams")

      assert_requested(:get, "https://stats.nba.com:443/teams")
    end

    def test_get_uses_correct_hostname
      connection = Connection.new(base_url: "https://api.nba.com/")
      stub_request(:get, "https://api.nba.com/teams")
        .to_return(status: 200, body: "{}", headers: {})

      connection.get("teams")

      assert_requested(:get, "https://api.nba.com/teams")
    end

    def test_get_uses_nonstandard_port
      connection = Connection.new(base_url: "https://stats.nba.com:8443/")
      stub_request(:get, "https://stats.nba.com:8443/teams")
        .to_return(status: 200, body: "{}", headers: {})

      connection.get("teams")

      assert_requested(:get, "https://stats.nba.com:8443/teams")
    end
  end
end
