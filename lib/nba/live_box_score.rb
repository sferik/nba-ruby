require "json"
require_relative "collection"
require_relative "live_connection"
require_relative "utils"

require_relative "live_player_stat"

module NBA
  # Provides methods to retrieve live box score data
  module LiveBoxScore
    # Retrieves live box score for a game
    #
    # @api public
    # @example
    #   stats = NBA::LiveBoxScore.find(game: "0022400001")
    #   stats.each { |s| puts "#{s.name}: #{s.points} pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [LiveConnection] the API client to use
    # @return [Collection] a collection of player stats
    def self.find(game:, client: LIVE_CLIENT)
      game_id = Utils.extract_id(game)
      path = "boxscore/boxscore_#{game_id}.json"
      response = client.get(path)
      parse_response(response, game_id)
    end

    # Parses the live box score API response
    #
    # @api private
    # @param response [String, nil] the JSON response body
    # @param game_id [String] the game ID
    # @return [Collection] a collection of player stats
    def self.parse_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      game_data = data["game"]
      return Collection.new unless game_data

      home_players = extract_players(game_data, "homeTeam", game_id)
      away_players = extract_players(game_data, "awayTeam", game_id)
      Collection.new(home_players + away_players)
    end
    private_class_method :parse_response

    # Extracts players from a team's data
    #
    # @api private
    # @param game_data [Hash] the game data
    # @param team_key [String] the team key ("homeTeam" or "awayTeam")
    # @param game_id [String] the game ID
    # @return [Array<LivePlayerStat>] array of player stats
    def self.extract_players(game_data, team_key, game_id)
      team_data = game_data[team_key]
      return [] unless team_data

      players = team_data["players"]
      return [] unless players

      team_id = team_data["teamId"]
      team_tricode = team_data["teamTricode"]

      players.map { |p| build_player_stat(p, game_id, team_id, team_tricode) }
    end
    private_class_method :extract_players

    # Builds a LivePlayerStat object from raw data
    #
    # @api private
    # @param data [Hash] the player data
    # @param game_id [String] the game ID
    # @param team_id [Integer] the team ID
    # @param team_tricode [String] the team tricode
    # @return [LivePlayerStat] the player stat object
    def self.build_player_stat(data, game_id, team_id, team_tricode)
      LivePlayerStat.new(**player_stat_attributes(data, game_id, team_id, team_tricode))
    end
    private_class_method :build_player_stat

    # Combines all player stat attributes
    #
    # @api private
    # @param data [Hash] the player data
    # @param game_id [String] the game ID
    # @param team_id [Integer] the team ID
    # @param team_tricode [String] the team tricode
    # @return [Hash] the combined attributes
    def self.player_stat_attributes(data, game_id, team_id, team_tricode)
      identity_attributes(data, game_id, team_id, team_tricode)
        .merge(counting_attributes(data))
        .merge(shooting_attributes(data))
    end
    private_class_method :player_stat_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @param data [Hash] the player data
    # @param game_id [String] the game ID
    # @param team_id [Integer] the team ID
    # @param team_tricode [String] the team tricode
    # @return [Hash] identity attributes
    def self.identity_attributes(data, game_id, team_id, team_tricode)
      {game_id: game_id, player_id: data["personId"], name: data["name"],
       first_name: data["firstName"], family_name: data["familyName"],
       jersey_num: data["jerseyNum"], position: data["position"],
       team_id: team_id, team_tricode: team_tricode, starter: data["starter"],
       minutes: data.dig("statistics", "minutes")}
    end
    private_class_method :identity_attributes

    # Extracts counting stats attributes from data
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      stats = data["statistics"] || {}
      {points: stats["points"], rebounds_total: stats["reboundsTotal"],
       rebounds_offensive: stats["reboundsOffensive"], rebounds_defensive: stats["reboundsDefensive"],
       assists: stats["assists"], steals: stats["steals"], blocks: stats["blocks"],
       turnovers: stats["turnovers"], fouls_personal: stats["foulsPersonal"],
       plus_minus: stats["plusMinusPoints"]}
    end
    private_class_method :counting_attributes

    # Extracts shooting stats attributes from data
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      stats = data["statistics"] || {}
      {field_goals_made: stats["fieldGoalsMade"], field_goals_attempted: stats["fieldGoalsAttempted"],
       field_goals_percentage: stats["fieldGoalsPercentage"],
       three_pointers_made: stats["threePointersMade"], three_pointers_attempted: stats["threePointersAttempted"],
       three_pointers_percentage: stats["threePointersPercentage"],
       free_throws_made: stats["freeThrowsMade"], free_throws_attempted: stats["freeThrowsAttempted"],
       free_throws_percentage: stats["freeThrowsPercentage"]}
    end
    private_class_method :shooting_attributes
  end
end
