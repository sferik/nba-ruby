require_relative "client"
require_relative "response_parser"
require_relative "game_log"
require_relative "utils"

module NBA
  # Provides methods to retrieve player game logs in batch
  #
  # @api public
  module PlayerGameLogs
    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Per game mode
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Totals mode
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Result set name
    # @return [String] the result set name
    RESULT_SET_NAME = "PlayerGameLogs".freeze

    # Retrieves game logs for all players matching the criteria
    #
    # @api public
    # @example
    #   logs = NBA::PlayerGameLogs.all(season: 2024)
    #   logs.each { |log| puts "#{log.game_date}: #{log.player_name} - #{log.pts} pts" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param player [Integer, Player, nil] filter by player ID or Player object
    # @param team [Integer, Team, nil] filter by team ID or Team object
    # @param per_mode [String] the per mode (PerGame, Totals)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of game logs
    def self.all(season: Utils.current_season, season_type: REGULAR_SEASON, player: nil, team: nil,
      per_mode: PER_GAME, client: CLIENT)
      path = build_path(season, season_type, player, team, per_mode)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_game_log(data) }
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the API path
    def self.build_path(season, season_type, player, team, per_mode)
      path = "playergamelogs?LeagueID=00&Season=#{Utils.format_season(season)}" \
             "&SeasonType=#{season_type}&PerModeSimple=#{per_mode}"
      path += "&PlayerID=#{Utils.extract_id(player)}" if player
      path += "&TeamID=#{Utils.extract_id(team)}" if team
      path
    end
    private_class_method :build_path

    # Builds a game log from API data
    #
    # @api private
    # @return [GameLog]
    def self.build_game_log(data)
      GameLog.new(**game_info(data), **player_info(data), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_game_log

    # Extracts game information from data
    #
    # @api private
    # @return [Hash]
    def self.game_info(data)
      {season_id: data.fetch("SEASON_YEAR", nil), game_id: data.fetch("GAME_ID", nil),
       game_date: data.fetch("GAME_DATE", nil), matchup: data.fetch("MATCHUP", nil),
       wl: data.fetch("WL", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :game_info

    # Extracts player information from data
    #
    # @api private
    # @return [Hash]
    def self.player_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       team_name: data.fetch("TEAM_NAME", nil)}
    end
    private_class_method :player_info

    # Extracts shooting statistics from data
    #
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    #
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
