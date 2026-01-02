require "json"
require_relative "client"
require_relative "collection"
require_relative "all_time_leader"

module NBA
  # Provides methods to retrieve all-time NBA statistical leaders
  module AllTimeLeaders
    # Points category
    # @return [String] the category code
    PTS = "PTS".freeze
    # Rebounds category
    # @return [String] the category code
    REB = "REB".freeze
    # Assists category
    # @return [String] the category code
    AST = "AST".freeze
    # Steals category
    # @return [String] the category code
    STL = "STL".freeze
    # Blocks category
    # @return [String] the category code
    BLK = "BLK".freeze
    # Field goals made category
    # @return [String] the category code
    FGM = "FGM".freeze
    # Field goals attempted category
    # @return [String] the category code
    FGA = "FGA".freeze
    # Three pointers made category
    # @return [String] the category code
    FG3M = "FG3M".freeze
    # Three pointers attempted category
    # @return [String] the category code
    FG3A = "FG3A".freeze
    # Free throws made category
    # @return [String] the category code
    FTM = "FTM".freeze
    # Free throws attempted category
    # @return [String] the category code
    FTA = "FTA".freeze
    # Games played category
    # @return [String] the category code
    GP = "GP".freeze
    # Turnovers category
    # @return [String] the category code
    TOV = "TOV".freeze
    # Personal fouls category
    # @return [String] the category code
    PF = "PF".freeze
    # Offensive rebounds category
    # @return [String] the category code
    OREB = "OREB".freeze
    # Defensive rebounds category
    # @return [String] the category code
    DREB = "DREB".freeze

    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze
    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Totals per mode
    # @return [String] the per mode
    TOTALS = "Totals".freeze
    # Per game per mode
    # @return [String] the per mode
    PER_GAME = "PerGame".freeze

    # Category to result set mapping
    CATEGORY_RESULT_SETS = {
      PTS => "PTSLeaders", REB => "REBLeaders", AST => "ASTLeaders",
      STL => "STLLeaders", BLK => "BLKLeaders", FGM => "FGMLeaders",
      FGA => "FGALeaders", FG3M => "FG3MLeaders", FG3A => "FG3ALeaders",
      FTM => "FTMLeaders", FTA => "FTALeaders", GP => "GPLeaders",
      TOV => "TOVLeaders", PF => "PFLeaders", OREB => "OREBLeaders",
      DREB => "DREBLeaders"
    }.freeze
    private_constant :CATEGORY_RESULT_SETS

    # Retrieves all-time leaders for a statistical category
    #
    # @api public
    # @example
    #   leaders = NBA::AllTimeLeaders.find(category: NBA::AllTimeLeaders::PTS)
    #   leaders.each { |l| puts "#{l.rank}. #{l.player_name}: #{l.value.to_i}" }
    # @param category [String] the statistical category (PTS, REB, AST, etc.)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param per_mode [String] the per mode (Totals, PerGame)
    # @param limit [Integer] number of results to return (default 10)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of all-time leaders
    def self.find(category:, season_type: REGULAR_SEASON, per_mode: TOTALS, limit: 10, client: CLIENT)
      path = build_path(season_type, per_mode, limit)
      response = client.get(path)
      parse_response(response, category, limit)
    end

    # Builds the API path
    # @api private
    # @param season_type [String] the season type
    # @param per_mode [String] the per mode
    # @param limit [Integer] the limit
    # @return [String] the path
    def self.build_path(season_type, per_mode, limit)
      "alltimeleadersgrids?LeagueID=00&PerMode=#{per_mode}&SeasonType=#{season_type}&TopX=#{limit}"
    end
    private_class_method :build_path

    # Parses the API response
    # @api private
    # @param response [String, nil] the JSON response
    # @param category [String] the category
    # @param limit [Integer] the limit
    # @return [Collection] collection of leaders
    def self.parse_response(response, category, limit)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, CATEGORY_RESULT_SETS[category])
      return Collection.new unless result_set

      build_leaders(result_set, category, limit)
    end
    private_class_method :parse_response

    # Finds a result set by name
    # @api private
    # @param data [Hash] the parsed JSON
    # @param name [String] the result set name
    # @return [Hash, nil] the result set
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name").eql?(name) }
    end
    private_class_method :find_result_set

    # Builds leaders collection from result set
    # @api private
    # @param result_set [Hash] the result set
    # @param category [String] the category
    # @param limit [Integer] the limit
    # @return [Collection] collection of leaders
    def self.build_leaders(result_set, category, limit)
      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      leaders = rows.take(limit).map.with_index(1) do |row, rank|
        build_leader(headers, row, category, rank)
      end
      Collection.new(leaders)
    end
    private_class_method :build_leaders

    # Builds a single leader
    # @api private
    # @param headers [Array<String>] the headers
    # @param row [Array] the row data
    # @param category [String] the category
    # @param rank [Integer] the rank
    # @return [AllTimeLeader] the leader
    def self.build_leader(headers, row, category, rank)
      data = headers.zip(row).to_h
      AllTimeLeader.new(**leader_attributes(data, category, rank))
    end
    private_class_method :build_leader

    # Extracts leader attributes from data
    # @api private
    # @param data [Hash] the raw data
    # @param category [String] the category
    # @param rank [Integer] the rank
    # @return [Hash] the attributes
    def self.leader_attributes(data, category, rank)
      {player_id: data.fetch("PLAYER_ID"), player_name: data.fetch("PLAYER_NAME"), category: category,
       value: data.fetch(category), rank: rank, is_active: data.fetch("IS_ACTIVE_FLAG").eql?("Y")}
    end
    private_class_method :leader_attributes
  end
end
