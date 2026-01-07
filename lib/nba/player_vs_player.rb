require "json"
require_relative "client"
require_relative "collection"
require_relative "vs_player_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player vs player statistics
  #
  # @api public
  module PlayerVsPlayer
    # Result set name for overall comparison
    # @return [String] the result set name
    OVERALL = "Overall".freeze

    # Result set name for on/off court comparison
    # @return [String] the result set name
    ON_OFF_COURT = "OnOffCourt".freeze

    # Retrieves overall comparison statistics between two players
    #
    # @api public
    # @example
    #   stats = NBA::PlayerVsPlayer.overall(player: 201939, vs_player: 201566)
    #   stats.first.pts #=> 26.4
    # @param player [Integer, Player] the player ID or Player object
    # @param vs_player [Integer, Player] the vs player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of vs player statistics
    def self.overall(player:, vs_player:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: OVERALL}
      fetch_stats(player, vs_player, season, options, client: client)
    end

    # Retrieves on/off court comparison statistics between two players
    #
    # @api public
    # @example
    #   stats = NBA::PlayerVsPlayer.on_off_court(player: 201939, vs_player: 201566)
    #   stats.each { |s| puts "#{s.court_status}: #{s.pts}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param vs_player [Integer, Player] the vs player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of vs player statistics
    def self.on_off_court(player:, vs_player:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: ON_OFF_COURT}
      fetch_stats(player, vs_player, season, options, client: client)
    end

    # Fetches vs player stats from the API
    #
    # @api private
    # @return [Collection] collection of vs player stats
    def self.fetch_stats(player, vs_player, season, options, client:)
      path = build_path(player, vs_player, season, options.fetch(:season_type), options.fetch(:per_mode))
      response = client.get(path)
      parse_response(response, options.fetch(:result_set))
    end
    private_class_method :fetch_stats

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(player, vs_player, season, season_type, per_mode)
      player_id = Utils.extract_id(player)
      vs_player_id = Utils.extract_id(vs_player)
      season_str = Utils.format_season(season)
      "playervsplayer?PlayerID=#{player_id}&VsPlayerID=#{vs_player_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into vs player stat objects
    #
    # @api private
    # @return [Collection] collection of vs player stats
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

      Collection.new(rows.map { |row| build_vs_player_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a vs player stat from API data
    #
    # @api private
    # @return [VsPlayerStat] the vs player stat object
    def self.build_vs_player_stat(data)
      VsPlayerStat.new(**identity_info(data), **stat_info(data))
    end
    private_class_method :build_vs_player_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), vs_player_id: data.fetch("VS_PLAYER_ID", nil),
       court_status: data.fetch("COURT_STATUS", nil), gp: data.fetch("GP", nil),
       min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_info

    # Extracts stat information from data
    #
    # @api private
    # @return [Hash] the stat information hash
    def self.stat_info(data)
      {pts: data.fetch("PTS", nil), reb: data.fetch("REB", nil), ast: data.fetch("AST", nil),
       stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil), tov: data.fetch("TOV", nil),
       fg_pct: data.fetch("FG_PCT", nil), plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :stat_info
  end
end
