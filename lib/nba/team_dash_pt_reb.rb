require "json"
require_relative "client"
require_relative "collection"
require_relative "team_rebound_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve team tracking rebound statistics
  #
  # @api public
  module TeamDashPtReb
    # Result set name for number contested rebounding
    # @return [String] the result set name
    NUM_CONTESTED = "NumContestedRebounding".freeze

    # Result set name for overall rebounding
    # @return [String] the result set name
    OVERALL = "OverallRebounding".freeze

    # Result set name for rebound distance rebounding
    # @return [String] the result set name
    REB_DISTANCE = "RebDistanceRebounding".freeze

    # Result set name for shot distance rebounding
    # @return [String] the result set name
    SHOT_DISTANCE = "ShotDistanceRebounding".freeze

    # Result set name for shot type rebounding
    # @return [String] the result set name
    SHOT_TYPE = "ShotTypeRebounding".freeze

    # Retrieves number contested rebounding stats for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtReb.num_contested(team: 1610612744)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.num_contested(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, NUM_CONTESTED, client: client)
    end

    # Retrieves overall rebounding stats for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtReb.overall(team: 1610612744)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.overall(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, OVERALL, client: client)
    end

    # Retrieves rebound distance rebounding stats for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtReb.reb_distance(team: 1610612744)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.reb_distance(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, REB_DISTANCE, client: client)
    end

    # Retrieves shot distance rebounding stats for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtReb.shot_distance(team: 1610612744)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.shot_distance(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, SHOT_DISTANCE, client: client)
    end

    # Retrieves shot type rebounding stats for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtReb.shot_type(team: 1610612744)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rebound statistics
    def self.shot_type(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, SHOT_TYPE, client: client)
    end

    # Fetches rebound stats from the API
    #
    # @api private
    # @return [Collection] collection of rebound stats
    def self.fetch_stats(team, season, season_type, per_mode, result_set_name, client:)
      path = build_path(team, season, season_type, per_mode)
      response = client.get(path)
      parse_response(response, result_set_name)
    end
    private_class_method :fetch_stats

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(team, season, season_type, per_mode)
      team_id = Utils.extract_id(team)
      season_str = Utils.format_season(season)
      "teamdashptreb?TeamID=#{team_id}&Season=#{season_str}" \
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
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(result_set_name) }
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

      Collection.new(rows.map { |row| build_rebound_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a rebound stat from API data
    #
    # @api private
    # @return [TeamReboundStat] the rebound stat object
    def self.build_rebound_stat(data)
      TeamReboundStat.new(**identity_info(data), **range_info(data), **rebound_info(data))
    end
    private_class_method :build_rebound_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       sort_order: data["SORT_ORDER"], g: data["G"]}
    end
    private_class_method :identity_info

    # Extracts range information from data
    #
    # @api private
    # @return [Hash] the range information hash
    def self.range_info(data)
      {reb_num_contesting_range: data["REB_NUM_CONTESTING_RANGE"], overall: data["OVERALL"],
       reb_dist_range: data["REB_DIST_RANGE"], shot_dist_range: data["SHOT_DIST_RANGE"],
       shot_type_range: data["SHOT_TYPE_RANGE"], reb_frequency: data["REB_FREQUENCY"]}
    end
    private_class_method :range_info

    # Extracts rebound information from data
    #
    # @api private
    # @return [Hash] the rebound information hash
    def self.rebound_info(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       c_oreb: data["C_OREB"], c_dreb: data["C_DREB"], c_reb: data["C_REB"], c_reb_pct: data["C_REB_PCT"],
       uc_oreb: data["UC_OREB"], uc_dreb: data["UC_DREB"], uc_reb: data["UC_REB"], uc_reb_pct: data["UC_REB_PCT"]}
    end
    private_class_method :rebound_info
  end
end
