require "json"
require_relative "client"
require_relative "collection"

require_relative "team_year_stat"

module NBA
  # Provides methods to retrieve team year-by-year statistics
  module TeamYearByYearStats
    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Retrieves year-by-year statistics for a team
    #
    # @api public
    # @example
    #   stats = NBA::TeamYearByYearStats.find(team: NBA::Team::GSW)
    #   stats.each { |s| puts "#{s.year}: #{s.wins}-#{s.losses}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param client [Client] the API client to use
    # @return [Collection] a collection of year-by-year stats
    def self.find(team:, season_type: REGULAR_SEASON, per_mode: PER_GAME, client: CLIENT)
      team_id = extract_team_id(team)
      path = build_path(team_id, season_type, per_mode)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(team_id, season_type, per_mode)
      encoded_type = season_type
      "teamyearbyyearstats?TeamID=#{team_id}&SeasonType=#{encoded_type}&PerMode=#{per_mode}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into year stat objects
    # @api private
    # @return [Collection] collection of year stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set["headers"]
      rows = result_set["rowSet"]
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_year_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the team stats result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data["resultSets"]
      return unless result_sets

      result_sets.find { |rs| rs["name"].eql?(TEAM_STATS) }
    end
    private_class_method :find_result_set

    # Builds a TeamYearStat object from raw data
    # @api private
    # @return [TeamYearStat] the year stat object
    def self.build_year_stat(headers, row)
      data = headers.zip(row).to_h
      TeamYearStat.new(**year_stat_attributes(data))
    end
    private_class_method :build_year_stat

    # Combines all year stat attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.year_stat_attributes(data)
      identity_attributes(data).merge(record_attributes(data), shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :year_stat_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {team_id: data["TEAM_ID"], team_city: data["TEAM_CITY"],
       team_name: data["TEAM_NAME"], year: data["YEAR"], gp: data["GP"]}
    end
    private_class_method :identity_attributes

    # Extracts record attributes from data
    # @api private
    # @return [Hash] record attributes
    def self.record_attributes(data)
      {wins: data["WINS"], losses: data["LOSSES"], win_pct: data["WIN_PCT"],
       conf_rank: data["CONF_RANK"], div_rank: data["DIV_RANK"],
       po_wins: data["PO_WINS"], po_losses: data["PO_LOSSES"],
       nba_finals_appearance: data["NBA_FINALS_APPEARANCE"]}
    end
    private_class_method :record_attributes

    # Extracts shooting attributes from data
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], pf: data["PF"], stl: data["STL"],
       tov: data["TOV"], blk: data["BLK"], pts: data["PTS"], pts_rank: data["PTS_RANK"]}
    end
    private_class_method :counting_attributes

    # Extracts team ID from team object or integer
    # @api private
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      team.instance_of?(Team) ? team.id : team
    end
    private_class_method :extract_team_id
  end
end
