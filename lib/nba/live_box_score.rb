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
      game_data = data.fetch("game", nil)
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
      team_data = game_data.fetch(team_key, nil)
      return [] unless team_data

      players = team_data.fetch("players", nil)
      return [] unless players

      team_id = team_data.fetch("teamId", nil)
      team_tricode = team_data.fetch("teamTricode", nil)

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
      {game_id: game_id, player_id: data.fetch("personId", nil), name: data.fetch("name", nil),
       first_name: data.fetch("firstName", nil), family_name: data.fetch("familyName", nil),
       jersey_num: data.fetch("jerseyNum", nil), position: data.fetch("position", nil),
       team_id: team_id, team_tricode: team_tricode, starter: data.fetch("starter", nil),
       minutes: data.dig("statistics", "minutes")}
    end
    private_class_method :identity_attributes

    # Extracts counting stats attributes from data
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      stats = data.fetch("statistics", nil) || {}
      {points: stats.fetch("points", nil), rebounds_total: stats.fetch("reboundsTotal", nil),
       rebounds_offensive: stats.fetch("reboundsOffensive", nil), rebounds_defensive: stats.fetch("reboundsDefensive", nil),
       assists: stats.fetch("assists", nil), steals: stats.fetch("steals", nil), blocks: stats.fetch("blocks", nil),
       turnovers: stats.fetch("turnovers", nil), fouls_personal: stats.fetch("foulsPersonal", nil),
       plus_minus: stats.fetch("plusMinusPoints", nil)}
    end
    private_class_method :counting_attributes

    # Extracts shooting stats attributes from data
    #
    # @api private
    # @param data [Hash] the player data
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      stats = data.fetch("statistics", nil) || {}
      {field_goals_made: stats.fetch("fieldGoalsMade", nil), field_goals_attempted: stats.fetch("fieldGoalsAttempted", nil),
       field_goals_percentage: stats.fetch("fieldGoalsPercentage", nil),
       three_pointers_made: stats.fetch("threePointersMade", nil), three_pointers_attempted: stats.fetch("threePointersAttempted", nil),
       three_pointers_percentage: stats.fetch("threePointersPercentage", nil),
       free_throws_made: stats.fetch("freeThrowsMade", nil), free_throws_attempted: stats.fetch("freeThrowsAttempted", nil),
       free_throws_percentage: stats.fetch("freeThrowsPercentage", nil)}
    end
    private_class_method :shooting_attributes
  end
end
