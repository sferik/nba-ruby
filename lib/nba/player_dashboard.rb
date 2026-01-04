require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents player dashboard split statistics
  class PlayerDashboardStat < Shale::Mapper
    include Equalizer.new(:player_id, :group_value)

    # @!attribute [rw] group_set
    #   Returns the group set name
    #   @api public
    #   @example
    #     stat.group_set #=> "Overall"
    #   @return [String] the group set
    attribute :group_set, Shale::Type::String

    # @!attribute [rw] group_value
    #   Returns the group value
    #   @api public
    #   @example
    #     stat.group_value #=> "2023-24"
    #   @return [String] the group value
    attribute :group_value, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 28
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.622
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes per game
    #   @api public
    #   @example
    #     stat.min #=> 32.7
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 10.0
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 19.6
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.451
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stat.fg3m #=> 4.8
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stat.fg3a #=> 11.7
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.408
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 4.8
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 5.1
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.921
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 0.7
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 4.5
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 5.1
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 5.1
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 2.8
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 0.7
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 0.4
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts per game
    #   @api public
    #   @example
    #     stat.blka #=> 0.3
    #   @return [Float] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 1.6
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn per game
    #   @api public
    #   @example
    #     stat.pfd #=> 1.9
    #   @return [Float] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 26.4
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus per game
    #   @api public
    #   @example
    #     stat.plus_minus #=> 7.8
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end
  end

  # Provides methods to retrieve player dashboard data with various splits
  module PlayerDashboard
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

    # Per mode constant for per 36 minutes
    # @return [String] the per mode
    PER_36 = "Per36".freeze

    # Retrieves player dashboard by general splits
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashboard.general_splits(player: 201939)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.general_splits(player:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(player, season, season_type, per_mode, "playerdashboardbygeneralsplits", client: client)
    end

    # Retrieves player dashboard by clutch splits
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashboard.clutch_splits(player: 201939)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.clutch_splits(player:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(player, season, season_type, per_mode, "playerdashboardbyclutch", client: client)
    end

    # Retrieves player dashboard by shooting splits
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashboard.shooting_splits(player: 201939)
    #   stats.each { |s| puts "#{s.group_value}: #{s.fg_pct}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.shooting_splits(player:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(player, season, season_type, per_mode, "playerdashboardbyshootingsplits", client: client)
    end

    # Retrieves player dashboard by game splits
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashboard.game_splits(player: 201939)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.game_splits(player:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(player, season, season_type, per_mode, "playerdashboardbygamesplits", client: client)
    end

    # Retrieves player dashboard by last N games
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashboard.last_n_games(player: 201939)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.last_n_games(player:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(player, season, season_type, per_mode, "playerdashboardbylastngames", client: client)
    end

    # Retrieves player dashboard by year over year
    #
    # @api public
    # @example
    #   stats = NBA::PlayerDashboard.year_over_year(player: 201939)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} ppg" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dashboard stats
    def self.year_over_year(player:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      fetch_dashboard(player, season, season_type, per_mode, "playerdashboardbyyearoveryear", client: client)
    end

    # Fetches dashboard data from the API
    #
    # @api private
    # @return [Collection] collection of dashboard stats
    def self.fetch_dashboard(player, season, season_type, per_mode, endpoint, client:)
      player_id = Utils.extract_id(player)
      path = build_path(player_id, season, season_type, per_mode, endpoint)
      response = client.get(path)
      parse_response(response, player_id)
    end
    private_class_method :fetch_dashboard

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(player_id, season, season_type, per_mode, endpoint)
      season_str = Utils.format_season(season)
      "#{endpoint}?PlayerID=#{player_id}&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into dashboard stat objects
    #
    # @api private
    # @return [Collection] collection of dashboard stats
    def self.parse_response(response, player_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_sets = data.fetch("resultSets", nil)
      return Collection.new unless result_sets

      all_stats = result_sets.flat_map { |rs| parse_result_set(rs, player_id) }
      Collection.new(all_stats)
    end
    private_class_method :parse_response

    # Parses a result set into stat objects
    #
    # @api private
    # @return [Array<PlayerDashboardStat>] array of stats
    def self.parse_result_set(result_set, player_id)
      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      group_set = result_set.fetch("name", nil)
      return [] unless headers && rows

      rows.map { |row| build_dashboard_stat(headers, row, group_set, player_id) }
    end
    private_class_method :parse_result_set

    # Builds a PlayerDashboardStat object from raw data
    #
    # @api private
    # @return [PlayerDashboardStat] the dashboard stat object
    def self.build_dashboard_stat(headers, row, group_set, player_id)
      data = headers.zip(row).to_h
      PlayerDashboardStat.new(**dashboard_attributes(data, group_set, player_id))
    end
    private_class_method :build_dashboard_stat

    # Combines all dashboard attributes
    #
    # @api private
    # @return [Hash] the combined attributes
    def self.dashboard_attributes(data, group_set, player_id)
      identity_attributes(data, group_set, player_id)
        .merge(record_attributes(data))
        .merge(shooting_attributes(data))
        .merge(counting_attributes(data))
    end
    private_class_method :dashboard_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data, group_set, player_id)
      {group_set: group_set, group_value: data.fetch("GROUP_VALUE", nil),
       player_id: player_id, gp: data.fetch("GP", nil), min: data.fetch("MIN", nil)}
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
