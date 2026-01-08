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
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(SHOT_LOCATIONS) }
    end
    private_class_method :find_result_set

    # Builds stats collection from result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_stats(result_set)
      return Collection.new unless result_set

      headers = build_headers(result_set)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_stats

    # Builds flat header array from nested headers
    #
    # @api private
    # @return [Array<String>, nil] the flattened headers
    def self.build_headers(result_set)
      headers = result_set.fetch("headers", nil)
      return unless headers

      headers.flat_map { |h| h.fetch("columnNames", nil) }
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
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       age: data.fetch("AGE", nil)}
    end
    private_class_method :identity_info

    # Extracts restricted area shooting information from data
    #
    # @api private
    # @return [Hash] the restricted area information hash
    def self.restricted_area_info(data)
      {restricted_area_fgm: data.fetch("Restricted Area FGM", nil),
       restricted_area_fga: data.fetch("Restricted Area FGA", nil),
       restricted_area_fg_pct: data.fetch("Restricted Area FG_PCT", nil)}
    end
    private_class_method :restricted_area_info

    # Extracts in the paint (non-RA) shooting information from data
    #
    # @api private
    # @return [Hash] the paint information hash
    def self.paint_info(data)
      {in_the_paint_non_ra_fgm: data.fetch("In The Paint (Non-RA) FGM", nil),
       in_the_paint_non_ra_fga: data.fetch("In The Paint (Non-RA) FGA", nil),
       in_the_paint_non_ra_fg_pct: data.fetch("In The Paint (Non-RA) FG_PCT", nil)}
    end
    private_class_method :paint_info

    # Extracts mid-range shooting information from data
    #
    # @api private
    # @return [Hash] the mid-range information hash
    def self.mid_range_info(data)
      {mid_range_fgm: data.fetch("Mid-Range FGM", nil), mid_range_fga: data.fetch("Mid-Range FGA", nil),
       mid_range_fg_pct: data.fetch("Mid-Range FG_PCT", nil)}
    end
    private_class_method :mid_range_info

    # Extracts corner 3 shooting information from data
    #
    # @api private
    # @return [Hash] the corner 3 information hash
    def self.corner_3_info(data)
      {left_corner_3_fgm: data.fetch("Left Corner 3 FGM", nil),
       left_corner_3_fga: data.fetch("Left Corner 3 FGA", nil),
       left_corner_3_fg_pct: data.fetch("Left Corner 3 FG_PCT", nil),
       right_corner_3_fgm: data.fetch("Right Corner 3 FGM", nil),
       right_corner_3_fga: data.fetch("Right Corner 3 FGA", nil),
       right_corner_3_fg_pct: data.fetch("Right Corner 3 FG_PCT", nil),
       corner_3_fgm: data.fetch("Corner 3 FGM", nil), corner_3_fga: data.fetch("Corner 3 FGA", nil),
       corner_3_fg_pct: data.fetch("Corner 3 FG_PCT", nil)}
    end
    private_class_method :corner_3_info

    # Extracts above the break 3 shooting information from data
    #
    # @api private
    # @return [Hash] the above the break 3 information hash
    def self.above_break_3_info(data)
      {above_the_break_3_fgm: data.fetch("Above the Break 3 FGM", nil),
       above_the_break_3_fga: data.fetch("Above the Break 3 FGA", nil),
       above_the_break_3_fg_pct: data.fetch("Above the Break 3 FG_PCT", nil)}
    end
    private_class_method :above_break_3_info

    # Extracts backcourt shooting information from data
    #
    # @api private
    # @return [Hash] the backcourt information hash
    def self.backcourt_info(data)
      {backcourt_fgm: data.fetch("Backcourt FGM", nil), backcourt_fga: data.fetch("Backcourt FGA", nil),
       backcourt_fg_pct: data.fetch("Backcourt FG_PCT", nil)}
    end
    private_class_method :backcourt_info
  end
end
