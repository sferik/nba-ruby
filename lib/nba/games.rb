require_relative "client"
require_relative "game"
require_relative "response_parser"
require_relative "teams"

module NBA
  # Provides methods to retrieve NBA games
  module Games
    # Game status lookup table
    GAME_STATUSES = {1 => "Scheduled", 2 => "In Progress", 3 => "Final"}.freeze
    private_constant :GAME_STATUSES

    # Finds a game by ID
    #
    # @api public
    # @example
    #   game = NBA::Games.find("0022400001")
    #   puts "#{game.away_team.name} @ #{game.home_team.name}: #{game.away_score}-#{game.home_score}"
    # @param game_id [String] the game ID
    # @param client [Client] the API client to use
    # @return [Game, nil] the game or nil if not found
    def self.find(game_id, client: CLIENT)
      return unless game_id

      path = "boxscoresummaryv2?GameID=#{game_id}"
      ResponseParser.parse_single(client.get(path), result_set: "GameSummary") { |data| build_game(data) }
    end

    # Builds a game from summary data
    #
    # @api private
    # @param data [Hash] the game summary data
    # @return [Game] the game object
    def self.build_game(data)
      Game.new(
        id: data["GAME_ID"],
        date: data["GAME_DATE_EST"],
        status: GAME_STATUSES.fetch(data["GAME_STATUS_ID"], "Unknown"),
        home_team: Teams.find(data["HOME_TEAM_ID"]),
        away_team: Teams.find(data["VISITOR_TEAM_ID"]),
        arena: data["ARENA"]
      )
    end
    private_class_method :build_game
  end
end
