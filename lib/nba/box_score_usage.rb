require_relative "client"
require_relative "response_parser"
require_relative "box_score_usage_player_stat"
require_relative "box_score_usage_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve usage box score statistics
  module BoxScoreUsage
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player usage box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreUsage.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.usg_pct}% usage" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player usage box score stats
    def self.player_stats(game:, client: CLIENT)
      path = "boxscoreusagev2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: PLAYER_STATS) { |data| build_player_stat(data) }
    end

    # Retrieves team usage box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreUsage.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.pct_pts}% of pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team usage box score stats
    def self.team_stats(game:, client: CLIENT)
      path = "boxscoreusagev2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: TEAM_STATS) { |data| build_team_stat(data) }
    end

    # Builds a player usage stat from API data
    # @api private
    # @return [BoxScoreUsagePlayerStat]
    def self.build_player_stat(data)
      BoxScoreUsagePlayerStat.new(**player_identity(data), **shooting_usage(data), **other_usage(data))
    end
    private_class_method :build_player_stat

    # Builds a team usage stat from API data
    # @api private
    # @return [BoxScoreUsageTeamStat]
    def self.build_team_stat(data)
      BoxScoreUsageTeamStat.new(**team_identity(data), **shooting_usage(data), **other_usage(data))
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

    # Extracts shooting usage statistics from data
    # @api private
    # @return [Hash]
    def self.shooting_usage(data)
      {usg_pct: data["USG_PCT"], pct_fgm: data["PCT_FGM"], pct_fga: data["PCT_FGA"],
       pct_fg3m: data["PCT_FG3M"], pct_fg3a: data["PCT_FG3A"],
       pct_ftm: data["PCT_FTM"], pct_fta: data["PCT_FTA"]}
    end
    private_class_method :shooting_usage

    # Extracts other usage statistics from data
    # @api private
    # @return [Hash]
    def self.other_usage(data)
      {pct_oreb: data["PCT_OREB"], pct_dreb: data["PCT_DREB"], pct_reb: data["PCT_REB"],
       pct_ast: data["PCT_AST"], pct_tov: data["PCT_TOV"], pct_stl: data["PCT_STL"],
       pct_blk: data["PCT_BLK"], pct_blka: data["PCT_BLKA"],
       pct_pf: data["PCT_PF"], pct_pfd: data["PCT_PFD"], pct_pts: data["PCT_PTS"]}
    end
    private_class_method :other_usage
  end
end
