require "json"
require_relative "collection"
require_relative "live_connection"
require_relative "utils"

module NBA
  # Represents a player's live box score stats
  class LivePlayerStat < Shale::Mapper
    include Equalizer.new(:player_id, :game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :name, Shale::Type::String

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     stat.first_name #=> "Stephen"
    #   @return [String] the first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] family_name
    #   Returns the player's family name
    #   @api public
    #   @example
    #     stat.family_name #=> "Curry"
    #   @return [String] the family name
    attribute :family_name, Shale::Type::String

    # @!attribute [rw] jersey_num
    #   Returns the jersey number
    #   @api public
    #   @example
    #     stat.jersey_num #=> "30"
    #   @return [String] the jersey number
    attribute :jersey_num, Shale::Type::String

    # @!attribute [rw] position
    #   Returns the position
    #   @api public
    #   @example
    #     stat.position #=> "G"
    #   @return [String] the position
    attribute :position, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_tricode
    #   Returns the team tricode
    #   @api public
    #   @example
    #     stat.team_tricode #=> "GSW"
    #   @return [String] the team tricode
    attribute :team_tricode, Shale::Type::String

    # @!attribute [rw] starter
    #   Returns whether the player started
    #   @api public
    #   @example
    #     stat.starter #=> "1"
    #   @return [String] "1" if starter, "0" otherwise
    attribute :starter, Shale::Type::String

    # @!attribute [rw] minutes
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.minutes #=> "PT34M12S"
    #   @return [String] minutes in ISO 8601 duration format
    attribute :minutes, Shale::Type::String

    # @!attribute [rw] points
    #   Returns points scored
    #   @api public
    #   @example
    #     stat.points #=> 28
    #   @return [Integer] points
    attribute :points, Shale::Type::Integer

    # @!attribute [rw] rebounds_total
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.rebounds_total #=> 7
    #   @return [Integer] total rebounds
    attribute :rebounds_total, Shale::Type::Integer

    # @!attribute [rw] rebounds_offensive
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.rebounds_offensive #=> 1
    #   @return [Integer] offensive rebounds
    attribute :rebounds_offensive, Shale::Type::Integer

    # @!attribute [rw] rebounds_defensive
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.rebounds_defensive #=> 6
    #   @return [Integer] defensive rebounds
    attribute :rebounds_defensive, Shale::Type::Integer

    # @!attribute [rw] assists
    #   Returns assists
    #   @api public
    #   @example
    #     stat.assists #=> 8
    #   @return [Integer] assists
    attribute :assists, Shale::Type::Integer

    # @!attribute [rw] steals
    #   Returns steals
    #   @api public
    #   @example
    #     stat.steals #=> 2
    #   @return [Integer] steals
    attribute :steals, Shale::Type::Integer

    # @!attribute [rw] blocks
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blocks #=> 1
    #   @return [Integer] blocks
    attribute :blocks, Shale::Type::Integer

    # @!attribute [rw] turnovers
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.turnovers #=> 3
    #   @return [Integer] turnovers
    attribute :turnovers, Shale::Type::Integer

    # @!attribute [rw] fouls_personal
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.fouls_personal #=> 2
    #   @return [Integer] personal fouls
    attribute :fouls_personal, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 12.0
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # @!attribute [rw] field_goals_made
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.field_goals_made #=> 10
    #   @return [Integer] field goals made
    attribute :field_goals_made, Shale::Type::Integer

    # @!attribute [rw] field_goals_attempted
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.field_goals_attempted #=> 20
    #   @return [Integer] field goals attempted
    attribute :field_goals_attempted, Shale::Type::Integer

    # @!attribute [rw] field_goals_percentage
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.field_goals_percentage #=> 0.5
    #   @return [Float] field goal percentage
    attribute :field_goals_percentage, Shale::Type::Float

    # @!attribute [rw] three_pointers_made
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     stat.three_pointers_made #=> 5
    #   @return [Integer] three-pointers made
    attribute :three_pointers_made, Shale::Type::Integer

    # @!attribute [rw] three_pointers_attempted
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     stat.three_pointers_attempted #=> 12
    #   @return [Integer] three-pointers attempted
    attribute :three_pointers_attempted, Shale::Type::Integer

    # @!attribute [rw] three_pointers_percentage
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.three_pointers_percentage #=> 0.417
    #   @return [Float] three-point percentage
    attribute :three_pointers_percentage, Shale::Type::Float

    # @!attribute [rw] free_throws_made
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.free_throws_made #=> 3
    #   @return [Integer] free throws made
    attribute :free_throws_made, Shale::Type::Integer

    # @!attribute [rw] free_throws_attempted
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.free_throws_attempted #=> 3
    #   @return [Integer] free throws attempted
    attribute :free_throws_attempted, Shale::Type::Integer

    # @!attribute [rw] free_throws_percentage
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.free_throws_percentage #=> 1.0
    #   @return [Float] free throw percentage
    attribute :free_throws_percentage, Shale::Type::Float

    # Returns whether the player was a starter
    #
    # @api public
    # @example
    #   stat.starter? #=> true
    # @return [Boolean] true if starter
    def starter?
      starter.eql?("1")
    end

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end

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
