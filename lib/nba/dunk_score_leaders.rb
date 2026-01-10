require "json"
require_relative "client"
require_relative "collection"
require_relative "dunk_score_leader"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve dunk score leaders from the draft combine
  module DunkScoreLeaders
    # Result set name for dunk score leaders
    # @return [String] the result set name
    RESULT_SET = "DunkScoreLeaders".freeze

    # Retrieves dunk score leaders for a season
    #
    # @api public
    # @example
    #   leaders = NBA::DunkScoreLeaders.all(season: 2023)
    #   leaders.each { |leader| puts "#{leader.rank}. #{leader.player_name}: #{leader.dunk_score}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, All Star, etc.)
    # @param player [Integer, Player, nil] optional player ID or Player object to filter by
    # @param team [Integer, Team, nil] optional team ID or Team object to filter by
    # @param game [String, Game, nil] optional game ID or Game object to filter by
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of dunk score leaders
    def self.all(season: Utils.current_season, season_type: "Regular Season", player: nil, team: nil, game: nil,
      league: League::NBA, client: CLIENT)
      params = build_params(season: season, season_type: season_type, player: player, team: team, game: game,
        league: league)
      path = build_path(params)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET) { |data| build_leader(data) }
    end

    # Builds the params hash for the API request
    # @api private
    # @return [Hash] the params hash
    def self.build_params(season:, season_type:, player:, team:, game:, league:)
      {season: Utils.format_season(season), season_type: season_type, league_id: Utils.extract_league_id(league),
       player_id: Utils.extract_id(player), team_id: Utils.extract_id(team), game_id: Utils.extract_id(game)}
    end
    private_class_method :build_params

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(params)
      base = "dunkscoreleaders?LeagueID=#{params.fetch(:league_id)}&Season=#{params.fetch(:season)}"
      season_type = "&SeasonType=#{params.fetch(:season_type)}"
      filter = "&PlayerID=#{params.fetch(:player_id)}&TeamID=#{params.fetch(:team_id)}&GameID=#{params.fetch(:game_id)}"
      "#{base}#{season_type}#{filter}"
    end
    private_class_method :build_path

    # Builds a DunkScoreLeader object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [DunkScoreLeader] the leader object
    def self.build_leader(data)
      DunkScoreLeader.new(**leader_attributes(data))
    end
    private_class_method :build_leader

    # Extracts leader attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] leader attributes
    def self.leader_attributes(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       rank: data.fetch("RANK", nil), dunk_score: data.fetch("DUNK_SCORE", nil)}
    end
    private_class_method :leader_attributes
  end
end
