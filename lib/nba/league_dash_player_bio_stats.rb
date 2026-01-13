require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_player_bio_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide player biographical statistics
  #
  # @api public
  module LeagueDashPlayerBioStats
    # Result set name for league dash player bio stats
    # @return [String] the result set name
    LEAGUE_DASH_PLAYER_BIO_STATS = "LeagueDashPlayerBioStats".freeze

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

    # Retrieves all league-wide player biographical statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashPlayerBioStats.all(season: 2024)
    #   stats.first.college #=> "Davidson"
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player biographical statistics
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
      "leaguedashplayerbiostats?LeagueID=00&Season=#{season_str}" \
        "&SeasonType=#{opts.fetch(:season_type)}&PerMode=#{opts.fetch(:per_mode)}"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of player bio stats
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

      result_sets.find { |rs| rs["name"].eql?(LEAGUE_DASH_PLAYER_BIO_STATS) }
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
    # @return [LeagueDashPlayerBioStat] the stat object
    def self.build_stat(data)
      LeagueDashPlayerBioStat.new(**identity_info(data), **physical_info(data), **draft_info(data),
        **stat_info(data), **advanced_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       age: data["AGE"]}
    end
    private_class_method :identity_info

    # Extracts physical information from data
    #
    # @api private
    # @return [Hash] the physical information hash
    def self.physical_info(data)
      {player_height: data["PLAYER_HEIGHT"],
       player_height_inches: data["PLAYER_HEIGHT_INCHES"],
       player_weight: data["PLAYER_WEIGHT"], college: data["COLLEGE"],
       country: data["COUNTRY"]}
    end
    private_class_method :physical_info

    # Extracts draft information from data
    #
    # @api private
    # @return [Hash] the draft information hash
    def self.draft_info(data)
      {draft_year: data["DRAFT_YEAR"], draft_round: data["DRAFT_ROUND"],
       draft_number: data["DRAFT_NUMBER"]}
    end
    private_class_method :draft_info

    # Extracts basic stat information from data
    #
    # @api private
    # @return [Hash] the stat information hash
    def self.stat_info(data)
      {gp: data["GP"], pts: data["PTS"], reb: data["REB"],
       ast: data["AST"]}
    end
    private_class_method :stat_info

    # Extracts advanced stat information from data
    #
    # @api private
    # @return [Hash] the advanced stat information hash
    def self.advanced_info(data)
      {net_rating: data["NET_RATING"], oreb_pct: data["OREB_PCT"],
       dreb_pct: data["DREB_PCT"], usg_pct: data["USG_PCT"],
       ts_pct: data["TS_PCT"], ast_pct: data["AST_PCT"]}
    end
    private_class_method :advanced_info
  end
end
