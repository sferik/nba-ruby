require_relative "../test_helper"

module NBA
  class LiveConnectionTest < Minitest::Test
    cover LiveConnection

    def test_get_raises_argument_error_for_uri_without_hostname
      mock_uri = Minitest::Mock.new
      mock_uri.expect(:hostname, nil)
      mock_uri.expect(:to_s, "invalid://uri")

      URI.stub(:join, mock_uri) do
        connection = LiveConnection.new
        error = assert_raises(ArgumentError) { connection.get("test") }
        assert_equal "Invalid URI: invalid://uri", error.message
      end

      mock_uri.verify
    end

    def test_default_base_url
      connection = LiveConnection.new

      assert_equal "https://cdn.nba.com/static/json/liveData/", connection.base_url
    end

    def test_custom_base_url
      connection = LiveConnection.new(base_url: "https://example.com/")

      assert_equal "https://example.com/", connection.base_url
    end

    def test_get_makes_request_to_correct_url
      stub_request(:get, "https://cdn.nba.com/static/json/liveData/test/path.json")
        .to_return(body: '{"data": "test"}')

      connection = LiveConnection.new
      result = connection.get("test/path.json")

      assert_equal '{"data": "test"}', result
    end

    def test_get_sets_required_headers
      stub = stub_request(:get, "https://cdn.nba.com/static/json/liveData/test.json")
        .with(headers: required_headers)
        .to_return(body: "{}")

      LiveConnection.new.get("test.json")

      assert_requested stub
    end

    def test_get_returns_nil_on_non_success_response
      stub_request(:get, /cdn.nba.com/).to_return(status: 404)

      result = LiveConnection.new.get("notfound.json")

      assert_nil result
    end

    def test_get_decodes_gzip_response
      gzipped = StringIO.new.tap do |io|
        gz = Zlib::GzipWriter.new(io)
        gz.write('{"compressed": true}')
        gz.close
      end.string

      stub_request(:get, /cdn.nba.com/)
        .to_return(body: gzipped, headers: {"Content-Encoding" => "gzip"})

      result = LiveConnection.new.get("test.json")

      assert_equal '{"compressed": true}', result
    end

    def test_get_decodes_deflate_response
      deflated = Zlib::Deflate.deflate('{"deflated": true}')

      stub_request(:get, /cdn.nba.com/)
        .to_return(body: deflated, headers: {"Content-Encoding" => "deflate"})

      result = LiveConnection.new.get("test.json")

      assert_equal '{"deflated": true}', result
    end

    def test_get_returns_raw_body_when_no_encoding
      stub_request(:get, /cdn.nba.com/)
        .to_return(body: '{"raw": true}')

      result = LiveConnection.new.get("test.json")

      assert_equal '{"raw": true}', result
    end

    private

    def required_headers
      {
        "Accept" => "application/json, text/plain, */*",
        "Accept-Language" => "en-US,en;q=0.9",
        "Accept-Encoding" => "gzip, deflate, identity",
        "Connection" => "keep-alive",
        "Referer" => "https://www.nba.com/",
        "Origin" => "https://www.nba.com"
      }
    end
  end
end
