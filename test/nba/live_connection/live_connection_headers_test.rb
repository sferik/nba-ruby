require_relative "../../test_helper"

module NBA
  class LiveConnectionHeadersTest < Minitest::Test
    cover LiveConnection

    def test_sets_user_agent_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"User-Agent" => /Mozilla.*Chrome.*Safari/})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_sets_accept_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"Accept" => "application/json, text/plain, */*"})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_sets_accept_language_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"Accept-Language" => "en-US,en;q=0.9"})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_sets_accept_encoding_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"Accept-Encoding" => "gzip, deflate, identity"})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_sets_connection_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"Connection" => "keep-alive"})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_sets_referer_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"Referer" => "https://www.nba.com/"})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_sets_origin_header
      stub = stub_request(:get, /cdn.nba.com/)
        .with(headers: {"Origin" => "https://www.nba.com"})
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_uses_https_scheme
      stub = stub_request(:get, "https://cdn.nba.com/static/json/liveData/secure.json")
        .to_return(body: "{}")

      LiveConnection.new.get("secure.json")

      assert_requested stub
    end

    def test_uses_correct_hostname
      stub = stub_request(:get, "https://cdn.nba.com/static/json/liveData/test.json")
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_uses_correct_port
      stub = stub_request(:get, "https://cdn.nba.com:443/static/json/liveData/test.json")
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_uses_custom_base_url
      stub = stub_request(:get, "https://example.com/api/data.json")
        .to_return(body: "{}")

      LiveConnection.new(base_url: "https://example.com/api/").get("data.json")

      assert_requested stub
    end

    def test_joins_base_url_and_path
      stub = stub_request(:get, "https://cdn.nba.com/static/json/liveData/path/to/resource.json")
        .to_return(body: "{}")

      LiveConnection.new.get("path/to/resource.json")

      assert_requested stub
    end

    def test_uses_http_scheme_when_base_url_is_http
      stub = stub_request(:get, "http://localhost/api/test.json")
        .to_return(body: "{}")

      LiveConnection.new(base_url: "http://localhost/api/").get("test.json")

      assert_requested stub
    end

    def test_uses_custom_port_from_base_url
      stub = stub_request(:get, "https://localhost:8443/api/test.json")
        .to_return(body: "{}")

      LiveConnection.new(base_url: "https://localhost:8443/api/").get("test.json")

      assert_requested stub
    end
  end
end
