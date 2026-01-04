require_relative "client"
require_relative "response_parser"
require_relative "career_stats"
require_relative "utils"

module NBA
  # Provides methods to retrieve player career statistics
  module PlayerCareerStats
    # Regular season per game stats type
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Totals stats type
    # @return [String] the per mode
    TOTALS = "Totals".freeze

    # Result set name for regular season stats
    # @return [String] the result set name
    RESULT_SET_NAME = "SeasonTotalsRegularSeason".freeze

    # Retrieves career statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCareerStats.find(player: 201939)
    #   stats.each { |s| puts "#{s.season_id}: #{s.pts} PPG" }
    # @param player [Integer, Player] the player ID or Player object
    # @param per_mode [String] the per mode (PerGame, Totals)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of career stats by season
    def self.find(player:, per_mode: PER_GAME, client: CLIENT)
      player_id = Utils.extract_id(player)
      path = "playercareerstats?PlayerID=#{player_id}&PerMode=#{per_mode}"
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) do |data|
        build_career_stats(data, player_id)
      end
    end

    # Builds career stats from API data
    # @api private
    # @return [CareerStats]
    def self.build_career_stats(data, player_id)
      CareerStats.new(**season_info(data, player_id), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_career_stats

    # Extracts season information from data
    # @api private
    # @return [Hash]
    def self.season_info(data, player_id)
      {player_id: player_id, season_id: data.fetch("SEASON_ID", nil), team_id: data.fetch("TEAM_ID", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), player_age: data.fetch("PLAYER_AGE", nil),
       gp: data.fetch("GP", nil), gs: data.fetch("GS", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :season_info

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
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil)}
    end
    private_class_method :counting_stats
  end
end
