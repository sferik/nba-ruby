require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

require_relative "player_comparison_stat"

module NBA
  # Provides methods to compare two players
  module PlayerCompare
    # Result set name for overall comparison
    # @return [String] the result set name
    OVERALL_COMPARE = "OverallCompare".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Compares two players overall stats
    #
    # @api public
    # @example
    #   stats = NBA::PlayerCompare.compare(
    #     player: 201939,
    #     vs_player: 2544,
    #     season: 2024
    #   )
    #   stats.each { |s| puts "#{s.full_name}: #{s.pts} ppg" }
    # @param player [Integer, Player] the first player ID or Player object
    # @param vs_player [Integer, Player] the second player ID or Player object
    # @param season [Integer] the season year
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of comparison stats
    def self.compare(player:, vs_player:, season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      player_id = extract_player_id(player)
      vs_player_id = extract_player_id(vs_player)
      path = build_path(player_id, vs_player_id, season, season_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(player_id, vs_player_id, season, season_type)
      season_str = Utils.format_season(season)
      encoded_type = season_type
      "playercompare?PlayerIDList=#{player_id}&VsPlayerIDList=#{vs_player_id}" \
        "&Season=#{season_str}&SeasonType=#{encoded_type}&PerMode=PerGame&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into comparison stat objects
    # @api private
    # @return [Collection] collection of comparison stats
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      stats = rows.map { |row| build_comparison_stat(headers, row) }
      Collection.new(stats)
    end
    private_class_method :parse_response

    # Finds the overall compare result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(OVERALL_COMPARE) }
    end
    private_class_method :find_result_set

    # Builds a PlayerComparisonStat object from raw data
    # @api private
    # @return [PlayerComparisonStat] the comparison stat object
    def self.build_comparison_stat(headers, row)
      data = headers.zip(row).to_h
      PlayerComparisonStat.new(**comparison_attributes(data))
    end
    private_class_method :build_comparison_stat

    # Combines all comparison attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.comparison_attributes(data)
      identity_attributes(data).merge(shooting_attributes(data), counting_attributes(data), advanced_attributes(data))
    end
    private_class_method :comparison_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {player_id: data.fetch("PLAYER_ID"), first_name: data.fetch("FIRST_NAME"),
       last_name: data.fetch("LAST_NAME"), season_id: data.fetch("SEASON_ID"),
       gp: data.fetch("GP"), min: data.fetch("MIN")}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes from data
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM"), fga: data.fetch("FGA"), fg_pct: data.fetch("FG_PCT"),
       fg3m: data.fetch("FG3M"), fg3a: data.fetch("FG3A"), fg3_pct: data.fetch("FG3_PCT"),
       ftm: data.fetch("FTM"), fta: data.fetch("FTA"), ft_pct: data.fetch("FT_PCT")}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB"), dreb: data.fetch("DREB"), reb: data.fetch("REB"),
       ast: data.fetch("AST"), stl: data.fetch("STL"), blk: data.fetch("BLK"),
       tov: data.fetch("TOV"), pf: data.fetch("PF"), pts: data.fetch("PTS")}
    end
    private_class_method :counting_attributes

    # Extracts advanced stats attributes from data
    # @api private
    # @return [Hash] advanced attributes
    def self.advanced_attributes(data)
      {eff: data.fetch("EFF"), ast_tov: data.fetch("AST_TOV"), stl_tov: data.fetch("STL_TOV")}
    end
    private_class_method :advanced_attributes

    # Extracts player ID from a Player object or returns the integer
    #
    # @api private
    # @param player [Player, Integer] the player or player ID
    # @return [Integer] the player ID
    def self.extract_player_id(player)
      case player
      when Player then player.id
      else player
      end
    end
    private_class_method :extract_player_id
  end
end
