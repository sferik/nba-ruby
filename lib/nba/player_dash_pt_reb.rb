require "json"
require_relative "client"
require_relative "collection"
require_relative "rebound_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player tracking rebound statistics
  #
  # @api public
  module PlayerDashPtReb
    # Result set name for overall rebounding
    # @return [String] the result set name
    OVERALL = "OverallRebounding".freeze

    # Result set name for number contested rebounding
    # @return [String] the result set name
    NUM_CONTESTED = "NumContestedRebounding".freeze

    # Result set name for rebound distance rebounding
    # @return [String] the result set name
    REB_DISTANCE = "RebDistanceRebounding".freeze

    # Result set name for shot distance rebounding
    # @return [String] the result set name
    SHOT_DISTANCE = "ShotDistanceRebounding".freeze

    # Result set name for shot type rebounding
    # @return [String] the result set name
    SHOT_TYPE = "ShotTypeRebounding".freeze

    # Retrieves overall rebounding statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtReb.overall(player: 201939)
    #   stats.first.reb #=> 5.7
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.overall(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: OVERALL}
      fetch_stats(player, team, season, options, client: client)
    end

    # Retrieves number contested rebounding statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtReb.num_contested(player: 201939)
    #   stats.each { |s| puts "#{s.reb_num_contesting_range}: #{s.reb}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.num_contested(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: NUM_CONTESTED}
      fetch_stats(player, team, season, options, client: client)
    end

    # Retrieves rebound distance rebounding statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtReb.reb_distance(player: 201939)
    #   stats.each { |s| puts "#{s.reb_dist_range}: #{s.reb}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.reb_distance(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: REB_DISTANCE}
      fetch_stats(player, team, season, options, client: client)
    end

    # Retrieves shot distance rebounding statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtReb.shot_distance(player: 201939)
    #   stats.each { |s| puts "#{s.shot_dist_range}: #{s.reb}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.shot_distance(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: SHOT_DISTANCE}
      fetch_stats(player, team, season, options, client: client)
    end

    # Retrieves shot type rebounding statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtReb.shot_type(player: 201939)
    #   stats.each { |s| puts "#{s.shot_type_range}: #{s.reb}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.shot_type(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: SHOT_TYPE}
      fetch_stats(player, team, season, options, client: client)
    end

    # Fetches rebound stats from the API
    #
    # @api private
    # @return [Collection] collection of rebound stats
    def self.fetch_stats(player, team, season, options, client:)
      path = build_path(player, team, season, options.fetch(:season_type), options.fetch(:per_mode))
      response = client.get(path)
      parse_response(response, options.fetch(:result_set))
    end
    private_class_method :fetch_stats

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(player, team, season, season_type, per_mode)
      player_id = Utils.extract_id(player)
      team_id = Utils.extract_id(team)
      season_str = Utils.format_season(season)
      "playerdashptreb?PlayerID=#{player_id}&TeamID=#{team_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into rebound stat objects
    #
    # @api private
    # @return [Collection] collection of rebound stats
    def self.parse_response(response, result_set_name)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      build_collection(result_set)
    end
    private_class_method :parse_response

    # Finds a result set by name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil if not found
    def self.find_result_set(data, result_set_name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(result_set_name) }
    end
    private_class_method :find_result_set

    # Builds a collection from a result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_collection(result_set)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_rebound_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a rebound stat from API data
    #
    # @api private
    # @return [ReboundStat] the rebound stat object
    def self.build_rebound_stat(data)
      ReboundStat.new(**identity_info(data), **range_info(data), **rebound_info(data))
    end
    private_class_method :build_rebound_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name_last_first: data.fetch("PLAYER_NAME_LAST_FIRST", nil),
       sort_order: data.fetch("SORT_ORDER", nil), g: data.fetch("G", nil)}
    end
    private_class_method :identity_info

    # Extracts range information from data
    #
    # @api private
    # @return [Hash] the range information hash
    def self.range_info(data)
      {reb_num_contesting_range: data.fetch("REB_NUM_CONTESTING_RANGE", nil),
       overall: data.fetch("OVERALL", nil), reb_dist_range: data.fetch("REB_DIST_RANGE", nil),
       shot_dist_range: data.fetch("SHOT_DIST_RANGE", nil), shot_type_range: data.fetch("SHOT_TYPE_RANGE", nil)}
    end
    private_class_method :range_info

    # Extracts rebound information from data
    #
    # @api private
    # @return [Hash] the rebound information hash
    def self.rebound_info(data)
      {reb_frequency: data.fetch("REB_FREQUENCY", nil), oreb: data.fetch("OREB", nil),
       dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       c_oreb: data.fetch("C_OREB", nil), c_dreb: data.fetch("C_DREB", nil),
       c_reb: data.fetch("C_REB", nil), c_reb_pct: data.fetch("C_REB_PCT", nil),
       uc_oreb: data.fetch("UC_OREB", nil), uc_dreb: data.fetch("UC_DREB", nil),
       uc_reb: data.fetch("UC_REB", nil), uc_reb_pct: data.fetch("UC_REB_PCT", nil)}
    end
    private_class_method :rebound_info
  end
end
