require_relative "client"
require_relative "response_parser"
require_relative "box_score"
require_relative "utils"

module NBA
  # Provides methods to retrieve traditional box score statistics
  module BoxScoreTraditional
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreTraditional.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.pts} pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player box score stats
    def self.player_stats(game:, client: CLIENT)
      path = "boxscoretraditionalv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: PLAYER_STATS) { |data| build_player_stat(data) }
    end

    # Retrieves team box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreTraditional.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.pts} pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team box score stats
    def self.team_stats(game:, client: CLIENT)
      path = "boxscoretraditionalv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: TEAM_STATS) { |data| build_team_stat(data) }
    end

    # Builds a player stat object from API data
    # @api private
    # @return [BoxScorePlayerStat]
    def self.build_player_stat(data)
      BoxScorePlayerStat.new(**player_identity(data), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_player_stat

    # Builds a team stat object from API data
    # @api private
    # @return [BoxScoreTeamStat]
    def self.build_team_stat(data)
      BoxScoreTeamStat.new(**team_identity(data), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_team_stat

    # Extracts player identity attributes from data
    # @api private
    # @return [Hash]
    def self.player_identity(data)
      {game_id: data["GAME_ID"], team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_city: data["TEAM_CITY"], player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       start_position: data["START_POSITION"], comment: data["COMMENT"], min: data["MIN"]}
    end
    private_class_method :player_identity

    # Extracts team identity attributes from data
    # @api private
    # @return [Hash]
    def self.team_identity(data)
      {game_id: data["GAME_ID"], team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"],
       team_abbreviation: data["TEAM_ABBREVIATION"], team_city: data["TEAM_CITY"], min: data["MIN"]}
    end
    private_class_method :team_identity

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
       tov: data["TO"], pf: data["PF"], pts: data["PTS"],
       plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_stats
  end
end
