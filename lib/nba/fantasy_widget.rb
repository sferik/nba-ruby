require "json"
require_relative "client"
require_relative "collection"
require_relative "fantasy_widget_player"
require_relative "league"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA fantasy widget statistics
  module FantasyWidget
    # Result set name for fantasy widget
    # @return [String] the result set name
    RESULT_SET = "FantasyWidgetResult".freeze

    # Retrieves fantasy widget player statistics
    #
    # @api public
    # @example
    #   players = NBA::FantasyWidget.all(season: 2023)
    #   players.each { |p| puts "#{p.player_name}: #{p.fan_duel_pts}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param active_players [String] active players filter (Y, N)
    # @param last_n_games [Integer] filter to last N games
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of fantasy widget players
    def self.all(season: Utils.current_season, season_type: "Regular Season",
      active_players: "Y", last_n_games: 0, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      opts = {season: season, season_type: season_type, active_players: active_players,
              last_n_games: last_n_games, league_id: league_id}
      ResponseParser.parse(client.get(build_path(opts)), result_set: RESULT_SET) do |data|
        build_player(data)
      end
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "fantasywidget?ActivePlayers=#{opts[:active_players]}&LastNGames=#{opts[:last_n_games]}" \
        "&LeagueID=#{opts[:league_id]}&Season=#{Utils.format_season(opts[:season])}" \
        "&SeasonType=#{opts[:season_type]}"
    end
    private_class_method :build_path

    # Builds a FantasyWidgetPlayer object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [FantasyWidgetPlayer] the player object
    def self.build_player(data)
      FantasyWidgetPlayer.new(**player_attributes(data))
    end
    private_class_method :build_player

    # Extracts player attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       player_position: data["PLAYER_POSITION"], team_id: data["TEAM_ID"],
       team_abbreviation: data["TEAM_ABBREVIATION"], gp: data["GP"],
       min: data["MIN"], fan_duel_pts: data["FAN_DUEL_PTS"],
       nba_fantasy_pts: data["NBA_FANTASY_PTS"], pts: data["PTS"],
       reb: data["REB"], ast: data["AST"]}
    end
    private_class_method :player_attributes
  end
end
