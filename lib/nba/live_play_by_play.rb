require "json"
require_relative "collection"
require_relative "live_connection"
require_relative "utils"

module NBA
  # Represents a live play-by-play action
  class LiveAction < Shale::Mapper
    include Equalizer.new(:action_number, :game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     action.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] action_number
    #   Returns the action number
    #   @api public
    #   @example
    #     action.action_number #=> 1
    #   @return [Integer] the action number
    attribute :action_number, Shale::Type::Integer

    # @!attribute [rw] clock
    #   Returns the game clock at time of action
    #   @api public
    #   @example
    #     action.clock #=> "PT11M47S"
    #   @return [String] the clock in ISO 8601 duration format
    attribute :clock, Shale::Type::String

    # @!attribute [rw] time_actual
    #   Returns the actual time of the action
    #   @api public
    #   @example
    #     action.time_actual #=> "2024-10-22T19:10:00Z"
    #   @return [String] the actual time in UTC
    attribute :time_actual, Shale::Type::String

    # @!attribute [rw] period
    #   Returns the period
    #   @api public
    #   @example
    #     action.period #=> 1
    #   @return [Integer] the period number
    attribute :period, Shale::Type::Integer

    # @!attribute [rw] period_type
    #   Returns the period type
    #   @api public
    #   @example
    #     action.period_type #=> "REGULAR"
    #   @return [String] the period type (REGULAR, OVERTIME)
    attribute :period_type, Shale::Type::String

    # @!attribute [rw] action_type
    #   Returns the action type
    #   @api public
    #   @example
    #     action.action_type #=> "2pt"
    #   @return [String] the action type
    attribute :action_type, Shale::Type::String

    # @!attribute [rw] sub_type
    #   Returns the action subtype
    #   @api public
    #   @example
    #     action.sub_type #=> "LAYUP"
    #   @return [String] the action subtype
    attribute :sub_type, Shale::Type::String

    # @!attribute [rw] qualifier
    #   Returns any qualifier for the action
    #   @api public
    #   @example
    #     action.qualifiers #=> ["DRIVING"]
    #   @return [Array<String>] the qualifiers
    attribute :qualifiers, Shale::Type::String, collection: true

    # @!attribute [rw] description
    #   Returns the play description
    #   @api public
    #   @example
    #     action.description #=> "Curry Driving Layup"
    #   @return [String] the description
    attribute :description, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID involved in the action
    #   @api public
    #   @example
    #     action.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     action.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] player_name_i
    #   Returns the player name in abbreviated format
    #   @api public
    #   @example
    #     action.player_name_i #=> "S. Curry"
    #   @return [String] the abbreviated player name
    attribute :player_name_i, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     action.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_tricode
    #   Returns the team tricode
    #   @api public
    #   @example
    #     action.team_tricode #=> "GSW"
    #   @return [String] the team tricode
    attribute :team_tricode, Shale::Type::String

    # @!attribute [rw] score_home
    #   Returns the home team score after this action
    #   @api public
    #   @example
    #     action.score_home #=> "2"
    #   @return [String] the home score
    attribute :score_home, Shale::Type::String

    # @!attribute [rw] score_away
    #   Returns the away team score after this action
    #   @api public
    #   @example
    #     action.score_away #=> "0"
    #   @return [String] the away score
    attribute :score_away, Shale::Type::String

    # @!attribute [rw] points_total
    #   Returns the points from this action
    #   @api public
    #   @example
    #     action.points_total #=> 2
    #   @return [Integer] the points
    attribute :points_total, Shale::Type::Integer

    # @!attribute [rw] x_legacy
    #   Returns the x coordinate on the court
    #   @api public
    #   @example
    #     action.x_legacy #=> 5.0
    #   @return [Float] the x coordinate
    attribute :x_legacy, Shale::Type::Float

    # @!attribute [rw] y_legacy
    #   Returns the y coordinate on the court
    #   @api public
    #   @example
    #     action.y_legacy #=> 25.0
    #   @return [Float] the y coordinate
    attribute :y_legacy, Shale::Type::Float

    # @!attribute [rw] shot_distance
    #   Returns the shot distance
    #   @api public
    #   @example
    #     action.shot_distance #=> 2.5
    #   @return [Float] the shot distance in feet
    attribute :shot_distance, Shale::Type::Float

    # @!attribute [rw] is_field_goal
    #   Returns whether this is a field goal attempt
    #   @api public
    #   @example
    #     action.is_field_goal #=> 1
    #   @return [Integer] 1 if field goal, 0 otherwise
    attribute :is_field_goal, Shale::Type::Integer

    # @!attribute [rw] shot_result
    #   Returns the shot result
    #   @api public
    #   @example
    #     action.shot_result #=> "Made"
    #   @return [String] "Made" or "Missed"
    attribute :shot_result, Shale::Type::String

    # Returns the player object
    #
    # @api public
    # @example
    #   action.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   action.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns whether this is a field goal attempt
    #
    # @api public
    # @example
    #   action.field_goal? #=> true
    # @return [Boolean] true if field goal attempt
    def field_goal?
      is_field_goal.eql?(1)
    end

    # Returns whether this shot was made
    #
    # @api public
    # @example
    #   action.made? #=> true
    # @return [Boolean] true if shot was made
    def made?
      shot_result.eql?("Made")
    end

    # Returns whether this shot was missed
    #
    # @api public
    # @example
    #   action.missed? #=> true
    # @return [Boolean] true if shot was missed
    def missed?
      shot_result.eql?("Missed")
    end
  end

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
