require "json"
require_relative "collection"
require_relative "live_connection"
require_relative "live_game"

module NBA
  # Default live client instance
  LIVE_CLIENT = LiveConnection.new

  # Provides methods to retrieve live NBA scoreboard data
  module LiveScoreboard
    # Retrieves today's live scoreboard
    #
    # @api public
    # @example
    #   games = NBA::LiveScoreboard.today
    #   games.each { |g| puts "#{g.away_team_tricode} #{g.away_team_score} @ #{g.home_team_tricode} #{g.home_team_score}" }
    # @param client [LiveConnection] the API client to use
    # @return [Collection] a collection of live games
    def self.today(client: LIVE_CLIENT)
      path = "scoreboard/todaysScoreboard_00.json"
      response = client.get(path)
      parse_response(response)
    end

    # Parses the live scoreboard API response
    #
    # @api private
    # @param response [String, nil] the JSON response body
    # @return [Collection] a collection of live games
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      games = data.dig("scoreboard", "games")
      return Collection.new unless games

      live_games = games.map { |game| build_live_game(game) }
      Collection.new(live_games)
    end
    private_class_method :parse_response

    # Builds a LiveGame object from raw data
    #
    # @api private
    # @param data [Hash] the game data
    # @return [LiveGame] the live game object
    def self.build_live_game(data)
      LiveGame.new(**live_game_attributes(data))
    end
    private_class_method :build_live_game

    # Combines all live game attributes
    #
    # @api private
    # @param data [Hash] the game data
    # @return [Hash] the combined attributes
    def self.live_game_attributes(data)
      game_info_attributes(data).merge(home_team_attributes(data), away_team_attributes(data))
    end
    private_class_method :live_game_attributes

    # Extracts game info attributes from data
    #
    # @api private
    # @param data [Hash] the game data
    # @return [Hash] game info attributes
    def self.game_info_attributes(data)
      {game_id: data.fetch("gameId", nil), game_code: data.fetch("gameCode", nil),
       game_status: data.fetch("gameStatus", nil), game_status_text: data.fetch("gameStatusText", nil),
       period: data.fetch("period", nil), game_clock: data.fetch("gameClock", nil),
       game_time_utc: data.fetch("gameTimeUTC", nil), game_et: data.fetch("gameEt", nil)}
    end
    private_class_method :game_info_attributes

    # Extracts home team attributes from data
    #
    # @api private
    # @param data [Hash] the game data
    # @return [Hash] home team attributes
    def self.home_team_attributes(data)
      home = data.fetch("homeTeam", nil) || {}
      {home_team_id: home.fetch("teamId", nil), home_team_name: home.fetch("teamName", nil),
       home_team_city: home.fetch("teamCity", nil), home_team_tricode: home.fetch("teamTricode", nil),
       home_team_score: home.fetch("score", nil)}
    end
    private_class_method :home_team_attributes

    # Extracts away team attributes from data
    #
    # @api private
    # @param data [Hash] the game data
    # @return [Hash] away team attributes
    def self.away_team_attributes(data)
      away = data.fetch("awayTeam", nil) || {}
      {away_team_id: away.fetch("teamId", nil), away_team_name: away.fetch("teamName", nil),
       away_team_city: away.fetch("teamCity", nil), away_team_tricode: away.fetch("teamTricode", nil),
       away_team_score: away.fetch("score", nil)}
    end
    private_class_method :away_team_attributes
  end
end
