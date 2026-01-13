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
      {season_id: data["SEASON_YEAR"], game_id: data["GAME_ID"],
       game_date: data["GAME_DATE"], matchup: data["MATCHUP"],
       wl: data["WL"], min: data["MIN"]}
    end
    private_class_method :game_info

    # Extracts player information from data
    #
    # @api private
    # @return [Hash]
    def self.player_info(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       team_id: data["TEAM_ID"], team_abbreviation: data["TEAM_ABBREVIATION"],
       team_name: data["TEAM_NAME"]}
    end
    private_class_method :player_info

    # Extracts shooting statistics from data
    #
    # @api private
    # @return [Hash]
    def self.shooting_stats(data)
      {fgm: data["FGM"], fga: data["FGA"], fg_pct: data["FG_PCT"],
       fg3m: data["FG3M"], fg3a: data["FG3A"], fg3_pct: data["FG3_PCT"],
       ftm: data["FTM"], fta: data["FTA"], ft_pct: data["FT_PCT"]}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    #
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
