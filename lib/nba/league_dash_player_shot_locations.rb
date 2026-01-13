require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_player_shot_location_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide player shot location statistics
  #
  # @api public
  module LeagueDashPlayerShotLocations
    # Result set name for shot locations
    # @return [String] the result set name
    SHOT_LOCATIONS = "ShotLocations".freeze

    # Regular season type constant
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type constant
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per game mode constant
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Totals mode constant
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # By 5-foot zone distance range
    # @return [String] the distance range
    BY_ZONE = "By Zone".freeze

    # Retrieves all league-wide player shot location statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPlayerShotLocations.all(season: 2024)
    #   stats.first.restricted_area_fg_pct #=> 0.595
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param distance_range [String] the distance range
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player shot location statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME,
      distance_range: BY_ZONE, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode, distance_range: distance_range)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguedashplayershotlocations?LeagueID=00&Season=#{season_str}" \
        "&SeasonType=#{opts.fetch(:season_type)}&PerMode=#{opts.fetch(:per_mode)}" \
        "&DistanceRange=#{opts.fetch(:distance_range)}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of player shot location stats
    def self.parse_response(response)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data)
      build_stats(result_set)
    end
    private_class_method :parse_response

    # Finds the result set by name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil if not found
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(SHOT_LOCATIONS) }
    end
    private_class_method :find_result_set

    # Builds stats collection from result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_stats(result_set)
      return Collection.new unless result_set

      headers = build_headers(result_set)
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_stats

    # Builds flat header array from nested headers
    #
    # @api private
    # @return [Array<String>, nil] the flattened headers
    def self.build_headers(result_set)
      headers = result_set["headers"]
      return unless headers

      headers.flat_map { |h| h["columnNames"] }
    end
    private_class_method :build_headers

    # Builds a single stat object from API data
    #
    # @api private
    # @return [LeagueDashPlayerShotLocationStat] the stat object
    def self.build_stat(data)
      LeagueDashPlayerShotLocationStat.new(**identity_info(data), **restricted_area_info(data),
        **paint_info(data), **mid_range_info(data), **corner_3_info(data), **above_break_3_info(data),
        **backcourt_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       age: data["AGE"]}
    end
    private_class_method :identity_info

    # Extracts restricted area shooting information from data
    #
    # @api private
    # @return [Hash] the restricted area information hash
    def self.restricted_area_info(data)
      {restricted_area_fgm: data["Restricted Area FGM"],
       restricted_area_fga: data["Restricted Area FGA"],
       restricted_area_fg_pct: data["Restricted Area FG_PCT"]}
    end
    private_class_method :restricted_area_info

    # Extracts in the paint (non-RA) shooting information from data
    #
    # @api private
    # @return [Hash] the paint information hash
    def self.paint_info(data)
      {in_the_paint_non_ra_fgm: data["In The Paint (Non-RA) FGM"],
       in_the_paint_non_ra_fga: data["In The Paint (Non-RA) FGA"],
       in_the_paint_non_ra_fg_pct: data["In The Paint (Non-RA) FG_PCT"]}
    end
    private_class_method :paint_info

    # Extracts mid-range shooting information from data
    #
    # @api private
    # @return [Hash] the mid-range information hash
    def self.mid_range_info(data)
      {mid_range_fgm: data["Mid-Range FGM"], mid_range_fga: data["Mid-Range FGA"],
       mid_range_fg_pct: data["Mid-Range FG_PCT"]}
    end
    private_class_method :mid_range_info

    # Extracts corner 3 shooting information from data
    #
    # @api private
    # @return [Hash] the corner 3 information hash
    def self.corner_3_info(data)
      {left_corner_3_fgm: data["Left Corner 3 FGM"],
       left_corner_3_fga: data["Left Corner 3 FGA"],
       left_corner_3_fg_pct: data["Left Corner 3 FG_PCT"],
       right_corner_3_fgm: data["Right Corner 3 FGM"],
       right_corner_3_fga: data["Right Corner 3 FGA"],
       right_corner_3_fg_pct: data["Right Corner 3 FG_PCT"],
       corner_3_fgm: data["Corner 3 FGM"], corner_3_fga: data["Corner 3 FGA"],
       corner_3_fg_pct: data["Corner 3 FG_PCT"]}
    end
    private_class_method :corner_3_info

    # Extracts above the break 3 shooting information from data
    #
    # @api private
    # @return [Hash] the above the break 3 information hash
    def self.above_break_3_info(data)
      {above_the_break_3_fgm: data["Above the Break 3 FGM"],
       above_the_break_3_fga: data["Above the Break 3 FGA"],
       above_the_break_3_fg_pct: data["Above the Break 3 FG_PCT"]}
    end
    private_class_method :above_break_3_info

    # Extracts backcourt shooting information from data
    #
    # @api private
    # @return [Hash] the backcourt information hash
    def self.backcourt_info(data)
      {backcourt_fgm: data["Backcourt FGM"], backcourt_fga: data["Backcourt FGA"],
       backcourt_fg_pct: data["Backcourt FG_PCT"]}
    end
    private_class_method :backcourt_info
  end
end
