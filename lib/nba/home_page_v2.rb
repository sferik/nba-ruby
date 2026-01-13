require "json"
require_relative "client"
require_relative "collection"
require_relative "home_page_stat"
require_relative "league"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA home page V2 statistics
  module HomePageV2
    # Stat categories available in home page V2
    STAT_CATEGORIES = {
      pts: "HomePageStat1",
      reb: "HomePageStat2",
      ast: "HomePageStat3",
      stl: "HomePageStat4",
      fg_pct: "HomePageStat5",
      ft_pct: "HomePageStat6",
      fg3_pct: "HomePageStat7",
      blk: "HomePageStat8"
    }.freeze

    # Retrieves home page V2 statistics for a stat category
    #
    # @api public
    # @example
    #   stats = NBA::HomePageV2.all(stat_category: :pts, season: 2023)
    #   stats.each { |s| puts "#{s.rank}. #{s.team_abbreviation}: #{s.value}" }
    # @param stat_category [Symbol] the stat category (:pts, :reb, :ast, etc.)
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param game_scope [String] the game scope (Season, Yesterday, etc.)
    # @param player_or_team [String] player or team stats (Player, Team)
    # @param player_scope [String] the player scope (All Players, Rookies)
    # @param stat_type [String] the stat type (Traditional, Advanced, etc.)
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of home page stats
    def self.all(stat_category:, season: Utils.current_season, season_type: "Regular Season",
      game_scope: "Season", player_or_team: "Team", player_scope: "All Players",
      stat_type: "Traditional", league: League::NBA, client: CLIENT)
      result_set = STAT_CATEGORIES.fetch(stat_category)
      league_id = Utils.extract_league_id(league)
      opts = {season: season, season_type: season_type, game_scope: game_scope,
              player_or_team: player_or_team, player_scope: player_scope,
              stat_type: stat_type, league_id: league_id}
      response = client.get(build_path(opts))
      parse_response(response, result_set, stat_category)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "homepagev2?GameScope=#{opts[:game_scope]}&LeagueID=#{opts[:league_id]}" \
        "&PlayerOrTeam=#{opts[:player_or_team]}&PlayerScope=#{opts[:player_scope]}" \
        "&Season=#{Utils.format_season(opts[:season])}&SeasonType=#{opts[:season_type]}" \
        "&StatType=#{opts[:stat_type]}"
    end
    private_class_method :build_path

    # Parses the API response
    # @api private
    # @param response [String, nil] the raw API response
    # @param result_set [String] the result set name
    # @param stat_category [Symbol] the stat category
    # @return [Collection] parsed stats
    def self.parse_response(response, result_set, stat_category)
      ResponseParser.parse(response, result_set: result_set) do |data|
        build_stat(data, stat_category)
      end
    end
    private_class_method :parse_response

    # Builds a HomePageStat object from raw data
    # @api private
    # @param data [Hash] the row data
    # @param stat_category [Symbol] the stat category
    # @return [HomePageStat] the stat object
    def self.build_stat(data, stat_category)
      HomePageStat.new(**stat_attributes(data, stat_category))
    end
    private_class_method :build_stat

    # Extracts stat attributes from data
    # @api private
    # @param data [Hash] the row data
    # @param stat_category [Symbol] the stat category name
    # @return [Hash] stat attributes
    def self.stat_attributes(data, stat_category)
      {rank: data["RANK"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"],
       team_name: data["TEAM_NAME"],
       value: extract_value(data), stat_name: stat_category}
    end
    private_class_method :stat_attributes

    # Extracts the stat value from data (different keys per result set)
    # @api private
    # @param data [Hash] the row data
    # @return [Float, nil] the stat value
    def self.extract_value(data)
      value_keys = %w[PTS REB AST STL FG_PCT FT_PCT FG3_PCT BLK]
      value_keys.each { |key| return data.fetch(key) if data.key?(key) }
      nil
    end
    private_class_method :extract_value
  end
end
