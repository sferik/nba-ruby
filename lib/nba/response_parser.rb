require "json"
require_relative "collection"

module NBA
  # Parses NBA API responses and builds collections of objects
  #
  # This module consolidates the common pattern of parsing JSON responses
  # from the NBA Stats API, extracting result sets, and building objects
  # from header/row pairs.
  module ResponseParser
    # Parses an API response and returns a collection of objects
    #
    # @api public
    # @example
    #   ResponseParser.parse(response, result_set: "PlayerStats") { |data| Player.new(**data) }
    # @param response [String, nil] the JSON response body
    # @param result_set [String, nil] the name of the result set to extract (nil for first)
    # @yield [Hash] yields each row as a hash with header keys
    # @return [Collection] a collection of parsed objects
    def self.parse(response, result_set: nil, &builder)
      return Collection.new unless response

      data = parse_json(response)
      return Collection.new unless data

      result = find_result_set(data, result_set)
      return Collection.new unless result

      build_collection(result, &builder)
    end

    # Parses an API response and returns a single object
    #
    # @api public
    # @example
    #   ResponseParser.parse_single(response) { |data| Player.new(**data) }
    # @param response [String, nil] the JSON response body
    # @param result_set [String, nil] the name of the result set to extract
    # @yield [Hash] yields the first row as a hash with header keys
    # @return [Object, nil] the parsed object or nil
    def self.parse_single(response, result_set: nil)
      return unless response

      data = parse_json(response)
      return unless data

      result = find_result_set(data, result_set)
      return unless result

      headers = result.fetch("headers", nil)
      row = result.dig("rowSet", 0)
      return unless headers && row

      yield zip_to_hash(headers, row)
    end

    # Zips headers and row into a hash
    #
    # @api public
    # @example
    #   ResponseParser.zip_to_hash(["NAME", "AGE"], ["LeBron", 39])
    #   #=> {"NAME" => "LeBron", "AGE" => 39}
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [Hash] a hash with header keys and row values
    def self.zip_to_hash(headers, row)
      headers.zip(row).to_h
    end

    # Parses JSON safely, returning nil on error
    #
    # @api private
    # @param response [String] the JSON string to parse
    # @return [Hash, nil] the parsed JSON or nil on error
    def self.parse_json(response)
      JSON.parse(response)
    rescue JSON::ParserError
      nil
    end
    private_class_method :parse_json

    # Finds a result set by name or returns the first one
    #
    # @api private
    # @param data [Hash] the parsed JSON data
    # @param name [String, nil] the result set name (nil for first)
    # @return [Hash, nil] the result set or nil
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      if name
        result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
      else
        result_sets.first
      end
    end
    private_class_method :find_result_set

    # Builds a collection from a result set
    #
    # @api private
    # @param result [Hash] the result set
    # @yield [Hash] yields each row as a hash
    # @return [Collection] a collection of objects
    def self.build_collection(result)
      headers = result.fetch("headers", nil)
      rows = result.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      objects = rows.map { |row| yield zip_to_hash(headers, row) }
      Collection.new(objects)
    end
    private_class_method :build_collection
  end
end
