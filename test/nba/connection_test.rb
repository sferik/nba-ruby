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

  class ConnectionHeadersTest < Minitest::Test
    cover Connection

    def test_get_sets_user_agent_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"User-Agent" => /Mozilla/})
    end

    def test_get_sets_accept_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Accept" => %r{application/json}})
    end

    def test_get_sets_referer_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Referer" => "https://www.nba.com/"})
    end

    def test_get_sets_accept_language_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Accept-Language" => "en-US,en;q=0.9"})
    end

    def test_get_sets_accept_encoding_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Accept-Encoding" => "gzip, deflate, identity"})
    end

    def test_get_sets_connection_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Connection" => "keep-alive"})
    end

    def test_get_sets_origin_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Origin" => "https://www.nba.com"})
    end

    private

    def stub_stats_request
      stub_request(:get, "https://stats.nba.com/teams").to_return(status: 200, body: "{}", headers: {})
    end
  end

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

  class ConnectionDecodingTest < Minitest::Test
    cover Connection

    def test_get_decodes_gzip_response
      gzip_body = gzip_compress('{"data":"test"}')
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: gzip_body, headers: {"Content-Encoding" => "gzip"})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_equal '{"data":"test"}', response
    end

    def test_get_decodes_deflate_response
      deflate_body = Zlib::Deflate.deflate('{"data":"deflated"}')
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: deflate_body, headers: {"Content-Encoding" => "deflate"})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_equal '{"data":"deflated"}', response
    end

    def test_get_returns_uncompressed_body_without_encoding_header
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: '{"data":"plain"}', headers: {})

      response = Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_equal '{"data":"plain"}', response
    end

    private

    def gzip_compress(string)
      io = StringIO.new
      gz = Zlib::GzipWriter.new(io)
      gz.write(string)
      gz.close
      io.string
    end
  end
end
