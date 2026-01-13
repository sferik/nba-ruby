require_relative "client"
require_relative "response_parser"
require_relative "player_career_by_college"

module NBA
  # Provides methods to retrieve player career stats aggregated by college region
  module PlayerCareerByCollegeRollup
    # Per mode constant for per game stats
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Per mode constant for totals
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Result set name for East region colleges
    # @return [String] the result set name
    EAST = "East".freeze

    # Result set name for Midwest region colleges
    # @return [String] the result set name
    MIDWEST = "Midwest".freeze

    # Result set name for South region colleges
    # @return [String] the result set name
    SOUTH = "South".freeze

    # Result set name for West region colleges
    # @return [String] the result set name
    WEST = "West".freeze

    # Retrieves career statistics for players from East region colleges
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCareerByCollegeRollup.east
    #   stats.each { |s| puts "#{s.player_name} (#{s.college}): #{s.pts} career points" }
    #
    # @param per_mode [String] the per mode (Totals or PerGame)
    # @param season [String, nil] optional season filter
    # @param client [Client] the API client to use
    # @return [Collection] a collection of college player stats
    def self.east(per_mode: TOTALS, season: nil, client: CLIENT)
      path = build_path(per_mode, season)
      ResponseParser.parse(client.get(path), result_set: EAST) { |data| build_stat(data) }
    end

    # Retrieves career statistics for players from Midwest region colleges
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCareerByCollegeRollup.midwest
    #   stats.each { |s| puts "#{s.player_name} (#{s.college}): #{s.pts} career points" }
    #
    # @param per_mode [String] the per mode (Totals or PerGame)
    # @param season [String, nil] optional season filter
    # @param client [Client] the API client to use
    # @return [Collection] a collection of college player stats
    def self.midwest(per_mode: TOTALS, season: nil, client: CLIENT)
      path = build_path(per_mode, season)
      ResponseParser.parse(client.get(path), result_set: MIDWEST) { |data| build_stat(data) }
    end

    # Retrieves career statistics for players from South region colleges
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCareerByCollegeRollup.south
    #   stats.each { |s| puts "#{s.player_name} (#{s.college}): #{s.pts} career points" }
    #
    # @param per_mode [String] the per mode (Totals or PerGame)
    # @param season [String, nil] optional season filter
    # @param client [Client] the API client to use
    # @return [Collection] a collection of college player stats
    def self.south(per_mode: TOTALS, season: nil, client: CLIENT)
      path = build_path(per_mode, season)
      ResponseParser.parse(client.get(path), result_set: SOUTH) { |data| build_stat(data) }
    end

    # Retrieves career statistics for players from West region colleges
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCareerByCollegeRollup.west
    #   stats.each { |s| puts "#{s.player_name} (#{s.college}): #{s.pts} career points" }
    #
    # @param per_mode [String] the per mode (Totals or PerGame)
    # @param season [String, nil] optional season filter
    # @param client [Client] the API client to use
    # @return [Collection] a collection of college player stats
    def self.west(per_mode: TOTALS, season: nil, client: CLIENT)
      path = build_path(per_mode, season)
      ResponseParser.parse(client.get(path), result_set: WEST) { |data| build_stat(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(per_mode, season)
      season_param = "&SeasonNullable=#{season}" if season
      "playercareerbycollegerollup?LeagueID=00" \
        "&PerModeSimple=#{per_mode}&SeasonTypeAllStar=Regular+Season#{season_param}"
    end
    private_class_method :build_path

    # Builds a college player stat from API data
    # @api private
    # @return [CollegePlayerStat]
    def self.build_stat(data)
      CollegePlayerStat.new(**identity_info(data), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_stat

    # Extracts identity information from data
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       college: data["COLLEGE"], gp: data["GP"], min: data["MIN"]}
    end
    private_class_method :identity_info

    # Extracts shooting statistics from data
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    # @api private
    # @return [Hash]
    def self.counting_stats(data)
      {oreb: data["OREB"], dreb: data["DREB"], reb: data["REB"],
       ast: data["AST"], stl: data["STL"], blk: data["BLK"],
       tov: data["TOV"], pf: data["PF"], pts: data["PTS"]}
    end
    private_class_method :counting_stats
  end
end
