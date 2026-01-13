require "json"
require_relative "client"
require_relative "collection"
require_relative "shot"
require_relative "league"
require_relative "response_parser"
require_relative "utils"

module NBA
  # Provides methods to retrieve NBA shot chart lineup detail
  module ShotChartLineupDetail
    # Result set name for shot chart lineup detail
    # @return [String] the result set name
    DETAIL_SET = "ShotChartLineupDetail".freeze

    # Result set name for league averages
    # @return [String] the result set name
    AVERAGE_SET = "ShotChartLineupLeagueAverage".freeze

    # Retrieves shot chart lineup detail for a lineup group
    #
    # @api public
    # @example
    #   shots = NBA::ShotChartLineupDetail.all(group_id: 12345, season: 2023)
    #   shots.each { |s| puts "#{s.player_name}: #{s.made? ? 'Made' : 'Missed'}" }
    # @param group_id [Integer] the lineup group ID
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs, etc.)
    # @param context_measure [String] the context measure (FGA, FG3A, etc.)
    # @param period [Integer] the period (0 for all periods)
    # @param league [String, League] the league ID or League object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shots
    def self.all(group_id:, season: Utils.current_season, season_type: "Regular Season",
      context_measure: "FGA", period: 0, league: League::NBA, client: CLIENT)
      league_id = Utils.extract_league_id(league)
      opts = {group_id: group_id, season: season, season_type: season_type,
              context_measure: context_measure, period: period, league_id: league_id}
      ResponseParser.parse(client.get(build_path(opts)), result_set: DETAIL_SET) do |data|
        build_shot(data)
      end
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(opts)
      "shotchartlineupdetail?ContextMeasure=#{opts[:context_measure]}" \
        "&GROUP_ID=#{opts[:group_id]}&LeagueID=#{opts[:league_id]}&Period=#{opts[:period]}" \
        "&Season=#{Utils.format_season(opts[:season])}&SeasonType=#{opts[:season_type]}"
    end
    private_class_method :build_path

    # Builds a Shot object from raw data
    # @api private
    # @param data [Hash] the row data
    # @return [Shot] the shot object
    def self.build_shot(data)
      Shot.new(**shot_attributes(data))
    end
    private_class_method :build_shot

    # Extracts shot attributes from data
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] shot attributes
    def self.shot_attributes(data)
      game_attributes(data).merge(player_attributes(data)).merge(shot_info_attributes(data))
    end
    private_class_method :shot_attributes

    # Extracts game-related attributes
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] game attributes
    def self.game_attributes(data)
      {game_id: data["GAME_ID"], game_event_id: data["GAME_EVENT_ID"],
       period: data["PERIOD"], minutes_remaining: data["MINUTES_REMAINING"],
       seconds_remaining: data["SECONDS_REMAINING"]}
    end
    private_class_method :game_attributes

    # Extracts player-related attributes
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] player attributes
    def self.player_attributes(data)
      {player_id: data["PLAYER_ID"], player_name: data["PLAYER_NAME"],
       team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"]}
    end
    private_class_method :player_attributes

    # Extracts shot info attributes
    # @api private
    # @param data [Hash] the row data
    # @return [Hash] shot info attributes
    def self.shot_info_attributes(data)
      {action_type: data["ACTION_TYPE"], shot_type: data["SHOT_TYPE"],
       shot_zone_basic: data["SHOT_ZONE_BASIC"],
       shot_zone_area: data["SHOT_ZONE_AREA"],
       shot_zone_range: data["SHOT_ZONE_RANGE"],
       shot_distance: data["SHOT_DISTANCE"],
       loc_x: data["LOC_X"], loc_y: data["LOC_Y"],
       shot_attempted_flag: data["SHOT_ATTEMPTED_FLAG"],
       shot_made_flag: data["SHOT_MADE_FLAG"]}
    end
    private_class_method :shot_info_attributes
  end
end
