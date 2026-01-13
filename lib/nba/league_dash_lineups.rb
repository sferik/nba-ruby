require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_lineup_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide lineup statistics
  #
  # @api public
  module LeagueDashLineups
    # Result set name for lineups
    # @return [String] the result set name
    LINEUPS = "Lineups".freeze

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

    # Per 100 possessions mode constant
    # @return [String] the per mode
    PER_100 = "Per100Possessions".freeze

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

    # Retrieves all league-wide lineup statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashLineups.all(season: 2024)
    #   stats.first.group_name #=> "S. Curry - K. Thompson - ..."
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param group_quantity [Integer] the lineup size
    # @param client [Client] the API client to use
    # @return [Collection] a collection of lineup statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME,
      group_quantity: FIVE_MAN, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode, group_quantity: group_quantity)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      "leaguedashlineups?LeagueID=00&Season=#{season_str}&SeasonType=#{opts.fetch(:season_type)}" \
        "&PerMode=#{opts.fetch(:per_mode)}&GroupQuantity=#{opts.fetch(:group_quantity)}" \
        "&MeasureType=Base&PlusMinus=N&PaceAdjust=N&Rank=N"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of lineup stats
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

      result_sets.find { |rs| rs["name"].eql?(LINEUPS) }
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
    # @return [LeagueDashLineupStat] the stat object
    def self.build_stat(data)
      LeagueDashLineupStat.new(**identity_info(data), **record_info(data), **shooting_info(data),
        **counting_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {group_set: data["GROUP_SET"], group_id: data["GROUP_ID"],
       group_name: data["GROUP_NAME"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"]}
    end
    private_class_method :identity_info

    # Extracts record information from data
    #
    # @api private
    # @return [Hash] the record information hash
    def self.record_info(data)
      {gp: data["GP"], w: data["W"], l: data["L"],
       w_pct: data["W_PCT"], min: data["MIN"]}
    end
    private_class_method :record_info

    # Extracts shooting information from data
    #
    # @api private
    # @return [Hash] the shooting information hash
    def self.shooting_info(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_info

    # Extracts counting information from data
    #
    # @api private
    # @return [Hash] the counting information hash
    def self.counting_info(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], tov: data["TOV"], stl: data["STL"],
       blk: data["BLK"], blka: data["BLKA"], pf: data["PF"],
       pfd: data["PFD"], pts: data["PTS"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_info
  end
end
