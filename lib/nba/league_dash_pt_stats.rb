require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_pt_stats_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide player and team tracking statistics
  #
  # @api public
  module LeagueDashPtStats
    # Result set name for league dash PT stats
    # @return [String] the result set name
    LEAGUE_DASH_PT_STATS = "LeagueDashPtStats".freeze

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

    # Player mode constant
    # @return [String] the player or team mode
    PLAYER = "Player".freeze

    # Team mode constant
    # @return [String] the player or team mode
    TEAM = "Team".freeze

    # Speed and distance measure type constant
    # @return [String] the PT measure type
    SPEED_DISTANCE = "SpeedDistance".freeze

    # Retrieves all league-wide player or team tracking statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPtStats.all(season: 2024)
    #   stats.first.avg_speed #=> 4.25
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param player_or_team [String] whether to get player or team stats
    # @param pt_measure_type [String] the PT measure type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of tracking statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME,
      player_or_team: PLAYER, pt_measure_type: SPEED_DISTANCE, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode,
        player_or_team: player_or_team, pt_measure_type: pt_measure_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguedashptstats?LeagueID=00&Season=#{season_str}" \
        "&SeasonType=#{opts.fetch(:season_type)}" \
        "&PerMode=#{opts.fetch(:per_mode)}&PlayerOrTeam=#{opts.fetch(:player_or_team)}" \
        "&PtMeasureType=#{opts.fetch(:pt_measure_type)}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of PT stats
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

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_DASH_PT_STATS) }
    end
    private_class_method :find_result_set

    # Builds stats collection from result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_stats(result_set)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_stats

    # Builds a single stat object from API data
    #
    # @api private
    # @return [LeagueDashPtStatsStat] the stat object
    def self.build_stat(data)
      LeagueDashPtStatsStat.new(**identity_info(data), **speed_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       team_name: data.fetch("TEAM_NAME", nil), age: data.fetch("AGE", nil),
       gp: data.fetch("GP", nil), w: data.fetch("W", nil), l: data.fetch("L", nil),
       min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_info

    # Extracts speed and distance information from data
    #
    # @api private
    # @return [Hash] the speed and distance statistics hash
    def self.speed_info(data)
      {dist_feet: data.fetch("DIST_FEET", nil), dist_miles: data.fetch("DIST_MILES", nil),
       dist_miles_off: data.fetch("DIST_MILES_OFF", nil), dist_miles_def: data.fetch("DIST_MILES_DEF", nil),
       avg_speed: data.fetch("AVG_SPEED", nil), avg_speed_off: data.fetch("AVG_SPEED_OFF", nil),
       avg_speed_def: data.fetch("AVG_SPEED_DEF", nil)}
    end
    private_class_method :speed_info
  end
end
