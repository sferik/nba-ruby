require "json"
require_relative "client"
require_relative "collection"
require_relative "league_dash_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve league-wide team statistics
  module LeagueDashTeamStats
    # Result set name
    # @return [String] the result set name
    LEAGUE_DASH_TEAM_STATS = "LeagueDashTeamStats".freeze

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

    # Per 100 possessions mode
    # @return [String] the per mode
    PER_100 = "Per100Possessions".freeze

    # Retrieves league-wide team statistics
    #
    # @api public
    # @example
    #   stats = NBA::LeagueDashTeamStats.all(season: 2024)
    #   stats.each { |s| puts "#{s.team_name}: #{s.pts} PPG" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param per_mode [String] the per mode (PerGame, Totals, Per100Possessions)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team stats
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type, per_mode)
      response = client.get(path)
      parse_response(response, season)
    end

    # Builds the API path
    # @api private
    # @param season [Integer] the season
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @return [String] the path
    def self.build_path(season, season_type, per_mode)
      "leaguedashteamstats?Conference=&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&Height=&" \
        "ISTRound=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&" \
        "PORound=0&PaceAdjust=N&PerMode=#{per_mode}&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&" \
        "Rank=Y&Season=#{Utils.format_season(season)}&SeasonSegment=&SeasonType=#{season_type}&ShotClockRange=&" \
        "StarterBench=&TeamID=0&TwoWay=0&VsConference=&VsDivision="
    end
    private_class_method :build_path

    # Parses the API response
    # @api private
    # @param response [String, nil] the JSON response
    # @param season [Integer] the season
    # @return [Collection] collection of team stats
    def self.parse_response(response, season)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      build_team_stats(result_set, Utils.format_season(season))
    end
    private_class_method :parse_response

    # Finds the result set
    # @api private
    # @param data [Hash] the parsed JSON
    # @return [Hash, nil] the result set
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(LEAGUE_DASH_TEAM_STATS) }
    end
    private_class_method :find_result_set

    # Builds team stats collection
    # @api private
    # @param result_set [Hash] the result set
    # @param season_id [String] the season ID
    # @return [Collection] collection of team stats
    def self.build_team_stats(result_set, season_id)
      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_team_stat(headers, row, season_id) }
      Collection.new(stats)
    end
    private_class_method :build_team_stats

    # Builds a single team stat
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @param season_id [String] the season ID
    # @return [LeagueDashTeamStat] the team stat
    def self.build_team_stat(headers, row, season_id)
      data = headers.zip(row).to_h
      LeagueDashTeamStat.new(**team_stat_attributes(data, season_id))
    end
    private_class_method :build_team_stat

    # Combines all team stat attributes
    # @api private
    # @param data [Hash] the raw data
    # @param season_id [String] the season ID
    # @return [Hash] the combined attributes
    def self.team_stat_attributes(data, season_id)
      identity_attributes(data, season_id).merge(shooting_attributes(data), counting_attributes(data), rank_attributes(data))
    end
    private_class_method :team_stat_attributes

    # Extracts identity attributes
    # @api private
    # @param data [Hash] the raw data
    # @param season_id [String] the season ID
    # @return [Hash] identity attributes
    def self.identity_attributes(data, season_id)
      {team_id: data.fetch("TEAM_ID"), team_name: data.fetch("TEAM_NAME"), season_id: season_id,
       gp: data.fetch("GP"), w: data.fetch("W"), l: data.fetch("L"), w_pct: data.fetch("W_PCT"), min: data.fetch("MIN")}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM"), fga: data.fetch("FGA"), fg_pct: data.fetch("FG_PCT"), fg3m: data.fetch("FG3M"), fg3a: data.fetch("FG3A"),
       fg3_pct: data.fetch("FG3_PCT"), ftm: data.fetch("FTM"), fta: data.fetch("FTA"), ft_pct: data.fetch("FT_PCT")}
    end
    private_class_method :shooting_attributes

    # Extracts counting attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB"), dreb: data.fetch("DREB"), reb: data.fetch("REB"), ast: data.fetch("AST"), tov: data.fetch("TOV"),
       stl: data.fetch("STL"), blk: data.fetch("BLK"), blka: data.fetch("BLKA"), pf: data.fetch("PF"), pfd: data.fetch("PFD"),
       pts: data.fetch("PTS"), plus_minus: data.fetch("PLUS_MINUS")}
    end
    private_class_method :counting_attributes

    # Extracts rank attributes
    # @api private
    # @param data [Hash] the raw data
    # @return [Hash] rank attributes
    def self.rank_attributes(data)
      {gp_rank: data.fetch("GP_RANK"), w_rank: data.fetch("W_RANK"), pts_rank: data.fetch("PTS_RANK")}
    end
    private_class_method :rank_attributes
  end
end
