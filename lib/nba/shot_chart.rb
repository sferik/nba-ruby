require_relative "client"
require_relative "response_parser"
require_relative "shot"
require_relative "utils"

module NBA
  # Provides methods to retrieve shot chart data
  module ShotChart
    # Result set name for shot chart detail
    # @return [String] the result set name
    RESULT_SET_NAME = "Shot_Chart_Detail".freeze

    # Retrieves shot chart data for a player
    #
    # @api public
    # @example
    #   shots = NBA::ShotChart.find(player: 201939, team: Team::GSW)
    #   shots.each { |s| puts "#{s.action_type} at (#{s.loc_x}, #{s.loc_y}): #{s.made? ? 'Made' : 'Missed'}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year (defaults to current season)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of shots
    def self.find(player:, team:, season: Utils.current_season, client: CLIENT)
      path = "shotchartdetail?PlayerID=#{Utils.extract_id(player)}&TeamID=#{Utils.extract_id(team)}" \
             "&Season=#{Utils.format_season(season)}&ContextMeasure=FGA"
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_shot(data) }
    end

    # Builds a shot from API data
    # @api private
    # @return [Shot]
    def self.build_shot(data)
      Shot.new(**identity_info(data), **timing_info(data), **shot_info(data), **location_info(data))
    end
    private_class_method :build_shot

    # Extracts identity information from data
    # @api private
    # @return [Hash]
    def self.identity_info(data)
      {game_id: data["GAME_ID"], game_event_id: data["GAME_EVENT_ID"], player_id: data["PLAYER_ID"],
       player_name: data["PLAYER_NAME"], team_id: data["TEAM_ID"], team_name: data["TEAM_NAME"]}
    end
    private_class_method :identity_info

    # Extracts timing information from data
    # @api private
    # @return [Hash]
    def self.timing_info(data)
      {period: data["PERIOD"], minutes_remaining: data["MINUTES_REMAINING"],
       seconds_remaining: data["SECONDS_REMAINING"]}
    end
    private_class_method :timing_info

    # Extracts shot information from data
    # @api private
    # @return [Hash]
    def self.shot_info(data)
      {action_type: data["ACTION_TYPE"], shot_type: data["SHOT_TYPE"],
       shot_zone_basic: data["SHOT_ZONE_BASIC"], shot_zone_area: data["SHOT_ZONE_AREA"],
       shot_zone_range: data["SHOT_ZONE_RANGE"], shot_distance: data["SHOT_DISTANCE"],
       shot_attempted_flag: data["SHOT_ATTEMPTED_FLAG"], shot_made_flag: data["SHOT_MADE_FLAG"]}
    end
    private_class_method :shot_info

    # Extracts location information from data
    # @api private
    # @return [Hash]
    def self.location_info(data)
      {loc_x: data["LOC_X"], loc_y: data["LOC_Y"]}
    end
    private_class_method :location_info
  end
end
