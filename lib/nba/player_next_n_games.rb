require_relative "client"
require_relative "response_parser"
require_relative "upcoming_game"
require_relative "utils"

module NBA
  # Provides methods to retrieve a player's upcoming games
  #
  # @api public
  module PlayerNextNGames
    # Result set name
    # @return [String] the result set name
    RESULT_SET_NAME = "NextNGames".freeze

    # Retrieves upcoming games for a player
    #
    # @api public
    # @example
    #   games = NBA::PlayerNextNGames.find(player: 201939, number_of_games: 5)
    #   games.each { |g| puts "#{g.game_date}: vs #{g.visitor_team_name}" }
    # @param player [Integer, Player] the player ID or Player object
    # @param number_of_games [Integer] the number of games to return
    # @param client [Client] the API client to use
    # @return [Collection] a collection of upcoming games
    def self.find(player:, number_of_games: 5, client: CLIENT)
      id = Utils.extract_id(player)
      path = "playernextngames?PlayerID=#{id}&NumberOfGames=#{number_of_games}&LeagueID=00"
      ResponseParser.parse(client.get(path), result_set: RESULT_SET_NAME) { |data| build_game(data) }
    end

    # Builds an upcoming game from API data
    #
    # @api private
    # @return [UpcomingGame]
    def self.build_game(data)
      UpcomingGame.new(**game_info(data), **team_info(data))
    end
    private_class_method :build_game

    # Extracts game information from data
    #
    # @api private
    # @return [Hash]
    def self.game_info(data)
      {game_id: data["GAME_ID"], game_date: data["GAME_DATE"],
       game_time: data["GAME_TIME"]}
    end
    private_class_method :game_info

    # Extracts team information from data
    #
    # @api private
    # @return [Hash]
    def self.team_info(data)
      {home_team_id: data["HOME_TEAM_ID"], visitor_team_id: data["VISITOR_TEAM_ID"],
       home_team_name: data["HOME_TEAM_NAME"], visitor_team_name: data["VISITOR_TEAM_NAME"],
       home_team_abbreviation: data["HOME_TEAM_ABBREVIATION"],
       visitor_team_abbreviation: data["VISITOR_TEAM_ABBREVIATION"],
       home_team_nickname: data["HOME_TEAM_NICKNAME"],
       visitor_team_nickname: data["VISITOR_TEAM_NICKNAME"]}
    end
    private_class_method :team_info
  end
end
