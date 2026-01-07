require "json"
require_relative "client"
require_relative "collection"
require_relative "pass_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player tracking pass statistics
  #
  # @api public
  module PlayerDashPtPass
    # Result set name for passes made
    # @return [String] the result set name
    PASSES_MADE = "PassesMade".freeze

    # Result set name for passes received
    # @return [String] the result set name
    PASSES_RECEIVED = "PassesReceived".freeze

    # Retrieves passes made statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtPass.passes_made(player: 201939)
    #   stats.each { |s| puts "#{s.pass_to}: #{s.ast} assists" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of pass statistics
    def self.passes_made(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: PASSES_MADE}
      fetch_stats(player, team, season, options, client: client)
    end

    # Retrieves passes received statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtPass.passes_received(player: 201939)
    #   stats.each { |s| puts "#{s.pass_to}: #{s.pass} passes" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of pass statistics
    def self.passes_received(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: PASSES_RECEIVED}
      fetch_stats(player, team, season, options, client: client)
    end

    # Fetches pass stats from the API
    #
    # @api private
    # @return [Collection] collection of pass stats
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
      "playerdashptpass?PlayerID=#{player_id}&TeamID=#{team_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into pass stat objects
    #
    # @api private
    # @return [Collection] collection of pass stats
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

      Collection.new(rows.map { |row| build_pass_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a pass stat from API data
    #
    # @api private
    # @return [PassStat] the pass stat object
    def self.build_pass_stat(data)
      PassStat.new(**identity_info(data), **pass_info(data), **shooting_info(data))
    end
    private_class_method :build_pass_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name_last_first: data.fetch("PLAYER_NAME_LAST_FIRST", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       pass_teammate_player_id: data.fetch("PASS_TEAMMATE_PLAYER_ID", nil)}
    end
    private_class_method :identity_info

    # Extracts pass information from data
    #
    # @api private
    # @return [Hash] the pass information hash
    def self.pass_info(data)
      {pass_to: data.fetch("PASS_TO", nil), gp: data.fetch("GP", nil), g: data.fetch("G", nil),
       pass_type: data.fetch("PASS_TYPE", nil), frequency: data.fetch("FREQUENCY", nil),
       pass: data.fetch("PASS", nil), ast: data.fetch("AST", nil)}
    end
    private_class_method :pass_info

    # Extracts shooting information from data
    #
    # @api private
    # @return [Hash] the shooting information hash
    def self.shooting_info(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg2m: data.fetch("FG2M", nil), fg2a: data.fetch("FG2A", nil), fg2_pct: data.fetch("FG2_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil)}
    end
    private_class_method :shooting_info
  end
end
