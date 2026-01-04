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

    # Extracts shooting statistics from data
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    # @api private
    # @return [Hash]
    def self.counting_stats(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TO", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil),
       plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_stats
  end
end
