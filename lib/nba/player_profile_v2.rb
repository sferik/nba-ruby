require "json"
require_relative "client"
require_relative "collection"
require_relative "career_stats"
require_relative "utils"

module NBA
  # Provides methods to retrieve comprehensive player profile data
  #
  # @api public
  module PlayerProfileV2
    # Regular season result set name
    # @return [String] the result set name
    CAREER_REGULAR_SEASON = "CareerTotalsRegularSeason".freeze

    # Post season result set name
    # @return [String] the result set name
    CAREER_POST_SEASON = "CareerTotalsPostSeason".freeze

    # Season totals regular season result set name
    # @return [String] the result set name
    SEASON_REGULAR_SEASON = "SeasonTotalsRegularSeason".freeze

    # Season totals post season result set name
    # @return [String] the result set name
    SEASON_POST_SEASON = "SeasonTotalsPostSeason".freeze

    # Retrieves career regular season totals for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerProfileV2.career_regular_season(player: 201939)
    # @param player [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Collection] career regular season totals
    def self.career_regular_season(player:, client: CLIENT)
      fetch_stats(player, CAREER_REGULAR_SEASON, client: client)
    end

    # Retrieves career post season totals for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerProfileV2.career_post_season(player: 201939)
    # @param player [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Collection] career post season totals
    def self.career_post_season(player:, client: CLIENT)
      fetch_stats(player, CAREER_POST_SEASON, client: client)
    end

    # Retrieves season-by-season regular season totals for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerProfileV2.season_regular_season(player: 201939)
    # @param player [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Collection] season-by-season regular season totals
    def self.season_regular_season(player:, client: CLIENT)
      fetch_stats(player, SEASON_REGULAR_SEASON, client: client)
    end

    # Retrieves season-by-season post season totals for a player
    #
    # @api public
    # @example
    #   stats = NBA::PlayerProfileV2.season_post_season(player: 201939)
    # @param player [Integer, Player] the player ID or Player object
    # @param client [Client] the API client to use
    # @return [Collection] season-by-season post season totals
    def self.season_post_season(player:, client: CLIENT)
      fetch_stats(player, SEASON_POST_SEASON, client: client)
    end

    # Fetches stats from a specific result set
    #
    # @api private
    # @return [Collection] the stats collection
    def self.fetch_stats(player, result_set_name, client:)
      player_id = Utils.extract_id(player)
      path = "playerprofilev2?PlayerID=#{player_id}&PerMode=PerGame"
      response = client.get(path)
      parse_result_set(response, result_set_name, player_id)
    end
    private_class_method :fetch_stats

    # Parses a specific result set from the response
    #
    # @api private
    # @return [Collection] the parsed stats collection
    def self.parse_result_set(response, result_set_name, player_id)
      return Collection.new if response.nil? || response.empty?

      result_set = find_result_set(JSON.parse(response), result_set_name)
      build_collection(result_set, player_id)
    end
    private_class_method :parse_result_set

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
    def self.build_collection(result_set, player_id)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      Collection.new(rows.map { |row| build_stats(headers.zip(row).to_h, player_id) })
    end
    private_class_method :build_collection

    # Builds career stats from API data
    #
    # @api private
    # @return [CareerStats] the career stats object
    def self.build_stats(data, player_id)
      CareerStats.new(**season_info(data, player_id), **shooting_stats(data), **counting_stats(data))
    end
    private_class_method :build_stats

    # Extracts season information from data
    #
    # @api private
    # @return [Hash] the season information hash
    def self.season_info(data, player_id)
      {player_id: player_id, season_id: data.fetch("SEASON_ID", nil), team_id: data.fetch("TEAM_ID", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), player_age: data.fetch("PLAYER_AGE", nil),
       gp: data.fetch("GP", nil), gs: data.fetch("GS", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :season_info

    # Extracts shooting statistics from data
    #
    # @api private
    # @return [Hash] the shooting statistics hash
    def self.shooting_stats(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_stats

    # Extracts counting statistics from data
    #
    # @api private
    # @return [Hash] the counting statistics hash
    def self.counting_stats(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil)}
    end
    private_class_method :counting_stats
  end
end
