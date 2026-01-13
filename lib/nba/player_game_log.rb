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
      {season_id: data["SEASON_ID"], player_id: data["Player_ID"], game_id: data["Game_ID"],
       game_date: data["GAME_DATE"], matchup: data["MATCHUP"], wl: data["WL"], min: data["MIN"]}
    end
    private_class_method :game_info

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
       tov: data["TOV"], pf: data["PF"], pts: data["PTS"],
       plus_minus: data["PLUS_MINUS"]}
    end
    private_class_method :counting_stats
  end
end
