require "json"
require_relative "client"
require_relative "collection"
require_relative "draft_combine_stat"

module NBA
  # Provides methods to retrieve draft combine stats
  module DraftCombineStats
    # Result set name
    # @return [String] the result set name
    RESULTS = "Results".freeze

    # Retrieves draft combine stats for a season
    #
    # @api public
    # @example
    #   stats = NBA::DraftCombineStats.all(season: 2019)
    #   stats.each { |s| puts "#{s.player_name}: #{s.height_w_shoes}" }
    # @param season [Integer] the draft combine season year
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of draft combine stats
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
      "draftcombinestats?LeagueID=#{league_id}&SeasonYear=#{season}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    # @api private
    # @return [Collection] collection of stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      results = rows.map { |row| build_result(headers, row) }
      Collection.new(results)
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

    # Builds a DraftCombineStat object from raw data
    # @api private
    # @return [DraftCombineStat] the stat object
    def self.build_result(headers, row)
      data = headers.zip(row).to_h
      DraftCombineStat.new(**result_attributes(data))
    end
    private_class_method :build_result

    # Extracts result attributes from data
    # @api private
    # @return [Hash] the result attributes
    def self.result_attributes(data)
      player_attributes(data).merge(
        physical_attributes(data),
        athletic_attributes(data)
      )
    end
    private_class_method :result_attributes

    # Extracts player attributes from data
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {
        season: data["SEASON"],
        player_id: data["PLAYER_ID"],
        first_name: data["FIRST_NAME"],
        last_name: data["LAST_NAME"],
        player_name: data["PLAYER_NAME"],
        position: data["POSITION"]
      }
    end
    private_class_method :player_attributes

    # Extracts physical measurement attributes from data
    # @api private
    # @return [Hash] physical measurement attributes
    def self.physical_attributes(data)
      height_attrs(data).merge(body_attrs(data)).merge(hand_attrs(data))
    end
    private_class_method :physical_attributes

    # Extracts height attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] height attributes
    def self.height_attrs(data)
      {height_wo_shoes: data["HEIGHT_WO_SHOES"],
       height_wo_shoes_ft_in: data["HEIGHT_WO_SHOES_FT_IN"],
       height_w_shoes: data["HEIGHT_W_SHOES"],
       height_w_shoes_ft_in: data["HEIGHT_W_SHOES_FT_IN"]}
    end
    private_class_method :height_attrs

    # Extracts body measurement attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] body measurement attributes
    def self.body_attrs(data)
      {weight: data["WEIGHT"], wingspan: data["WINGSPAN"],
       wingspan_ft_in: data["WINGSPAN_FT_IN"],
       standing_reach: data["STANDING_REACH"],
       standing_reach_ft_in: data["STANDING_REACH_FT_IN"],
       body_fat_pct: data["BODY_FAT_PCT"]}
    end
    private_class_method :body_attrs

    # Extracts hand measurement attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] hand measurement attributes
    def self.hand_attrs(data)
      {hand_length: data["HAND_LENGTH"], hand_width: data["HAND_WIDTH"]}
    end
    private_class_method :hand_attrs

    # Extracts athletic test attributes from data
    # @api private
    # @return [Hash] athletic test attributes
    def self.athletic_attributes(data)
      {
        standing_vertical_leap: data["STANDING_VERTICAL_LEAP"],
        max_vertical_leap: data["MAX_VERTICAL_LEAP"],
        lane_agility_time: data["LANE_AGILITY_TIME"],
        modified_lane_agility_time: data["MODIFIED_LANE_AGILITY_TIME"],
        three_quarter_sprint: data["THREE_QUARTER_SPRINT"],
        bench_press: data["BENCH_PRESS"]
      }
    end
    private_class_method :athletic_attributes
  end
end
