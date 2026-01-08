require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_pt_team_defend_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide team defensive tracking statistics
  #
  # @api public
  module LeagueDashPtTeamDefend
    # Result set name for league dash PT team defend
    # @return [String] the result set name
    LEAGUE_DASH_PT_TEAM_DEFEND = "LeagueDashPtTeamDefend".freeze

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

    # Overall defense category constant
    # @return [String] the defense category
    OVERALL = "Overall".freeze

    # 3 Pointers defense category constant
    # @return [String] the defense category
    THREE_POINTERS = "3 Pointers".freeze

    # 2 Pointers defense category constant
    # @return [String] the defense category
    TWO_POINTERS = "2 Pointers".freeze

    # Less than 6ft defense category constant
    # @return [String] the defense category
    LESS_THAN_6FT = "Less Than 6Ft".freeze

    # Less than 10ft defense category constant
    # @return [String] the defense category
    LESS_THAN_10FT = "Less Than 10Ft".freeze

    # Greater than 15ft defense category constant
    # @return [String] the defense category
    GREATER_THAN_15FT = "Greater Than 15Ft".freeze

    # Retrieves all league-wide team defensive tracking statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPtTeamDefend.all(season: 2024)
    #   stats.first.d_fg_pct #=> 0.421
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param defense_category [String] the defense category
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team defensive statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME,
      defense_category: OVERALL, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode, defense_category: defense_category)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguedashptteamdefend?LeagueID=00&Season=#{season_str}" \
        "&SeasonType=#{opts.fetch(:season_type)}" \
        "&PerMode=#{opts.fetch(:per_mode)}&DefenseCategory=#{opts.fetch(:defense_category)}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of PT team defend stats
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

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_DASH_PT_TEAM_DEFEND) }
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
    # @return [LeagueDashPtTeamDefendStat] the stat object
    def self.build_stat(data)
      LeagueDashPtTeamDefendStat.new(**identity_info(data), **defensive_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       gp: data.fetch("GP", nil), g: data.fetch("G", nil)}
    end
    private_class_method :identity_info

    # Extracts defensive statistics information from data
    #
    # @api private
    # @return [Hash] the defensive statistics hash
    def self.defensive_info(data)
      {freq: data.fetch("FREQ", nil), d_fgm: data.fetch("D_FGM", nil), d_fga: data.fetch("D_FGA", nil),
       d_fg_pct: data.fetch("D_FG_PCT", nil), normal_fg_pct: data.fetch("NORMAL_FG_PCT", nil),
       pct_plusminus: data.fetch("PCT_PLUSMINUS", nil)}
    end
    private_class_method :defensive_info
  end
end
