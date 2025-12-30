require_relative "connection"

module NBA
  # API client for making requests to the NBA Stats API
  class Client
    # Returns the connection used for HTTP requests
    #
    # @api private
    # @return [Connection] the connection instance
    attr_reader :connection

    # Initializes a new Client object
    #
    # @api public
    # @example
    #   client = NBA::Client.new
    # @param connection [Connection] the connection to use for requests
    # @return [NBA::Client] a new client instance
    def initialize(connection: Connection.new)
      @connection = connection
    end

    # Makes a GET request to the specified path
    #
    # @api public
    # @example
    #   client.get("teams")
    # @param path [String] the API path to request
    # @return [String] the response body
    def get(path)
      connection.get(path)
    end
  end

  # Default client instance
  CLIENT = Client.new
end
