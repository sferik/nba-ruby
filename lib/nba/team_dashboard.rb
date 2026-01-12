require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "team_dashboard_stat"

module NBA
  # Provides methods to retrieve team dashboard data with various splits
  module TeamDashboard
    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Per mode constant for per 100 possessions
    # @return [String] the per mode
    PER_100 = "Per100Possessions".freeze

    # Retrieves team dashboard by general splits
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.general_splits(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.general_splits(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbygeneralsplits", client: client)
    end

    # Retrieves team dashboard by shooting splits
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.shooting_splits(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.fg_pct}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.shooting_splits(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbyshootingsplits", client: client)
    end

    # Retrieves team lineup data
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.lineups(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.lineups(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashlineups", client: client)
    end

    # Retrieves team dashboard by clutch splits
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.clutch_splits(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.clutch_splits(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbyclutch", client: client)
    end

    # Retrieves team dashboard by game splits
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.game_splits(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.game_splits(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbygamesplits", client: client)
    end

    # Retrieves team dashboard by last N games
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.last_n_games(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.last_n_games(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbylastngames", client: client)
    end

    # Retrieves team dashboard by team performance
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.team_performance(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.team_performance(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbyteamperformance", client: client)
    end

    # Retrieves team dashboard by year over year
    #
    # @api public
    # @example
    #   stats = NBA::TeamDashboard.year_over_year(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.year_over_year(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(team, season, season_type, per_mode, "teamdashboardbyyearoveryear", client: client)
    end

    # Fetches dashboard data from the API
    #
    # @api private
    # @return [Collection] collection of dashboard stats
    def self.fetch_dashboard(team, season, season_type, per_mode, endpoint, client:)
      team_id = Utils.extract_id(team)
      path = build_path(team_id, season, season_type, per_mode, endpoint)
      response = client.get(path)
      parse_response(response, team_id)
    end
    private_class_method :fetch_dashboard

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(team_id, season, season_type, per_mode, endpoint)
      season_str = Utils.format_season(season)
      "#{endpoint}?TeamID=#{team_id}&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into dashboard stat objects
    #
    # @api private
    # @return [Collection] collection of dashboard stats
    def self.parse_response(response, team_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_sets = data.fetch("resultSets", nil)
      return Collection.new unless result_sets

      all_stats = result_sets.flat_map { |rs| parse_result_set(rs, team_id) }
      Collection.new(all_stats)
    end
    private_class_method :parse_response

    # Parses a result set into stat objects
    #
    # @api private
    # @return [Array<TeamDashboardStat>] array of stats
    def self.parse_result_set(result_set, team_id)
      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      group_set = result_set.fetch("name", nil)
      return [] unless headers && rows

      rows.map { |row| build_dashboard_stat(headers, row, group_set, team_id) }
    end
    private_class_method :parse_result_set

    # Builds a TeamDashboardStat object from raw data
    #
    # @api private
    # @return [TeamDashboardStat] the dashboard stat object
    def self.build_dashboard_stat(headers, row, group_set, team_id)
      data = headers.zip(row).to_h
      TeamDashboardStat.new(**dashboard_attributes(data, group_set, team_id))
    end
    private_class_method :build_dashboard_stat

    # Combines all dashboard attributes
    #
    # @api private
    # @return [Hash] the combined attributes
    def self.dashboard_attributes(data, group_set, team_id)
      identity_attributes(data, group_set, team_id)
        .merge(record_attributes(data))
        .merge(shooting_attributes(data))
        .merge(counting_attributes(data))
    end
    private_class_method :dashboard_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data, group_set, team_id)
      {group_set: group_set, group_value: data.fetch("GROUP_VALUE", nil),
       team_id: team_id, gp: data.fetch("GP", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_attributes

    # Extracts record attributes from data
    #
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {w: data.fetch("W", nil), l: data.fetch("L", nil), w_pct: data.fetch("W_PCT", nil)}
    end
    private_class_method :record_attributes

    # Extracts shooting attributes from data
    #
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    #
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), tov: data.fetch("TOV", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       blka: data.fetch("BLKA", nil), pf: data.fetch("PF", nil), pfd: data.fetch("PFD", nil),
       pts: data.fetch("PTS", nil), plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_attributes
  end
end
