require "net/http"
require "openssl"
require "uri"

module NBA
  # Handles HTTP connections to the NBA API
  class Connection
    BASE_URL = "https://stats.nba.com/stats".freeze

    # Returns the base URL for API requests
    #
    # @api private
    # @return [String] the base URL
    attr_reader :base_url

    # Initializes a new Connection object
    #
    # @api public
    # @example
    #   connection = NBA::Connection.new
    # @param base_url [String] the base URL for API requests
    # @return [NBA::Connection] a new connection instance
    def initialize(base_url: BASE_URL)
      @base_url = base_url
    end

    # Makes a GET request to the specified path
    #
    # @api public
    # @example
    #   connection.get("teams")
    # @param path [String] the API path to request
    # @return [String] the response body
    def get(path)
      uri = URI.join(base_url, path)
      request = Net::HTTP::Get.new(uri)
      request["User-Agent"] = "Mozilla/5.0"
      request["Accept"] = "application/json"

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        response = http.request(request)
        response.body
      end
    end
  end
end
