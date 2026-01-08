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

    # Parses the API response and extracts the result set
    #
    # @api private
    # @return [Collection] the collection of statistics
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

    # Finds the result set matching the given name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil
    def self.find_result_set(result_sets, name)
      result_sets.find { |rs| rs["name"].eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a collection from the result set data
    #
    # @api private
    # @return [Collection] the collection of statistics
    def self.build_collection(result_set, result_set_name)
      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stat(headers, row, result_set_name) })
    end
    private_class_method :build_collection

    # Builds a stat object from the data hash
    #
    # @api private
    # @return [TeamOnOffOverallStat, TeamOnOffPlayerStat] the stat object
    def self.build_stat(headers, row, result_set_name)
      data = headers.zip(row).to_h
      attrs = result_set_name.eql?(OVERALL) ? overall_attributes(data) : player_attributes(data)
      result_set_name.eql?(OVERALL) ? TeamOnOffOverallStat.new(**attrs) : TeamOnOffPlayerStat.new(**attrs)
    end
    private_class_method :build_stat

    # Extracts overall attributes from the data hash
    #
    # @api private
    # @return [Hash] overall attributes
    def self.overall_attributes(data)
      overall_identity(data).merge(stat_attributes(data))
    end
    private_class_method :overall_attributes

    # Extracts player attributes from the data hash
    #
    # @api private
    # @return [Hash] player attributes
    def self.player_attributes(data)
      player_identity(data).merge(stat_attributes(data))
    end
    private_class_method :player_attributes

    # Extracts stat attributes from the data hash
    #
    # @api private
    # @return [Hash] stat attributes
    def self.stat_attributes(data)
      record_attributes(data).merge(shooting_attributes(data)).merge(counting_attributes(data)).merge(rank_attributes(data))
    end
    private_class_method :stat_attributes

    # Extracts overall identity attributes from the data hash
    #
    # @api private
    # @return [Hash] identity attributes
    def self.overall_identity(data)
      {group_set: data["GROUP_SET"], group_value: data["GROUP_VALUE"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"], team_name: data["TEAM_NAME"]}
    end
    private_class_method :overall_identity

    # Extracts player identity attributes from the data hash
    #
    # @api private
    # @return [Hash] identity attributes
    def self.player_identity(data)
      {group_set: data["GROUP_SET"], team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_name: data["TEAM_NAME"], vs_player_id: data["VS_PLAYER_ID"],
       vs_player_name: data["VS_PLAYER_NAME"], court_status: data["COURT_STATUS"]}
    end
    private_class_method :player_identity

    # Extracts record attributes from the data hash
    #
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {gp: data["GP"], w: data["W"], l: data["L"], w_pct: data["W_PCT"], min: data["MIN"]}
    end
    private_class_method :record_attributes

    # Extracts shooting attributes from the data hash
    #
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"], fg3m: data["FG3M"],
       fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"], ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting attributes from the data hash
    #
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"], ast: data["AST"], tov: data["TOV"],
       stl: data["STL"], blk: data["BLK"], blka: data["BLKA"], pf: data["PF"], pfd: data["PFD"],
       pts: data["PTS"], plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_attributes

    # Extracts rank attributes from the data hash
    #
    # @api private
    # @return [Hash] rank attributes
    def self.rank_attributes(data)
      record_ranks(data).merge(shooting_ranks(data)).merge(counting_ranks(data))
    end
    private_class_method :rank_attributes

    # Extracts record rank attributes from the data hash
    #
    # @api private
    # @return [Hash] record rank attributes
    def self.record_ranks(data)
      {gp_rank: data["GP_RANK"], w_rank: data["W_RANK"], l_rank: data["L_RANK"],
       w_pct_rank: data["W_PCT_RANK"], min_rank: data["MIN_RANK"]}
    end
    private_class_method :record_ranks

    # Extracts shooting rank attributes from the data hash
    #
    # @api private
    # @return [Hash] shooting rank attributes
    def self.shooting_ranks(data)
      {fgm_rank: data["FGM_RANK"], fga_rank: data["FGA_RANK"], fg_pct_rank: data["FG_PCT_RANK"],
       fg3m_rank: data["FG3M_RANK"], fg3a_rank: data["FG3A_RANK"], fg3_pct_rank: data["FG3_PCT_RANK"],
       ftm_rank: data["FTM_RANK"], fta_rank: data["FTA_RANK"], ft_pct_rank: data["FT_PCT_RANK"]}
    end
    private_class_method :shooting_ranks

    # Extracts counting rank attributes from the data hash
    #
    # @api private
    # @return [Hash] counting rank attributes
    def self.counting_ranks(data)
      {oreb_rank: data["OREB_RANK"], dreb_rank: data["DREB_RANK"], reb_rank: data["REB_RANK"],
       ast_rank: data["AST_RANK"], tov_rank: data["TOV_RANK"], stl_rank: data["STL_RANK"],
       blk_rank: data["BLK_RANK"], blka_rank: data["BLKA_RANK"], pf_rank: data["PF_RANK"],
       pfd_rank: data["PFD_RANK"], pts_rank: data["PTS_RANK"], plus_minus_rank: data["PLUS_MINUS_RANK"]}
    end
    private_class_method :counting_ranks
  end
end
