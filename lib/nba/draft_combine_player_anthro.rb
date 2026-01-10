require "json"
require_relative "client"
require_relative "collection"
require_relative "draft_combine_anthro_measurement"

module NBA
  # Provides methods to retrieve draft combine anthropometric data
  module DraftCombinePlayerAnthro
    # Result set name
    # @return [String] the result set name
    RESULTS = "Results".freeze

    # Retrieves draft combine anthropometric measurements for a season
    #
    # @api public
    # @example
    #   measurements = NBA::DraftCombinePlayerAnthro.all(season: 2019)
    #   measurements.each { |m| puts "#{m.player_name}: #{m.height_w_shoes_ft_in}" }
    # @param season [Integer] the draft combine season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft combine anthropometric measurements
    def self.all(season:, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, league_id)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, league_id)
      "draftcombineplayeranthro?LeagueID=#{league_id}&SeasonYear=#{season}"
    end
    private_class_method :build_path

    # Parses the API response into measurement objects
    # @api private
    # @return [Collection] collection of measurements
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      measurements = rows.map { |row| build_measurement(headers, row) }
      Collection.new(measurements)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(RESULTS) }
    end
    private_class_method :find_result_set

    # Builds a DraftCombineAnthroMeasurement object from raw data
    # @api private
    # @return [DraftCombineAnthroMeasurement] the measurement object
    def self.build_measurement(headers, row)
      data = headers.zip(row).to_h
      DraftCombineAnthroMeasurement.new(**measurement_attributes(data))
    end
    private_class_method :build_measurement

    # Extracts measurement attributes from data
    # @api private
    # @return [Hash] the measurement attributes
    def self.measurement_attributes(data)
      player_attributes(data).merge(
        height_attributes(data),
        physical_attributes(data)
      )
    end
    private_class_method :measurement_attributes

    # Extracts player attributes from data
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {
        temp_player_id: data.fetch("TEMP_PLAYER_ID", nil),
        player_id: data.fetch("PLAYER_ID", nil),
        first_name: data.fetch("FIRST_NAME", nil),
        last_name: data.fetch("LAST_NAME", nil),
        player_name: data.fetch("PLAYER_NAME", nil),
        position: data.fetch("POSITION", nil)
      }
    end
    private_class_method :player_attributes

    # Extracts height attributes from data
    # @api private
    # @return [Hash] height attributes
    def self.height_attributes(data)
      {
        height_wo_shoes: data.fetch("HEIGHT_WO_SHOES", nil),
        height_wo_shoes_ft_in: data.fetch("HEIGHT_WO_SHOES_FT_IN", nil),
        height_w_shoes: data.fetch("HEIGHT_W_SHOES", nil),
        height_w_shoes_ft_in: data.fetch("HEIGHT_W_SHOES_FT_IN", nil)
      }
    end
    private_class_method :height_attributes

    # Extracts physical attributes from data
    # @api private
    # @return [Hash] physical attributes
    def self.physical_attributes(data)
      {
        weight: data.fetch("WEIGHT", nil),
        wingspan: data.fetch("WINGSPAN", nil),
        wingspan_ft_in: data.fetch("WINGSPAN_FT_IN", nil),
        standing_reach: data.fetch("STANDING_REACH", nil),
        standing_reach_ft_in: data.fetch("STANDING_REACH_FT_IN", nil),
        body_fat_pct: data.fetch("BODY_FAT_PCT", nil),
        hand_length: data.fetch("HAND_LENGTH", nil),
        hand_width: data.fetch("HAND_WIDTH", nil)
      }
    end
    private_class_method :physical_attributes
  end
end
