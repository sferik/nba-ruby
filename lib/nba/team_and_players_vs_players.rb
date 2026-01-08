require "json"
require_relative "client"
require_relative "collection"
require_relative "team_and_players_vs_players_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve team and players vs players statistics
  #
  # @api public
  module TeamAndPlayersVsPlayers
    # Result set name for players vs players
    # @return [String] the result set name
    PLAYERS_VS_PLAYERS = "PlayersVsPlayers".freeze

    # Result set name for team players vs players off court
    # @return [String] the result set name
    TEAM_PLAYERS_VS_PLAYERS_OFF = "TeamPlayersVsPlayersOff".freeze

    # Result set name for team players vs players on court
    # @return [String] the result set name
    TEAM_PLAYERS_VS_PLAYERS_ON = "TeamPlayersVsPlayersOn".freeze

    # Result set name for team vs players
    # @return [String] the result set name
    TEAM_VS_PLAYERS = "TeamVsPlayers".freeze

    # Retrieves players vs players comparison statistics
    #
    # @api public
    # @example
    #   stats = NBA::TeamAndPlayersVsPlayers.players_vs_players(
    #     team: 1610612744, vs_team: 1610612747, players: [201939], vs_players: [2544]
    #   )
    #   stats.first.pts #=> 26.4
    # @param team [Integer, Team] the team ID or Team object
    # @param vs_team [Integer, Team] the vs team ID or Team object
    # @param players [Array<Integer, Player>] array of player IDs or Player objects
    # @param vs_players [Array<Integer, Player>] array of vs player IDs or Player objects
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player vs player statistics
    def self.players_vs_players(team:, vs_team:, players:, vs_players:, season: Utils.current_season,
      season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      opts = {season: season, season_type: season_type, per_mode: per_mode, result_set: PLAYERS_VS_PLAYERS}
      fetch_stats(team, vs_team, players, vs_players, opts, client: client)
    end

    # Retrieves team players vs players off court statistics
    #
    # @api public
    # @example
    #   stats = NBA::TeamAndPlayersVsPlayers.team_players_vs_players_off(
    #     team: 1610612744, vs_team: 1610612747, players: [201939], vs_players: [2544]
    #   )
    #   stats.first.pts #=> 22.1
    # @param team [Integer, Team] the team ID or Team object
    # @param vs_team [Integer, Team] the vs team ID or Team object
    # @param players [Array<Integer, Player>] array of player IDs or Player objects
    # @param vs_players [Array<Integer, Player>] array of vs player IDs or Player objects
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team player statistics
    def self.team_players_vs_players_off(team:, vs_team:, players:, vs_players:, season: Utils.current_season,
      season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      opts = {season: season, season_type: season_type, per_mode: per_mode, result_set: TEAM_PLAYERS_VS_PLAYERS_OFF}
      fetch_stats(team, vs_team, players, vs_players, opts, client: client)
    end

    # Retrieves team players vs players on court statistics
    #
    # @api public
    # @example
    #   stats = NBA::TeamAndPlayersVsPlayers.team_players_vs_players_on(
    #     team: 1610612744, vs_team: 1610612747, players: [201939], vs_players: [2544]
    #   )
    #   stats.first.pts #=> 28.3
    # @param team [Integer, Team] the team ID or Team object
    # @param vs_team [Integer, Team] the vs team ID or Team object
    # @param players [Array<Integer, Player>] array of player IDs or Player objects
    # @param vs_players [Array<Integer, Player>] array of vs player IDs or Player objects
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team player statistics
    def self.team_players_vs_players_on(team:, vs_team:, players:, vs_players:, season: Utils.current_season,
      season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      opts = {season: season, season_type: season_type, per_mode: per_mode, result_set: TEAM_PLAYERS_VS_PLAYERS_ON}
      fetch_stats(team, vs_team, players, vs_players, opts, client: client)
    end

    # Retrieves team vs players statistics
    #
    # @api public
    # @example
    #   stats = NBA::TeamAndPlayersVsPlayers.team_vs_players(
    #     team: 1610612744, vs_team: 1610612747, players: [201939], vs_players: [2544]
    #   )
    #   stats.first.pts #=> 112.4
    # @param team [Integer, Team] the team ID or Team object
    # @param vs_team [Integer, Team] the vs team ID or Team object
    # @param players [Array<Integer, Player>] array of player IDs or Player objects
    # @param vs_players [Array<Integer, Player>] array of vs player IDs or Player objects
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team statistics
    def self.team_vs_players(team:, vs_team:, players:, vs_players:, season: Utils.current_season,
      season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      opts = {season: season, season_type: season_type, per_mode: per_mode, result_set: TEAM_VS_PLAYERS}
      fetch_stats(team, vs_team, players, vs_players, opts, client: client)
    end

    # Fetches team and players vs players statistics from the API
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.fetch_stats(team, vs_team, players, vs_players, opts, client:)
      path = build_path(team, vs_team, players, vs_players, opts)
      response = client.get(path)
      parse_response(response, opts.fetch(:result_set))
    end
    private_class_method :fetch_stats

    # Builds the API request path with all parameters
    #
    # @api private
    # @return [String] the API request path
    def self.build_path(team, vs_team, players, vs_players, opts)
      team_id = Utils.extract_id(team)
      vs_team_id = Utils.extract_id(vs_team)
      season_str = Utils.format_season(opts.fetch(:season))
      player_params = build_player_params(players, "PlayerID")
      vs_player_params = build_player_params(vs_players, "VsPlayerID")
      "teamandplayersvsplayers?TeamID=#{team_id}&VsTeamID=#{vs_team_id}&Season=#{season_str}" \
        "&SeasonType=#{opts.fetch(:season_type)}&PerMode=#{opts.fetch(:per_mode)}" \
        "&LeagueID=00#{player_params}#{vs_player_params}"
    end
    private_class_method :build_path

    # Builds player parameter string for API request
    #
    # @api private
    # @return [String] the player parameters string
    def self.build_player_params(players, param_prefix)
      ids = players.map { |p| Utils.extract_id(p) }
      (1..5).map { |i| "&#{param_prefix}#{i}=#{ids.at(i - 1) || 0}" }.join
    end
    private_class_method :build_player_params

    # Parses the API response and extracts the result set
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.parse_response(response, result_set_name)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      build_collection(result_set)
    end
    private_class_method :parse_response

    # Finds the result set matching the given name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil
    def self.find_result_set(data, result_set_name)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(result_set_name) }
    end
    private_class_method :find_result_set

    # Builds a collection from the result set data
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.build_collection(result_set)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a stat object from the data hash
    #
    # @api private
    # @return [TeamAndPlayersVsPlayersStat] the stat object
    def self.build_stat(data)
      TeamAndPlayersVsPlayersStat.new(**identity_info(data), **stat_info(data))
    end
    private_class_method :build_stat

    # Extracts identity information from the data hash
    #
    # @api private
    # @return [Hash] the identity attributes
    def self.identity_info(data)
      {team_id: data["TEAM_ID"], player_id: data["PLAYER_ID"],
       vs_player_id: data["VS_PLAYER_ID"], player_name: data["PLAYER_NAME"],
       gp: data["GP"], min: data["MIN"]}
    end
    private_class_method :identity_info

    # Extracts stat information from the data hash
    #
    # @api private
    # @return [Hash] the stat attributes
    def self.stat_info(data)
      {pts: data["PTS"], reb: data["REB"], ast: data["AST"], stl: data["STL"],
       blk: data["BLK"], tov: data["TOV"], fg_pct: data["FG_PCT"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :stat_info
  end
end
