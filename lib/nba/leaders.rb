require "json"
require_relative "client"
require_relative "collection"
require_relative "leader"
require_relative "response_parser"
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

    # Categories that require Totals mode
    PERCENTAGE_CATEGORIES = [FG_PCT, FG3_PCT, FT_PCT].freeze
    private_constant :PERCENTAGE_CATEGORIES

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
      per_mode = PERCENTAGE_CATEGORIES.include?(category) ? "Totals" : "PerGame"
      path = "leagueleaders?LeagueID=00&PerMode=#{per_mode}&Scope=S&Season=#{Utils.format_season(season)}" \
             "&SeasonType=#{season_type}&StatCategory=#{category}"
      parse_leaders_response(client.get(path), category, limit)
    end

    # Parses the leaders API response (uses resultSet instead of resultSets)
    #
    # @api private
    # @param response [String] the JSON response body
    # @param category [String] the category requested
    # @param limit [Integer] the limit of results
    # @return [Collection] a collection of leaders
    def self.parse_leaders_response(response, category, limit)
      headers, rows = extract_result_set(response)
      return Collection.new unless headers && rows

      leaders = rows.take(limit).map do |row|
        build_leader(ResponseParser.zip_to_hash(headers, row), category)
      end
      Collection.new(leaders)
    end
    private_class_method :parse_leaders_response

    # Extracts result set from API response
    # @api private
    # @return [Array, nil]
    def self.extract_result_set(response)
      return unless response

      result_set = JSON.parse(response)["resultSet"]
      return unless result_set

      [result_set.fetch("headers"), result_set.fetch("rowSet")]
    end
    private_class_method :extract_result_set

    # Builds a leader from API data
    # @api private
    # @return [Leader]
    def self.build_leader(data, category)
      Leader.new(**leader_identity(data), category: category, rank: data.fetch("RANK"), value: data.fetch(category))
    end
    private_class_method :build_leader

    # Extracts leader identity attributes from data
    # @api private
    # @return [Hash]
    def self.leader_identity(data)
      {player_id: data.fetch("PLAYER_ID"), player_name: data.fetch("PLAYER"),
       team_id: data["TEAM_ID"], team_abbreviation: data["TEAM"]}
    end
    private_class_method :leader_identity
  end
end
