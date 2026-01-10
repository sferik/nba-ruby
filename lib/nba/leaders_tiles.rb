require "json"
require_relative "client"
require_relative "collection"
require_relative "leaders_tile"
require_relative "league"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA leaders tiles statistics
  module LeadersTiles
    # Result set categories available in leaders tiles
    RESULT_SETS = {
      leaders: "LeadersTiles",
      all_time_high: "AllTimeSeasonHigh",
      last_season_high: "LastSeasonHigh",
      low_season_high: "LowSeasonHigh"
    }.freeze

    # Retrieves leaders tiles for a result set category
    #
    # @api public
    # @example
    #   tiles = NBA::LeadersTiles.all(result_set: :leaders, season: 2023)
    #   tiles.each { |t| puts "#{t.rank}. #{t.team_abbreviation}: #{t.pts}" }
    # @param result_set [Symbol] the result set (:leaders, :all_time_high, etc.)
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param game_scope [String] the game scope (Season, Yesterday, etc.)
    # @param player_or_team [String] player or team stats (Player, Team)
    # @param player_scope [String] the player scope (All Players, Rookies)
    # @param stat [String] the stat type (PTS, REB, AST, etc.)
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of leaders tiles
    def self.all(result_set: :leaders, season: Utils.current_season,
      season_type: "Regular Season", game_scope: "Season", player_or_team: "Team",
      player_scope: "All Players", stat: "PTS", league: League::NBA, client: CLIENT)
      result_set_name = RESULT_SETS.fetch(result_set)
      league_id = Utils.extract_league_id(league)
      opts = {season: season, season_type: season_type, game_scope: game_scope,
              player_or_team: player_or_team, player_scope: player_scope,
              stat: stat, league_id: league_id}
      response = client.get(build_path(opts))
      parse_response(response, result_set_name)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "leaderstiles?GameScope=#{opts[:game_scope]}&LeagueID=#{opts[:league_id]}" \
        "&PlayerOrTeam=#{opts[:player_or_team]}&PlayerScope=#{opts[:player_scope]}" \
        "&Season=#{Utils.format_season(opts[:season])}&SeasonType=#{opts[:season_type]}" \
        "&Stat=#{opts[:stat]}"
    end
    private_class_method :build_path

    # Parses the API response
    # @api private
    # @param response [String, nil] the raw API response
    # @param result_set_name [String] the result set name
    # @return [Collection] parsed tiles
    def self.parse_response(response, result_set_name)
      ResponseParser.parse(response, result_set: result_set_name) { |data| build_tile(data) }
    end
    private_class_method :parse_response

    # Builds a LeadersTile object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [LeadersTile] the tile object
    def self.build_tile(data)
      LeadersTile.new(**tile_attributes(data))
    end
    private_class_method :build_tile

    # Extracts tile attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] tile attributes
    def self.tile_attributes(data)
      {rank: data.fetch("RANK", nil), team_id: data.fetch("TEAM_ID", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       team_name: data.fetch("TEAM_NAME", nil), pts: data.fetch("PTS", nil),
       season_year: data.fetch("SEASON_YEAR", nil)}
    end
    private_class_method :tile_attributes
  end
end
