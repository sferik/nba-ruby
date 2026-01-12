require "json"
require_relative "collection"
require_relative "live_connection"
require_relative "utils"

require_relative "live_action"

module NBA
  # Provides methods to retrieve live play-by-play data
  module LivePlayByPlay
    # Retrieves live play-by-play for a game
    #
    # @api public
    # @example
    #   actions = NBA::LivePlayByPlay.find(game: "0022400001")
    #   actions.each { |a| puts "#{a.clock}: #{a.description}" }
    # @param game [String, Game] the game ID or Game object
    # @param client [LiveConnection] the API client to use
    # @return [Collection] a collection of actions
    def self.find(game:, client: LIVE_CLIENT)
      game_id = Utils.extract_id(game)
      path = "playbyplay/playbyplay_#{game_id}.json"
      response = client.get(path)
      parse_response(response, game_id)
    end

    # Parses the live play-by-play API response
    #
    # @api private
    # @param response [String, nil] the JSON response body
    # @param game_id [String] the game ID
    # @return [Collection] a collection of actions
    def self.parse_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      actions = data.dig("game", "actions")
      return Collection.new unless actions

      live_actions = actions.map { |action| build_action(action, game_id) }
      Collection.new(live_actions)
    end
    private_class_method :parse_response

    # Builds a LiveAction object from raw data
    #
    # @api private
    # @param data [Hash] the action data
    # @param game_id [String] the game ID
    # @return [LiveAction] the live action object
    def self.build_action(data, game_id)
      LiveAction.new(**action_attributes(data, game_id))
    end
    private_class_method :build_action

    # Combines all action attributes
    #
    # @api private
    # @param data [Hash] the action data
    # @param game_id [String] the game ID
    # @return [Hash] the combined attributes
    def self.action_attributes(data, game_id)
      timing_attributes(data, game_id)
        .merge(action_info_attributes(data))
        .merge(player_team_attributes(data))
        .merge(shot_attributes(data))
    end
    private_class_method :action_attributes

    # Extracts timing attributes from data
    #
    # @api private
    # @param data [Hash] the action data
    # @param game_id [String] the game ID
    # @return [Hash] timing attributes
    def self.timing_attributes(data, game_id)
      {game_id: game_id, action_number: data.fetch("actionNumber", nil),
       clock: data.fetch("clock", nil), time_actual: data.fetch("timeActual", nil),
       period: data.fetch("period", nil), period_type: data.fetch("periodType", nil)}
    end
    private_class_method :timing_attributes

    # Extracts action info attributes from data
    #
    # @api private
    # @param data [Hash] the action data
    # @return [Hash] action info attributes
    def self.action_info_attributes(data)
      {action_type: data.fetch("actionType", nil), sub_type: data.fetch("subType", nil),
       qualifiers: data.fetch("qualifiers", nil), description: data.fetch("description", nil),
       score_home: data.fetch("scoreHome", nil), score_away: data.fetch("scoreAway", nil),
       points_total: data.fetch("pointsTotal", nil)}
    end
    private_class_method :action_info_attributes

    # Extracts player and team attributes from data
    #
    # @api private
    # @param data [Hash] the action data
    # @return [Hash] player and team attributes
    def self.player_team_attributes(data)
      {player_id: data.fetch("personId", nil), player_name: data.fetch("playerName", nil),
       player_name_i: data.fetch("playerNameI", nil), team_id: data.fetch("teamId", nil),
       team_tricode: data.fetch("teamTricode", nil)}
    end
    private_class_method :player_team_attributes

    # Extracts shot attributes from data
    #
    # @api private
    # @param data [Hash] the action data
    # @return [Hash] shot attributes
    def self.shot_attributes(data)
      {x_legacy: data.fetch("xLegacy", nil), y_legacy: data.fetch("yLegacy", nil),
       shot_distance: data.fetch("shotDistance", nil), is_field_goal: data.fetch("isFieldGoal", nil),
       shot_result: data.fetch("shotResult", nil)}
    end
    private_class_method :shot_attributes
  end
end
