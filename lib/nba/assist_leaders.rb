require "json"
require_relative "client"
require_relative "collection"
require_relative "assist_leader"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA assist leaders
  module AssistLeaders
    # Result set name for assist leaders
    # @return [String] the result set name
    RESULT_SET = "AssistLeaders".freeze

    # Retrieves assist leaders for a season
    #
    # @api public
    # @example
    #   leaders = NBA::AssistLeaders.all(season: 2023)
    #   leaders.each { |leader| puts "#{leader.rank}. #{leader.player_name}: #{leader.ast}" }
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param per_mode [String] the per mode (Totals, PerGame)
    # @param player_or_team [String] player or team stats (Player, Team)
    # @param league [String, League] the league ID or League object (default NBA)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of assist leaders
    def self.all(season: Utils.current_season, season_type: "Regular Season", per_mode: "Totals",
      player_or_team: "Player", league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      path = build_path(season, season_type, per_mode, player_or_team, league_id)
      ResponseParser.parse(client.get(path), result_set: RESULT_SET) { |data| build_leader(data) }
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(season, season_type, per_mode, player_or_team, league_id)
      "assistleaders?LeagueID=#{league_id}&PerMode=#{per_mode}&PlayerOrTeam=#{player_or_team}" \
        "&Season=#{Utils.format_season(season)}&SeasonType=#{season_type}"
    end
    private_class_method :build_path

    # Builds an AssistLeader object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [AssistLeader] the leader object
    def self.build_leader(data)
      AssistLeader.new(**leader_attributes(data))
    end
    private_class_method :build_leader

    # Extracts leader attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] leader attributes
    def self.leader_attributes(data)
      {player_id: data.fetch("PLAYER_ID", nil), player_name: data.fetch("PLAYER_NAME", nil),
       team_id: data.fetch("TEAM_ID", nil), team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil),
       rank: data.fetch("RANK", nil), ast: data.fetch("AST", nil)}
    end
    private_class_method :leader_attributes
  end
end
