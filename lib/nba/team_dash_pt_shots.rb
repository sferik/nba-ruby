require "json"
require_relative "client"
require_relative "collection"
require_relative "team_shot_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve team tracking shot statistics
  #
  # @api public
  module TeamDashPtShots
    # Result set name for general shooting
    # @return [String] the result set name
    GENERAL = "GeneralShooting".freeze

    # Result set name for shot clock shooting
    # @return [String] the result set name
    SHOT_CLOCK = "ShotClockShooting".freeze

    # Result set name for dribble shooting
    # @return [String] the result set name
    DRIBBLE = "DribbleShooting".freeze

    # Result set name for closest defender shooting
    # @return [String] the result set name
    CLOSEST_DEFENDER = "ClosestDefenderShooting".freeze

    # Result set name for closest defender 10ft+ shooting
    # @return [String] the result set name
    CLOSEST_DEFENDER_10FT = "ClosestDefender10ftPlusShooting".freeze

    # Result set name for touch time shooting
    # @return [String] the result set name
    TOUCH_TIME = "TouchTimeShooting".freeze

    # Retrieves general shot statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtShots.general(team: 1610612744)
    #   stats.each { |s| puts "#{s.shot_type}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shot statistics
    def self.general(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, GENERAL, client: client)
    end

    # Retrieves shot clock shot statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtShots.shot_clock(team: 1610612744)
    #   stats.each { |s| puts "#{s.shot_type}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shot statistics
    def self.shot_clock(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, SHOT_CLOCK, client: client)
    end

    # Retrieves dribble shot statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtShots.dribble(team: 1610612744)
    #   stats.each { |s| puts "#{s.shot_type}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shot statistics
    def self.dribble(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, DRIBBLE, client: client)
    end

    # Retrieves closest defender shot statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtShots.closest_defender(team: 1610612744)
    #   stats.each { |s| puts "#{s.shot_type}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shot statistics
    def self.closest_defender(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, CLOSEST_DEFENDER, client: client)
    end

    # Retrieves closest defender 10ft+ shot statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtShots.closest_defender_10ft(team: 1610612744)
    #   stats.each { |s| puts "#{s.shot_type}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shot statistics
    def self.closest_defender_10ft(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, CLOSEST_DEFENDER_10FT, client: client)
    end

    # Retrieves touch time shot statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashPtShots.touch_time(team: 1610612744)
    #   stats.each { |s| puts "#{s.shot_type}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shot statistics
    def self.touch_time(team:, season: Utils.current_season, season_type: "Regular Season",
      per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, TOUCH_TIME, client: client)
    end

    # Fetches shot stats from the API
    #
    # @api private
    # @return [Collection] collection of shot stats
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
      "teamdashptshots?TeamID=#{team_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into shot stat objects
    #
    # @api private
    # @return [Collection] collection of shot stats
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

      Collection.new(rows.map { |row| build_shot_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a shot stat from API data
    #
    # @api private
    # @return [TeamShotStat] the shot stat object
    def self.build_shot_stat(data)
      TeamShotStat.new(**identity_info(data), **shot_info(data), **shooting_info(data))
    end
    private_class_method :build_shot_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       team_abbreviation: data["TEAM_ABBREVIATION"],
       sort_order: data["SORT_ORDER"], g: data["G"]}
    end
    private_class_method :identity_info

    # Extracts shot information from data
    #
    # @api private
    # @return [Hash] the shot information hash
    def self.shot_info(data)
      {shot_type: data["SHOT_TYPE"], fga_frequency: data["FGA_FREQUENCY"],
       fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       efg_pct: data["EFG_PCT"]}
    end
    private_class_method :shot_info

    # Extracts shooting information from data
    #
    # @api private
    # @return [Hash] the shooting information hash
    def self.shooting_info(data)
      {fg2a_frequency: data["FG2A_FREQUENCY"], fg2m: data["FG2M"],
       fg2a: data["FG2A"], fg2_pct: data["FG2_PCT"],
       fg3a_frequency: data["FG3A_FREQUENCY"], fg3m: data["FG3M"],
       fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"]}
    end
    private_class_method :shooting_info
  end
end
