require_relative "client"
require_relative "response_parser"
require_relative "game_log"
require_relative "utils"

module NBA
  # Provides methods to retrieve player game logs
  module PlayerGameLog
    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Retrieves game logs for a player
    #
    # @api public
    # @example
    #   logs = NBA::PlayerGameLog.find(player: 201939)
    #   logs.each { |log| puts "#{log.game_date}: #{log.pts} points" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of game logs
    def self.find(player:, season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      path = "playergamelog?PlayerID=#{Utils.extract_id(player)}&Season=#{Utils.format_season(season)}" \
             "&SeasonType=#{season_type}"
      ResponseParser.parse(client.get(path)) { |data| build_game_log(data) }
    end

    # Builds a game log from API data
    # @api private
    # @return [GameLog]
    def self.build_game_log(data)
      GameLog.new(**game_info(data), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_game_log

    # Extracts game information from data
    # @api private
    # @return [Hash]
    def self.game_info(data)
      {season_id: data.fetch("SEASON_ID", nil), player_id: data.fetch("Player_ID", nil), game_id: data.fetch("Game_ID", nil),
       game_date: data.fetch("GAME_DATE", nil), matchup: data.fetch("MATCHUP", nil), wl: data.fetch("WL", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :game_info

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
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil),
       plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_stats
  end
end
