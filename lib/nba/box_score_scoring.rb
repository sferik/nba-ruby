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

    # Extracts shot distribution statistics from data
    # @api private
    # @return [Hash]
    def self.shot_distribution(data)
      {pct_fga_2pt: data.fetch("PCT_FGA_2PT", nil), pct_fga_3pt: data.fetch("PCT_FGA_3PT", nil),
       pct_pts_2pt: data.fetch("PCT_PTS_2PT", nil), pct_pts_2pt_mr: data.fetch("PCT_PTS_2PT_MR", nil),
       pct_pts_3pt: data.fetch("PCT_PTS_3PT", nil), pct_pts_fb: data.fetch("PCT_PTS_FB", nil),
       pct_pts_ft: data.fetch("PCT_PTS_FT", nil), pct_pts_off_tov: data.fetch("PCT_PTS_OFF_TOV", nil),
       pct_pts_paint: data.fetch("PCT_PTS_PAINT", nil)}
    end
    private_class_method :shot_distribution

    # Extracts assist statistics from data
    # @api private
    # @return [Hash]
    def self.assist_stats(data)
      {pct_ast_2pm: data.fetch("PCT_AST_2PM", nil), pct_uast_2pm: data.fetch("PCT_UAST_2PM", nil),
       pct_ast_3pm: data.fetch("PCT_AST_3PM", nil), pct_uast_3pm: data.fetch("PCT_UAST_3PM", nil),
       pct_ast_fgm: data.fetch("PCT_AST_FGM", nil), pct_uast_fgm: data.fetch("PCT_UAST_FGM", nil)}
    end
    private_class_method :assist_stats
  end
end
