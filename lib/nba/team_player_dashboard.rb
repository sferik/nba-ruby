require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Provides methods to retrieve player dashboard data for a team
  module TeamPlayerDashboard
    # Result set name for player stats
    # @return [String] the result set name
    PLAYERS = "PlayersSeasonTotals".freeze

    # Result set name for team overall stats
    # @return [String] the result set name
    TEAM_OVERALL = "TeamOverall".freeze

    # Retrieves player statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamPlayerDashboard.players(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts} ppg" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player stats
    def self.players(team:, season: Utils.current_season, season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, PLAYERS, client:)
    end

    # Retrieves team overall statistics
    #
    # @api public
    # @example
    #   stats = NBA::TeamPlayerDashboard.team(team: NBA::Team::GSW)
    #   stats.first.pts #=> 111.8
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team overall stats
    def self.team(team:, season: Utils.current_season, season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, TEAM_OVERALL, client:)
    end

    # Fetches stats from the API
    #
    # @api private
    # @return [Collection] collection of stats
    def self.fetch_stats(team, season, season_type, per_mode, result_set_name, client:)
      team_id = Utils.extract_id(team)
      path = build_path(team_id, season, season_type, per_mode)
      response = client.get(path)
      parse_response(response, result_set_name)
    end
    private_class_method :fetch_stats

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(team_id, season, season_type, per_mode)
      season_str = Utils.format_season(season)
      "teamplayerdashboard?TeamID=#{team_id}&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    #
    # @api private
    # @return [Collection] collection of stats
    def self.parse_response(response, result_set_name)
      return Collection.new unless response

      data = JSON.parse(response)
      result_sets = data["resultSets"]
      return Collection.new unless result_sets

      result_set = find_result_set(result_sets, result_set_name)
      return Collection.new unless result_set

      build_collection(result_set, result_set_name)
    end
    private_class_method :parse_response

    # Finds a result set by name
    #
    # @api private
    # @return [Hash, nil] the result set or nil if not found
    def self.find_result_set(result_sets, name)
      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a collection from a result set
    #
    # @api private
    # @return [Collection] collection of stats
    def self.build_collection(result_set, result_set_name)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_stat(headers, row, result_set_name) }
      Collection.new(stats)
    end
    private_class_method :build_collection

    # Builds a stat object from raw data
    #
    # @api private
    # @return [TeamPlayerStat, TeamDashboardStat] the stat object
    def self.build_stat(headers, row, result_set_name)
      data = headers.zip(row).to_h
      if result_set_name.eql?(PLAYERS)
        TeamPlayerStat.new(**player_attributes(data))
      else
        TeamDashboardStat.new(**team_attributes(data))
      end
    end
    private_class_method :build_stat

    # Extracts player attributes from data
    #
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      identity_attributes(data)
        .merge(record_attributes(data))
        .merge(shooting_attributes(data))
        .merge(counting_attributes(data))
        .merge(bonus_attributes(data))
    end
    private_class_method :player_attributes

    # Extracts team attributes from data
    #
    # @api private
    # @return [Hash] team attributes
    def self.team_attributes(data)
      team_identity(data)
        .merge(record_attributes(data))
        .merge(shooting_attributes(data))
        .merge(counting_attributes(data))
    end
    private_class_method :team_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {group_set: data["GROUP_SET"], player_id: data["PLAYER_ID"],
       player_name: data["PLAYER_NAME"], gp: data["GP"], min: data["MIN"]}
    end
    private_class_method :identity_attributes

    # Extracts team identity attributes from data
    #
    # @api private
    # @return [Hash] team identity attributes
    def self.team_identity(data)
      {group_set: data["GROUP_SET"], group_value: data["GROUP_VALUE"],
       team_id: data["TEAM_ID"], gp: data["GP"], min: data["MIN"]}
    end
    private_class_method :team_identity

    # Extracts record attributes from data
    #
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {w: data["W"], l: data["L"], w_pct: data["W_PCT"]}
    end
    private_class_method :record_attributes

    # Extracts shooting attributes from data
    #
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    #
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], tov: data["TOV"], stl: data["STL"], blk: data["BLK"],
       blka: data["BLKA"], pf: data["PF"], pfd: data["PFD"],
       pts: data["PTS"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_attributes

    # Extracts bonus attributes from data
    #
    # @api private
    # @return [Hash] bonus attributes
    def self.bonus_attributes(data)
      {nba_fantasy_pts: data["NBA_FANTASY_PTS"], dd2: data["DD2"], td3: data["TD3"]}
    end
    private_class_method :bonus_attributes
  end
end
