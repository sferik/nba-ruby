require "json"
require_relative "client"
require_relative "collection"
require_relative "team_vs_player_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve team vs player statistics
  #
  # @api public
  module TeamVsPlayer
    # Result set name for overall comparison
    # @return [String] the result set name
    OVERALL = "Overall".freeze

    # Result set name for on/off court comparison
    # @return [String] the result set name
    ON_OFF_COURT = "OnOffCourt".freeze

    # Retrieves overall comparison statistics for team vs player
    #
    # @api public
    # @example
    #   stats = NBA::TeamVsPlayer.overall(team: 1610612744, vs_player: 201566)
    #   stats.first.pts #=> 106.4
    # @param team [Integer, Team] the team ID or Team object
    # @param vs_player [Integer, Player] the vs player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team vs player statistics
    def self.overall(team:, vs_player:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: OVERALL}
      fetch_stats(team, vs_player, season, options, client: client)
    end

    # Retrieves on/off court comparison statistics for team vs player
    #
    # @api public
    # @example
    #   stats = NBA::TeamVsPlayer.on_off_court(team: 1610612744, vs_player: 201566)
    #   stats.each { |s| puts "#{s.court_status}: #{s.pts}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param vs_player [Integer, Player] the vs player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team vs player statistics
    def self.on_off_court(team:, vs_player:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      options = {season_type: season_type, per_mode: per_mode, result_set: ON_OFF_COURT}
      fetch_stats(team, vs_player, season, options, client: client)
    end

    # Fetches team vs player statistics from the API
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.fetch_stats(team, vs_player, season, options, client:)
      path = build_path(team, vs_player, season, options.fetch(:season_type), options.fetch(:per_mode))
      response = client.get(path)
      parse_response(response, options.fetch(:result_set))
    end
    private_class_method :fetch_stats

    # Builds the API request path with all parameters
    #
    # @api private
    # @return [String] the API request path
    def self.build_path(team, vs_player, season, season_type, per_mode)
      team_id = Utils.extract_id(team)
      vs_player_id = Utils.extract_id(vs_player)
      season_str = Utils.format_season(season)
      "teamvsplayer?TeamID=#{team_id}&VsPlayerID=#{vs_player_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response and extracts the result set
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.parse_response(response, result_set_name)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      build_collection(result_set)
    end
    private_class_method :parse_response

    # Finds the result set matching the given name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil
    def self.find_result_set(data, result_set_name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(result_set_name) }
    end
    private_class_method :find_result_set

    # Builds a collection from the result set data
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.build_collection(result_set)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_team_vs_player_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a stat object from the data hash
    #
    # @api private
    # @return [TeamVsPlayerStat] the stat object
    def self.build_team_vs_player_stat(data)
      TeamVsPlayerStat.new(**identity_info(data), **stat_info(data))
    end
    private_class_method :build_team_vs_player_stat

    # Extracts identity information from the data hash
    #
    # @api private
    # @return [Hash] the identity attributes
    def self.identity_info(data)
      {team_id: data["TEAM_ID"], vs_player_id: data["VS_PLAYER_ID"],
       court_status: data["COURT_STATUS"], gp: data["GP"], min: data["MIN"]}
    end
    private_class_method :identity_info

    # Extracts stat information from the data hash
    #
    # @api private
    # @return [Hash] the stat attributes
    def self.stat_info(data)
      {pts: data["PTS"], reb: data["REB"], ast: data["AST"], stl: data["STL"],
       blk: data["BLK"], tov: data["TOV"], fg_pct: data["FG_PCT"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :stat_info
  end
end
