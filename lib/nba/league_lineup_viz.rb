require "json"
require_relative "client"
require_relative "collection"
require_relative "league_lineup_viz_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league lineup visualization statistics
  #
  # @api public
  module LeagueLineupViz
    # Result set name for lineup visualization
    # @return [String] the result set name
    LEAGUE_LINEUP_VIZ = "LeagueLineupViz".freeze

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

    # Base measure type constant
    # @return [String] the measure type
    BASE = "Base".freeze

    # Advanced measure type constant
    # @return [String] the measure type
    ADVANCED = "Advanced".freeze

    # Group quantity for 5-man lineups
    # @return [Integer] the group quantity
    FIVE_MAN = 5

    # Group quantity for 4-man lineups
    # @return [Integer] the group quantity
    FOUR_MAN = 4

    # Group quantity for 3-man lineups
    # @return [Integer] the group quantity
    THREE_MAN = 3

    # Group quantity for 2-man lineups
    # @return [Integer] the group quantity
    TWO_MAN = 2

    # Retrieves all league lineup visualization statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueLineupViz.all(season: 2024)
    #   stats.first.group_name #=> "S. Curry - K. Thompson - ..."
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param measure_type [String] the measure type
    # @param group_quantity [Integer] the lineup size
    # @param minutes_min [Integer] minimum minutes filter
    # @param client [Client] the API client to use
    # @return [Collection] a collection of lineup visualization statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME,
      measure_type: BASE, group_quantity: FIVE_MAN, minutes_min: 0, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode, measure_type: measure_type,
        group_quantity: group_quantity, minutes_min: minutes_min)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguelineupviz?LeagueID=00&Season=#{season_str}&SeasonType=#{opts.fetch(:season_type)}" \
        "&PerMode=#{opts.fetch(:per_mode)}&MeasureType=#{opts.fetch(:measure_type)}" \
        "&GroupQuantity=#{opts.fetch(:group_quantity)}&MinutesMin=#{opts.fetch(:minutes_min)}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of lineup visualization stats
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
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(LEAGUE_LINEUP_VIZ) }
    end
    private_class_method :find_result_set

    # Builds stats collection from result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_stats(result_set)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_stats

    # Builds a single stat object from API data
    #
    # @api private
    # @return [LeagueLineupVizStat] the stat object
    def self.build_stat(data)
      LeagueLineupVizStat.new(**identity_info(data), **rating_info(data), **shooting_info(data),
        **opponent_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {group_id: data["GROUP_ID"], group_name: data["GROUP_NAME"],
       team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"]}
    end
    private_class_method :identity_info

    # Extracts rating information from data
    #
    # @api private
    # @return [Hash] the rating information hash
    def self.rating_info(data)
      {min: data["MIN"], off_rating: data["OFF_RATING"],
       def_rating: data["DEF_RATING"], net_rating: data["NET_RATING"],
       pace: data["PACE"], ts_pct: data["TS_PCT"],
       fta_rate: data["FTA_RATE"], tm_ast_pct: data["TM_AST_PCT"]}
    end
    private_class_method :rating_info

    # Extracts shooting information from data
    #
    # @api private
    # @return [Hash] the shooting information hash
    def self.shooting_info(data)
      {pct_fga_2pt: data["PCT_FGA_2PT"], pct_fga_3pt: data["PCT_FGA_3PT"],
       pct_pts_2pt_mr: data["PCT_PTS_2PT_MR"], pct_pts_fb: data["PCT_PTS_FB"],
       pct_pts_ft: data["PCT_PTS_FT"], pct_pts_paint: data["PCT_PTS_PAINT"],
       pct_ast_fgm: data["PCT_AST_FGM"], pct_uast_fgm: data["PCT_UAST_FGM"]}
    end
    private_class_method :shooting_info

    # Extracts opponent stats information from data
    #
    # @api private
    # @return [Hash] the opponent stats information hash
    def self.opponent_info(data)
      {opp_fg3_pct: data["OPP_FG3_PCT"], opp_efg_pct: data["OPP_EFG_PCT"],
       opp_fta_rate: data["OPP_FTA_RATE"], opp_tov_pct: data["OPP_TOV_PCT"]}
    end
    private_class_method :opponent_info
  end
end
