require_relative "../../test_helper"

module NBA
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
