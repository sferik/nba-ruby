require "json"
require_relative "client"
require_relative "collection"
require_relative "league_season_matchup_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide season matchup statistics
  #
  # @api public
  module LeagueSeasonMatchups
    # Result set name for season matchups
    # @return [String] the result set name
    SEASON_MATCHUPS = "SeasonMatchups".freeze

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

    # Retrieves all league-wide season matchup statistics
    #
    # @api public
    # @example
    #   matchups = NBA::LeagueSeasonMatchups.all(season: 2024)
    #   matchups.first.off_player_name #=> "Stephen Curry"
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param off_player [Integer, #id, nil] offensive player ID or object
    # @param def_player [Integer, #id, nil] defensive player ID or object
    # @param off_team [Integer, #id, nil] offensive team ID or object
    # @param def_team [Integer, #id, nil] defensive team ID or object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of matchup statistics
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME,
      off_player: nil, def_player: nil, off_team: nil, def_team: nil, client: CLIENT)
      path = build_path(season, season_type: season_type, per_mode: per_mode,
        off_player: off_player, def_player: def_player, off_team: off_team, def_team: def_team)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(season, opts)
      season_str = Utils.format_season(season)
      path = "leagueseasonmatchups?LeagueID=00&Season=#{season_str}" \
             "&SeasonType=#{opts.fetch(:season_type)}&PerMode=#{opts.fetch(:per_mode)}"
      append_optional_params(path, opts)
    end
    private_class_method :build_path

    # Appends optional parameters to the path
    #
    # @api private
    # @return [String] the path with optional parameters
    def self.append_optional_params(path, opts)
      off_player_id = Utils.extract_id(opts.fetch(:off_player))
      def_player_id = Utils.extract_id(opts.fetch(:def_player))
      off_team_id = Utils.extract_id(opts.fetch(:off_team))
      def_team_id = Utils.extract_id(opts.fetch(:def_team))

      path += "&OffPlayerID=#{off_player_id}" if off_player_id
      path += "&DefPlayerID=#{def_player_id}" if def_player_id
      path += "&OffTeamID=#{off_team_id}" if off_team_id
      path += "&DefTeamID=#{def_team_id}" if def_team_id
      path
    end
    private_class_method :append_optional_params

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of matchup stats
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

      result_sets.find { |rs| rs["name"].eql?(SEASON_MATCHUPS) }
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
    # @return [LeagueSeasonMatchupStat] the stat object
    def self.build_stat(data)
      LeagueSeasonMatchupStat.new(**identity_info(data), **matchup_stats(data), **shooting_stats(data),
        **help_stats(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {season_id: data["SEASON_ID"], off_player_id: data["OFF_PLAYER_ID"],
       off_player_name: data["OFF_PLAYER_NAME"], def_player_id: data["DEF_PLAYER_ID"],
       def_player_name: data["DEF_PLAYER_NAME"], gp: data["GP"]}
    end
    private_class_method :identity_info

    # Extracts matchup statistics from data
    #
    # @api private
    # @return [Hash] the matchup statistics hash
    def self.matchup_stats(data)
      {matchup_min: data["MATCHUP_MIN"], partial_poss: data["PARTIAL_POSS"],
       player_pts: data["PLAYER_PTS"], team_pts: data["TEAM_PTS"],
       matchup_ast: data["MATCHUP_AST"], matchup_tov: data["MATCHUP_TOV"],
       matchup_blk: data["MATCHUP_BLK"]}
    end
    private_class_method :matchup_stats

    # Extracts shooting statistics from data
    #
    # @api private
    # @return [Hash] the shooting statistics hash
    def self.shooting_stats(data)
      {matchup_fgm: data["MATCHUP_FGM"], matchup_fga: data["MATCHUP_FGA"],
       matchup_fg_pct: data["MATCHUP_FG_PCT"], matchup_fg3m: data["MATCHUP_FG3M"],
       matchup_fg3a: data["MATCHUP_FG3A"], matchup_fg3_pct: data["MATCHUP_FG3_PCT"],
       matchup_ftm: data["MATCHUP_FTM"], matchup_fta: data["MATCHUP_FTA"],
       sfl: data["SFL"]}
    end
    private_class_method :shooting_stats

    # Extracts help defense statistics from data
    #
    # @api private
    # @return [Hash] the help defense statistics hash
    def self.help_stats(data)
      {help_blk: data["HELP_BLK"], help_fgm: data["HELP_FGM"],
       help_fga: data["HELP_FGA"], help_fg_pct: data["HELP_FG_PERC"]}
    end
    private_class_method :help_stats
  end
end
