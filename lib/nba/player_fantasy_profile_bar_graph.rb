require "json"
require_relative "client"
require_relative "collection"
require_relative "fantasy_profile_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player fantasy profile bar graph statistics
  #
  # @api public
  module PlayerFantasyProfileBarGraph
    # Result set name for last five games average
    # @return [String] the result set name
    LAST_FIVE_GAMES_AVG = "LastFiveGamesAvg".freeze

    # Result set name for season average
    # @return [String] the result set name
    SEASON_AVG = "SeasonAvg".freeze

    # Retrieves last five games average statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerFantasyProfileBarGraph.last_five_games_avg(player: 201939)
    #   stats.first.fan_duel_pts #=> 45.2
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of fantasy profile statistics
    def self.last_five_games_avg(player:, season: Utils.current_season, season_type: "Regular Season",
      client: CLIENT)
      path = build_path(player, season, season_type)
      response = client.get(path)
      parse_response(response, LAST_FIVE_GAMES_AVG)
    end

    # Retrieves season average statistics for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerFantasyProfileBarGraph.season_avg(player: 201939)
    #   stats.first.nba_fantasy_pts #=> 52.1
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of fantasy profile statistics
    def self.season_avg(player:, season: Utils.current_season, season_type: "Regular Season",
      client: CLIENT)
      path = build_path(player, season, season_type)
      response = client.get(path)
      parse_response(response, SEASON_AVG)
    end

    # Builds the API path
    #
    # @api private
    # @return [String] the request path
    def self.build_path(player, season, season_type)
      player_id = Utils.extract_id(player)
      season_str = Utils.format_season(season)
      "playerfantasyprofilebargraph?PlayerID=#{player_id}&Season=#{season_str}" \
        "&SeasonType=#{season_type}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into fantasy profile stat objects
    #
    # @api private
    # @return [Collection] collection of fantasy profile stats
    def self.parse_response(response, result_set_name)
      return Collection.new if response.nil? || response.empty?

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      build_collection(result_set)
    end
    private_class_method :parse_response

    # Finds a result set by name
    #
    # @api private
    # @return [Hash, nil] the result set hash or nil if not found
    def self.find_result_set(data, result_set_name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(result_set_name) }
    end
    private_class_method :find_result_set

    # Builds a collection from a result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.build_collection(result_set)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_fantasy_profile_stat(headers.zip(row).to_h) })
    end
    private_class_method :build_collection

    # Builds a fantasy profile stat from API data
    #
    # @api private
    # @return [FantasyProfileStat] the fantasy profile stat object
    def self.build_fantasy_profile_stat(data)
      FantasyProfileStat.new(**identity_info(data), **fantasy_info(data), **stat_info(data))
    end
    private_class_method :build_fantasy_profile_stat

    # Extracts identity information from data
    #
    # @api private
    # @return [Hash] the identity information hash
    def self.identity_info(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil)}
    end
    private_class_method :identity_info

    # Extracts fantasy information from data
    #
    # @api private
    # @return [Hash] the fantasy information hash
    def self.fantasy_info(data)
      {fan_duel_pts: data.fetch("FAN_DUEL_PTS", nil), nba_fantasy_pts: data.fetch("NBA_FANTASY_PTS", nil)}
    end
    private_class_method :fantasy_info

    # Extracts stat information from data
    #
    # @api private
    # @return [Hash] the stat information hash
    def self.stat_info(data)
      {pts: data.fetch("PTS", nil), reb: data.fetch("REB", nil), ast: data.fetch("AST", nil),
       fg3m: data.fetch("FG3M", nil), fg_pct: data.fetch("FG_PCT", nil), ft_pct: data.fetch("FT_PCT", nil),
       stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil), tov: data.fetch("TOV", nil)}
    end
    private_class_method :stat_info
  end
end
