require_relative "client"
require_relative "response_parser"
require_relative "box_score_scoring_player_stat"
require_relative "box_score_scoring_team_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve scoring box score statistics
  module BoxScoreScoring
    # Result set name for player stats
    # @return [String] the result set name
    PLAYER_STATS = "PlayerStats".freeze

    # Result set name for team stats
    # @return [String] the result set name
    TEAM_STATS = "TeamStats".freeze

    # Retrieves player scoring box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreScoring.player_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.player_name}: #{s.pct_pts_3pt}% from 3PT" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player scoring box score stats
    def self.player_stats(game:, client: CLIENT)
      path = "boxscorescoringv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: PLAYER_STATS) { |data| build_player_stat(data) }
    end

    # Retrieves team scoring box score stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreScoring.team_stats(game: "0022400001")
    #   stats.each { |s| puts "#{s.team_name}: #{s.pct_pts_paint}% in paint" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team scoring box score stats
    def self.team_stats(game:, client: CLIENT)
      path = "boxscorescoringv2?GameID=#{Utils.extract_id(game)}"
      ResponseParser.parse(client.get(path), result_set: TEAM_STATS) { |data| build_team_stat(data) }
    end

    # Builds a player scoring stat from API data
    # @api private
    # @return [BoxScoreScoringPlayerStat]
    def self.build_player_stat(data)
      BoxScoreScoringPlayerStat.new(**player_identity(data), **shot_distribution(data), **assist_stats(data))
    end
    private_class_method :build_player_stat

    # Builds a team scoring stat from API data
    # @api private
    # @return [BoxScoreScoringTeamStat]
    def self.build_team_stat(data)
      BoxScoreScoringTeamStat.new(**team_identity(data), **shot_distribution(data), **assist_stats(data))
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

    # Extracts shot distribution statistics from data
    # @api private
    # @return [Hash]
    def self.shot_distribution(data)
      {pct_fga_2pt: data["PCT_FGA_2PT"], pct_fga_3pt: data["PCT_FGA_3PT"],
       pct_pts_2pt: data["PCT_PTS_2PT"], pct_pts_2pt_mr: data["PCT_PTS_2PT_MR"],
       pct_pts_3pt: data["PCT_PTS_3PT"], pct_pts_fb: data["PCT_PTS_FB"],
       pct_pts_ft: data["PCT_PTS_FT"], pct_pts_off_tov: data["PCT_PTS_OFF_TOV"],
       pct_pts_paint: data["PCT_PTS_PAINT"]}
    end
    private_class_method :shot_distribution

    # Extracts assist statistics from data
    # @api private
    # @return [Hash]
    def self.assist_stats(data)
      {pct_ast_2pm: data["PCT_AST_2PM"], pct_uast_2pm: data["PCT_UAST_2PM"],
       pct_ast_3pm: data["PCT_AST_3PM"], pct_uast_3pm: data["PCT_UAST_3PM"],
       pct_ast_fgm: data["PCT_AST_FGM"], pct_uast_fgm: data["PCT_UAST_FGM"]}
    end
    private_class_method :assist_stats
  end
end
