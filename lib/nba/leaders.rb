require "json"
require_relative "client"
require_relative "collection"
require_relative "leader"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA statistical leaders
  module Leaders
    # Points per game category
    # @return [String] the category code
    PTS = "PTS".freeze
    # Rebounds per game category
    # @return [String] the category code
    REB = "REB".freeze
    # Assists per game category
    # @return [String] the category code
    AST = "AST".freeze
    # Steals per game category
    # @return [String] the category code
    STL = "STL".freeze
    # Blocks per game category
    # @return [String] the category code
    BLK = "BLK".freeze
    # Field goal percentage category
    # @return [String] the category code
    FG_PCT = "FG_PCT".freeze
    # Three point percentage category
    # @return [String] the category code
    FG3_PCT = "FG3_PCT".freeze
    # Free throw percentage category
    # @return [String] the category code
    FT_PCT = "FT_PCT".freeze
    # Efficiency category
    # @return [String] the category code
    EFF = "EFF".freeze

    # Retrieves league leaders for a statistical category
    #
    # @api public
    # @example
    #   leaders = NBA::Leaders.find(category: NBA::Leaders::PTS)
    #   leaders.each { |leader| puts "#{leader.rank}. #{leader.player_name}: #{leader.value}" }
    # @param category [String] the statistical category (PTS, REB, AST, etc.)
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param limit [Integer] the number of results to return (defaults to 10)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of leaders
    def self.find(category:, season: Utils.current_season, season_type: "Regular Season", limit: 10, client: CLIENT)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      path = build_path(category, season_str, season_type)
      response = client.get(path)
      parse_leaders_response(response, category, limit)
    end

    # Categories that require Totals mode
    PERCENTAGE_CATEGORIES = [FG_PCT, FG3_PCT, FT_PCT].freeze
    private_constant :PERCENTAGE_CATEGORIES

    # Builds the API path for leaders
    #
    # @api private
    # @param category [String] the category
    # @param season_str [String] the season string
    # @param season_type [String] the season type
    # @return [String] the API path
    def self.build_path(category, season_str, season_type)
      encoded_season_type = URI.encode_www_form_component(season_type)
      per_mode = PERCENTAGE_CATEGORIES.include?(category) ? "Totals" : "PerGame"
      "leagueleaders?LeagueID=00&PerMode=#{per_mode}&Scope=S&Season=#{season_str}" \
        "&SeasonType=#{encoded_season_type}&StatCategory=#{category}"
    end
    private_class_method :build_path

    # Parses the leaders API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @param category [String] the category requested
    # @param limit [Integer] the limit of results
    # @return [Collection] a collection of leaders
    def self.parse_leaders_response(response, category, limit)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = data.fetch("resultSet", nil)
      return Collection.new unless result_set

      headers = result_set.fetch("headers")
      rows = result_set.fetch("rowSet")
      return Collection.new unless headers && rows

      leaders = rows.take(limit).map { |row| build_leader_from_row(headers, row, category) }
      Collection.new(leaders)
    end
    private_class_method :parse_leaders_response

    # Builds a leader from a row of data
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @param category [String] the category
    # @return [Leader] the leader object
    def self.build_leader_from_row(headers, row, category)
      data = headers.zip(row).to_h
      Leader.new(
        player_id: data.fetch("PLAYER_ID"),
        player_name: data.fetch("PLAYER"),
        team_id: data.fetch("TEAM_ID"),
        team_abbreviation: data.fetch("TEAM"),
        category: category,
        rank: data.fetch("RANK"),
        value: data.fetch(category)
      )
    end
    private_class_method :build_leader_from_row
  end
end
