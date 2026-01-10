require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Provides methods to retrieve team on/off court details
  module TeamPlayerOnOffDetails
    # Result set name for overall team stats
    # @return [String] the result set name
    OVERALL = "OverallTeamPlayerOnOffDetails".freeze
    # Result set name for players on court stats
    # @return [String] the result set name
    PLAYERS_ON = "PlayersOnCourtTeamPlayerOnOffDetails".freeze
    # Result set name for players off court stats
    # @return [String] the result set name
    PLAYERS_OFF = "PlayersOffCourtTeamPlayerOnOffDetails".freeze

    # Retrieves overall team on/off court statistics
    #
    # @api public
    # @example
    #   stats = NBA::TeamPlayerOnOffDetails.overall(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.group_value}: #{s.pts} pts" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of overall stats
    def self.overall(team:, season: Utils.current_season, season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, OVERALL, client:)
    end

    # Retrieves statistics when opponent players are on the court
    #
    # @api public
    # @example
    #   stats = NBA::TeamPlayerOnOffDetails.players_on_court(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.vs_player_name}: #{s.pts} pts" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player on court stats
    def self.players_on_court(team:, season: Utils.current_season, season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, PLAYERS_ON, client:)
    end

    # Retrieves statistics when opponent players are off the court
    #
    # @api public
    # @example
    #   stats = NBA::TeamPlayerOnOffDetails.players_off_court(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.vs_player_name}: #{s.pts} pts" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player off court stats
    def self.players_off_court(team:, season: Utils.current_season, season_type: "Regular Season", per_mode: "PerGame", client: CLIENT)
      fetch_stats(team, season, season_type, per_mode, PLAYERS_OFF, client:)
    end

    # Fetches team player on/off details from the API
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.fetch_stats(team, season, season_type, per_mode, result_set_name, client:)
      path = build_path(Utils.extract_id(team), season, season_type, per_mode)
      parse_response(client.get(path), result_set_name)
    end
    private_class_method :fetch_stats

    # Builds the API request path with all parameters
    #
    # @api private
    # @return [String] the API request path
    def self.build_path(team_id, season, season_type, per_mode)
      season_str = Utils.format_season(season)
      "teamplayeronoffdetails?TeamID=#{team_id}&Season=#{season_str}&SeasonType=#{season_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into stat objects
    # @api private
    # @return [Collection] collection of stat objects
    def self.parse_response(response, result_set_name)
      return Collection.new unless response

      result_set = find_result_set(JSON.parse(response), result_set_name)
      build_collection(result_set, result_set_name)
    end
    private_class_method :parse_response

    # Finds a result set by name in the parsed response data
    # @api private
    # @return [Hash, nil] the matching result set or nil
    def self.find_result_set(data, name)
      data["resultSets"]&.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a collection of stat objects from a result set
    # @api private
    # @return [Collection] collection of stat objects
    def self.build_collection(result_set, result_set_name)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers.zip(row).to_h, result_set_name) })
    end
    private_class_method :build_collection

    # Builds a stat object from row data
    # @api private
    # @return [TeamOnOffOverallStat, TeamOnOffPlayerStat] the stat object
    def self.build_stat(data, result_set_name)
      attrs = result_set_name.eql?(OVERALL) ? overall_attrs(data) : player_attrs(data)
      result_set_name.eql?(OVERALL) ? TeamOnOffOverallStat.new(**attrs) : TeamOnOffPlayerStat.new(**attrs)
    end
    private_class_method :build_stat

    # Extracts overall stat attributes from row data
    # @api private
    # @return [Hash] overall stat attributes
    def self.overall_attrs(data)
      {group_set: data["GROUP_SET"], group_value: data["GROUP_VALUE"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"], team_name: data["TEAM_NAME"]}.merge(stat_attrs(data))
    end
    private_class_method :overall_attrs

    # Extracts player stat attributes from row data
    # @api private
    # @return [Hash] player stat attributes
    def self.player_attrs(data)
      {group_set: data["GROUP_SET"], team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_name: data["TEAM_NAME"], vs_player_id: data["VS_PLAYER_ID"], vs_player_name: data["VS_PLAYER_NAME"],
       court_status: data["COURT_STATUS"]}.merge(stat_attrs(data))
    end
    private_class_method :player_attrs

    # Extracts common stat attributes from row data
    # @api private
    # @return [Hash] common stat attributes
    def self.stat_attrs(data)
      record_attrs(data).merge(shooting_attrs(data), counting_attrs(data), rank_attrs(data))
    end
    private_class_method :stat_attrs

    # Extracts record attributes from row data
    # @api private
    # @return [Hash] record attributes
    def self.record_attrs(data)
      {gp: data["GP"], w: data["W"], l: data["L"], w_pct: data["W_PCT"], min: data["MIN"]}
    end
    private_class_method :record_attrs

    # Extracts shooting stat attributes from row data
    # @api private
    # @return [Hash] shooting stat attributes
    def self.shooting_attrs(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"], fg3m: data["FG3M"], fg3a: data["FG3A"],
       fg3_pct: data["FG3_PCT"], ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attrs

    # Extracts counting stat attributes from row data
    # @api private
    # @return [Hash] counting stat attributes
    def self.counting_attrs(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"], ast: data["AST"], tov: data["TOV"], stl: data["STL"],
       blk: data["BLK"], blka: data["BLKA"], pf: data["PF"], pfd: data["PFD"], pts: data["PTS"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_attrs

    # Extracts rank attributes from row data
    # @api private
    # @return [Hash] rank attributes
    def self.rank_attrs(data)
      record_rank_attrs(data).merge(shooting_rank_attrs(data), counting_rank_attrs(data))
    end
    private_class_method :rank_attrs

    # Extracts record rank attributes from row data
    # @api private
    # @return [Hash] record rank attributes
    def self.record_rank_attrs(data)
      {gp_rank: data["GP_RANK"], w_rank: data["W_RANK"], l_rank: data["L_RANK"], w_pct_rank: data["W_PCT_RANK"], min_rank: data["MIN_RANK"]}
    end
    private_class_method :record_rank_attrs

    # Extracts shooting rank attributes from row data
    # @api private
    # @return [Hash] shooting rank attributes
    def self.shooting_rank_attrs(data)
      {fgm_rank: data["FGM_RANK"], fga_rank: data["FGA_RANK"], fg_pct_rank: data["FG_PCT_RANK"], fg3m_rank: data["FG3M_RANK"],
       fg3a_rank: data["FG3A_RANK"], fg3_pct_rank: data["FG3_PCT_RANK"], ftm_rank: data["FTM_RANK"], fta_rank: data["FTA_RANK"],
       ft_pct_rank: data["FT_PCT_RANK"]}
    end
    private_class_method :shooting_rank_attrs

    # Extracts counting rank attributes from row data
    # @api private
    # @return [Hash] counting rank attributes
    def self.counting_rank_attrs(data)
      {oreb_rank: data["OREB_RANK"], dreb_rank: data["DREB_RANK"], reb_rank: data["REB_RANK"], ast_rank: data["AST_RANK"],
       tov_rank: data["TOV_RANK"], stl_rank: data["STL_RANK"], blk_rank: data["BLK_RANK"], blka_rank: data["BLKA_RANK"],
       pf_rank: data["PF_RANK"], pfd_rank: data["PFD_RANK"], pts_rank: data["PTS_RANK"], plus_minus_rank: data["PLUS_MINUS_RANK"]}
    end
    private_class_method :counting_rank_attrs
  end
end
