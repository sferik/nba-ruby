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

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      measurements = rows.map { |row| build_measurement(headers, row) }
      Collection.new(measurements)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(RESULTS) }
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
        temp_player_id: data["TEMP_PLAYER_ID"],
        player_id: data["PLAYER_ID"],
        first_name: data["FIRST_NAME"],
        last_name: data["LAST_NAME"],
        player_name: data["PLAYER_NAME"],
        position: data["POSITION"]
      }
    end
    private_class_method :player_attributes

    # Extracts height attributes from data
    # @api private
    # @return [Hash] height attributes
    def self.height_attributes(data)
      {
        height_wo_shoes: data["HEIGHT_WO_SHOES"],
        height_wo_shoes_ft_in: data["HEIGHT_WO_SHOES_FT_IN"],
        height_w_shoes: data["HEIGHT_W_SHOES"],
        height_w_shoes_ft_in: data["HEIGHT_W_SHOES_FT_IN"]
      }
    end
    private_class_method :height_attributes

    # Extracts physical attributes from data
    # @api private
    # @return [Hash] physical attributes
    def self.physical_attributes(data)
      {
        weight: data["WEIGHT"],
        wingspan: data["WINGSPAN"],
        wingspan_ft_in: data["WINGSPAN_FT_IN"],
        standing_reach: data["STANDING_REACH"],
        standing_reach_ft_in: data["STANDING_REACH_FT_IN"],
        body_fat_pct: data["BODY_FAT_PCT"],
        hand_length: data["HAND_LENGTH"],
        hand_width: data["HAND_WIDTH"]
      }
    end
    private_class_method :physical_attributes
  end
end
