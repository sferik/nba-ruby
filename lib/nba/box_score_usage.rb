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
      {game_id: data.fetch("GAME_ID", nil), team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       team_city: data.fetch("TEAM_CITY", nil), player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       start_position: data.fetch("START_POSITION", nil), comment: data.fetch("COMMENT", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :player_identity

    # Extracts team identity attributes from data
    # @api private
    # @return [Hash]
    def self.team_identity(data)
      {game_id: data.fetch("GAME_ID", nil), team_id: data.fetch("TEAM_ID", nil), team_name: data.fetch("TEAM_NAME", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), team_city: data.fetch("TEAM_CITY", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :team_identity

    # Extracts shooting usage statistics from data
    # @api private
    # @return [Hash]
    def self.shooting_usage(data)
      {usg_pct: data.fetch("USG_PCT", nil), pct_fgm: data.fetch("PCT_FGM", nil), pct_fga: data.fetch("PCT_FGA", nil),
       pct_fg3m: data.fetch("PCT_FG3M", nil), pct_fg3a: data.fetch("PCT_FG3A", nil),
       pct_ftm: data.fetch("PCT_FTM", nil), pct_fta: data.fetch("PCT_FTA", nil)}
    end
    private_class_method :shooting_usage

    # Extracts other usage statistics from data
    # @api private
    # @return [Hash]
    def self.other_usage(data)
      {pct_oreb: data.fetch("PCT_OREB", nil), pct_dreb: data.fetch("PCT_DREB", nil), pct_reb: data.fetch("PCT_REB", nil),
       pct_ast: data.fetch("PCT_AST", nil), pct_tov: data.fetch("PCT_TOV", nil), pct_stl: data.fetch("PCT_STL", nil),
       pct_blk: data.fetch("PCT_BLK", nil), pct_blka: data.fetch("PCT_BLKA", nil),
       pct_pf: data.fetch("PCT_PF", nil), pct_pfd: data.fetch("PCT_PFD", nil), pct_pts: data.fetch("PCT_PTS", nil)}
    end
    private_class_method :other_usage
  end
end
