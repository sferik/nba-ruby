require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_team_pt_shot_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide opponent tracking shot statistics (defensive)
  #
  # @api public
  module LeagueDashOppPtShot
    # Result set name for league dash opponent PT shots
    # @return [String] the result set name
    LEAGUE_DASH_PT_SHOTS = "LeagueDashPTShots".freeze

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

    # Retrieves all league-wide opponent tracking shot statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashOppPtShot.all(season: 2024)
    #   stats.first.fg_pct #=> 0.472
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of opponent tracking shot statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguedashoppptshot?LeagueID=00&Season=#{season_str}" \
        "&SeasonType=#{opts.fetch(:season_type)}&PerMode=#{opts.fetch(:per_mode)}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of opponent PT shot stats
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

      result_sets.find { |rs| rs.fetch("name", nil).eql?(LEAGUE_DASH_PT_SHOTS) }
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
    # @return [LeagueDashTeamPtShotStat] the stat object
    def self.build_stat(data)
      LeagueDashTeamPtShotStat.new(**identity_info(data), **shooting_info(data), **two_point_info(data),
        **three_point_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), gp: data.fetch("GP", nil), g: data.fetch("G", nil)}
    end
    private_class_method :identity_info

    # Extracts shooting information from data
    #
    # @api private
    # @return [Hash] the shooting information hash
    def self.shooting_info(data)
      {fga_frequency: data.fetch("FGA_FREQUENCY", nil), fgm: data.fetch("FGM", nil),
       fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil), efg_pct: data.fetch("EFG_PCT", nil)}
    end
    private_class_method :shooting_info

    # Extracts 2-point shooting information from data
    #
    # @api private
    # @return [Hash] the 2-point shooting information hash
    def self.two_point_info(data)
      {fg2a_frequency: data.fetch("FG2A_FREQUENCY", nil), fg2m: data.fetch("FG2M", nil),
       fg2a: data.fetch("FG2A", nil), fg2_pct: data.fetch("FG2_PCT", nil)}
    end
    private_class_method :two_point_info

    # Extracts 3-point shooting information from data
    #
    # @api private
    # @return [Hash] the 3-point shooting information hash
    def self.three_point_info(data)
      {fg3a_frequency: data.fetch("FG3A_FREQUENCY", nil), fg3m: data.fetch("FG3M", nil),
       fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil)}
    end
    private_class_method :three_point_info
  end
end
