require "net/http"
require "openssl"
require "stringio"
require "uri"
require "zlib"

module NBA
  # Handles HTTP connections to the NBA Live Data API
  class LiveConnection
    # Default base URL for the NBA Live Data API
    # @return [String] the default base URL
    BASE_URL = "https://cdn.nba.com/static/json/liveData/".freeze

    # Returns the base URL for API requests
    #
    # @api private
    # @return [String] the base URL
    attr_reader :base_url

    # Initializes a new LiveConnection object
    #
    # @api public
    # @example
    #   connection = NBA::LiveConnection.new
    # @param base_url [String] the base URL for API requests
    # @return [NBA::LiveConnection] a new live connection instance
    def initialize(base_url: BASE_URL)
      @base_url = base_url
    end

    # Makes a GET request to the specified path
    #
    # @api public
    # @example
    #   connection.get("scoreboard/todaysScoreboard_00.json")
    # @param path [String] the API path to request
    # @return [String] the response body
    def get(path)
      uri = URI.join(base_url, path)
      hostname = uri.hostname or raise ArgumentError, "Invalid URI: #{uri}"
      request = Net::HTTP::Get.new(uri)
      apply_headers(request)

      Net::HTTP.start(hostname, uri.port, use_ssl: uri.scheme.eql?("https")) do |http|
        response = http.request(request)
        decode_body(response) if response.is_a?(Net::HTTPSuccess)
      end
    end

    private

    # Applies the required headers for NBA Live Data API requests
    #
    # @api private
    # @param request [Net::HTTP::Get] the request object
    # @return [void]
    def apply_headers(request)
      request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) " \
                              "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
      request["Accept"] = "application/json, text/plain, */*"
      request["Accept-Language"] = "en-US,en;q=0.9"
      request["Accept-Encoding"] = "gzip, deflate, identity"
      request["Connection"] = "keep-alive"
      request["Referer"] = "https://www.nba.com/"
      request["Origin"] = "https://www.nba.com"
    end

    # Decodes the response body based on Content-Encoding
    #
    # @api private
    # @param response [Net::HTTPResponse] the HTTP response
    # @return [String, nil] the decoded response body
    def decode_body(response)
      case response["Content-Encoding"]
      when "gzip"
        Zlib::GzipReader.new(StringIO.new(response.body)).read
      when "deflate"
        Zlib::Inflate.inflate(response.body)
      else
        response.body
      end
    end
  end
end
