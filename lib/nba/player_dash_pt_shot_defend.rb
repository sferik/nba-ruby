require "json"
require_relative "client"
require_relative "collection"
require_relative "defensive_shot_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player tracking defensive shot statistics
  #
  # @api public
  module PlayerDashPtShotDefend
    # Result set name for defending shots
    # @return [String] the result set name
    DEFENDING_SHOTS = "DefendingShots".freeze

    # Retrieves defensive shot statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashPtShotDefend.find(player: 201939)
    #   stats.each { |s| puts "#{s.defense_category}: #{s.d_fg_pct}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of defensive shot statistics
    def self.find(player:, team: 0, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      path = build_path(player, team, season, season_type, per_mode)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(player, team, season, season_type, per_mode)
      player_id = Utils.extract_id(player)
      team_id = Utils.extract_id(team)
      season_str = Utils.format_season(season)
      "playerdashptshotdefend?PlayerID=#{player_id}&TeamID=#{team_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into defensive shot stat objects
    #
    # @api private
    # @return [Collection] collection of defensive shot stats
    def self.parse_response(response)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data)
      build_collection(result_set)
    end
    private_class_method :parse_response

    # Finds the defending shots result set
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil if not found
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(DEFENDING_SHOTS) }
    end
    private_class_method :find_result_set

    # Builds a collection from a result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_collection(result_set)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_defensive_shot_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a defensive shot stat from API data
    #
    # @api private
    # @return [DefensiveShotStat] the defensive shot stat object
    def self.build_defensive_shot_stat(data)
      DefensiveShotStat.new(**identity_info(data), **defense_info(data))
    end
    private_class_method :build_defensive_shot_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {close_def_person_id: data["CLOSE_DEF_PERSON_ID"], gp: data["GP"],
       g: data["G"], defense_category: data["DEFENSE_CATEGORY"]}
    end
    private_class_method :identity_info

    # Extracts defense information from data
    #
    # @api private
    # @return [Hash] the defense information hash
    def self.defense_info(data)
      {freq: data["FREQ"], d_fgm: data["D_FGM"], d_fga: data["D_FGA"],
       d_fg_pct: data["D_FG_PCT"], normal_fg_pct: data["NORMAL_FG_PCT"],
       pct_plusminus: data["PCT_PLUSMINUS"]}
    end
    private_class_method :defense_info
  end
end
