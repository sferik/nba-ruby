require "json"
require_relative "client"
require_relative "collection"
require_relative "league_player_on_details_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide player on court details
  module LeaguePlayerOnDetails
    # Result set name for players on court stats
    # @return [String] the result set name
    PLAYERS_ON_COURT = "PlayersOnCourtLeaguePlayerDetails".freeze

    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per game mode
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Totals mode
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Base measure type
    # @return [String] the measure type
    BASE = "Base".freeze

    # Retrieves league-wide player on court details for a team
    #
    # @api public
    # @example
    #   stats = NBA::LeaguePlayerOnDetails.all(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.vs_player_name}: #{s.pts} pts" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param per_mode [String] the per mode (PerGame, Totals)
    # @param measure_type [String] the measure type (Base)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player on court stats
    def self.all(team:, season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, measure_type: BASE, client: CLIENT)
      team_id = Utils.extract_id(team)
      path = build_path(team_id, season, season_type, per_mode, measure_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path
    # @api private
    # @param team_id [Integer] the team ID
    # @param season [Integer] the season
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param measure_type [String] the measure type
    # @return [String] the path
    def self.build_path(team_id, season, season_type, per_mode, measure_type)
      "leagueplayerondetails?LeagueID=00&Season=#{Utils.format_season(season)}&SeasonType=#{season_type}&" \
        "PerMode=#{per_mode}&MeasureType=#{measure_type}&TeamID=#{team_id}&PaceAdjust=N&PlusMinus=N&Rank=N&" \
        "LastNGames=0&Month=0&OpponentTeamID=0&Period=0"
    end
    private_class_method :build_path

    # Parses the API response
    # @api private
    # @param response [String, nil] the JSON response
    # @return [Collection] collection of player on court stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      build_stats(result_set)
    end
    private_class_method :parse_response

    # Finds the result set
    # @api private
    # @param data [Hash] the parsed JSON
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(PLAYERS_ON_COURT) }
    end
    private_class_method :find_result_set

    # Builds stats collection
    # @api private
    # @param result_set [Hash] the result set
    # @return [Collection] collection of player on court stats
    def self.build_stats(result_set)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :build_stats

    # Builds a single stat
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @return [LeaguePlayerOnDetailsStat] the stat
    def self.build_stat(headers, row)
      data = headers.zip(row).to_h
      LeaguePlayerOnDetailsStat.new(**stat_attributes(data))
    end
    private_class_method :build_stat

    # Combines all stat attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] the combined attributes
    def self.stat_attributes(data)
      identity_info(data).merge(record_info(data), shooting_info(data), counting_info(data))
    end
    private_class_method :stat_attributes

    # Extracts identity attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] identity attributes
    def self.identity_info(data)
      {group_set: data.fetch("GROUP_SET"), team_id: data.fetch("TEAM_ID"),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION"), team_name: data.fetch("TEAM_NAME"),
       vs_player_id: data.fetch("VS_PLAYER_ID"), vs_player_name: data.fetch("VS_PLAYER_NAME"),
       court_status: data.fetch("COURT_STATUS")}
    end
    private_class_method :identity_info

    # Extracts record attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] record attributes
    def self.record_info(data)
      {gp: data.fetch("GP"), w: data.fetch("W"), l: data.fetch("L"),
       w_pct: data.fetch("W_PCT"), min: data.fetch("MIN")}
    end
    private_class_method :record_info

    # Extracts shooting attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] shooting attributes
    def self.shooting_info(data)
      {fgm: data.fetch("FGM"), fga: data.fetch("FGA"), fg_pct: data.fetch("FG_PCT"),
       fg3m: data.fetch("FG3M"), fg3a: data.fetch("FG3A"), fg3_pct: data.fetch("FG3_PCT"),
       ftm: data.fetch("FTM"), fta: data.fetch("FTA"), ft_pct: data.fetch("FT_PCT")}
    end
    private_class_method :shooting_info

    # Extracts counting attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] counting attributes
    def self.counting_info(data)
      {oreb: data.fetch("OREB"), dreb: data.fetch("DREB"), reb: data.fetch("REB"),
       ast: data.fetch("AST"), tov: data.fetch("TOV"), stl: data.fetch("STL"),
       blk: data.fetch("BLK"), blka: data.fetch("BLKA"), pf: data.fetch("PF"),
       pfd: data.fetch("PFD"), pts: data.fetch("PTS"), plus_minus: data.fetch("PLUS_MINUS")}
    end
    private_class_method :counting_info
  end
end
