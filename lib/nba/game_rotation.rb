require "json"
require_relative "client"
require_relative "collection"

module NBA
  # Represents a player's rotation entry in a game
  class RotationEntry < Shale::Mapper
    include Equalizer.new(:game_id, :player_id, :in_time_real)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     entry.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     entry.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     entry.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     entry.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     entry.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_first
    #   Returns the player's first name
    #   @api public
    #   @example
    #     entry.player_first #=> "Stephen"
    #   @return [String] the first name
    attribute :player_first, Shale::Type::String

    # @!attribute [rw] player_last
    #   Returns the player's last name
    #   @api public
    #   @example
    #     entry.player_last #=> "Curry"
    #   @return [String] the last name
    attribute :player_last, Shale::Type::String

    # @!attribute [rw] in_time_real
    #   Returns the time the player checked in (in tenths of seconds from game start)
    #   @api public
    #   @example
    #     entry.in_time_real #=> 0
    #   @return [Integer] the in time
    attribute :in_time_real, Shale::Type::Integer

    # @!attribute [rw] out_time_real
    #   Returns the time the player checked out (in tenths of seconds from game start)
    #   @api public
    #   @example
    #     entry.out_time_real #=> 4320
    #   @return [Integer] the out time
    attribute :out_time_real, Shale::Type::Integer

    # @!attribute [rw] player_pts
    #   Returns the points scored during this stint
    #   @api public
    #   @example
    #     entry.player_pts #=> 12
    #   @return [Integer] the points
    attribute :player_pts, Shale::Type::Integer

    # @!attribute [rw] pt_diff
    #   Returns the point differential during this stint
    #   @api public
    #   @example
    #     entry.pt_diff #=> 8
    #   @return [Integer] the point differential
    attribute :pt_diff, Shale::Type::Integer

    # @!attribute [rw] usg_pct
    #   Returns the usage percentage during this stint
    #   @api public
    #   @example
    #     entry.usg_pct #=> 32.5
    #   @return [Float] the usage percentage
    attribute :usg_pct, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   entry.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(player_id)
    end

    # Returns the team object
    #
    # @api public
    # @example
    #   entry.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   entry.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end

    # Returns the player's full name
    #
    # @api public
    # @example
    #   entry.player_name #=> "Stephen Curry"
    # @return [String] the full name
    def player_name
      "#{player_first} #{player_last}".strip
    end

    # Returns the stint duration in tenths of seconds
    #
    # @api public
    # @example
    #   entry.duration #=> 4320
    # @return [Integer, nil] the duration
    def duration
      return unless in_time_real && out_time_real

      out_time_real - in_time_real
    end
  end

  # Provides methods to retrieve game rotation data
  module GameRotation
    # Result set name for home team rotation
    # @return [String] the result set name
    HOME_TEAM = "HomeTeam".freeze

    # Result set name for away team rotation
    # @return [String] the result set name
    AWAY_TEAM = "AwayTeam".freeze

    # Retrieves rotation data for the home team in a game
    #
    # @api public
    # @example
    #   rotations = NBA::GameRotation.home_team(game: "0022400001")
    #   rotations.each { |r| puts "#{r.player_name}: #{r.player_pts} pts" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rotation entries
    def self.home_team(game:, client: CLIENT)
      game_id = extract_game_id(game)
      path = build_path(game_id)
      response = client.get(path)
      parse_response(response, HOME_TEAM, game_id)
    end

    # Retrieves rotation data for the away team in a game
    #
    # @api public
    # @example
    #   rotations = NBA::GameRotation.away_team(game: "0022400001")
    #   rotations.each { |r| puts "#{r.player_name}: #{r.pt_diff} +/-" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of rotation entries
    def self.away_team(game:, client: CLIENT)
      game_id = extract_game_id(game)
      path = build_path(game_id)
      response = client.get(path)
      parse_response(response, AWAY_TEAM, game_id)
    end

    # Retrieves all rotation data for a game
    #
    # @api public
    # @example
    #   rotations = NBA::GameRotation.all(game: "0022400001")
    #   rotations.each { |r| puts "#{r.team_name}: #{r.player_name}" }
    # @param game [String, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of all rotation entries
    def self.all(game:, client: CLIENT)
      home = home_team(game: game, client: client).to_a
      away = away_team(game: game, client: client).to_a
      Collection.new(home + away)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id)
      "gamerotation?GameID=#{game_id}&LeagueID=00"
    end
    private_class_method :build_path

    # Parses the API response into rotation entry objects
    # @api private
    # @return [Collection] collection of rotation entries
    def self.parse_response(response, result_set_name, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      entries = rows.map { |row| build_rotation_entry(headers, row, game_id) }
      Collection.new(entries)
    end
    private_class_method :parse_response

    # Finds the specified result set in the response
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a RotationEntry object from raw data
    # @api private
    # @return [RotationEntry] the rotation entry object
    def self.build_rotation_entry(headers, row, game_id)
      data = headers.zip(row).to_h
      RotationEntry.new(**rotation_attributes(data, game_id))
    end
    private_class_method :build_rotation_entry

    # Combines all rotation attributes
    # @api private
    # @return [Hash] the combined attributes
    def self.rotation_attributes(data, game_id)
      identity_attributes(data, game_id).merge(stint_attributes(data))
    end
    private_class_method :rotation_attributes

    # Extracts identity attributes from data
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data, game_id)
      {game_id: game_id, team_id: data.fetch("TEAM_ID"), team_city: data.fetch("TEAM_CITY"),
       team_name: data.fetch("TEAM_NAME"), player_id: data.fetch("PERSON_ID"),
       player_first: data.fetch("PLAYER_FIRST"), player_last: data.fetch("PLAYER_LAST")}
    end
    private_class_method :identity_attributes

    # Extracts stint attributes from data
    # @api private
    # @return [Hash] stint attributes
    def self.stint_attributes(data)
      {in_time_real: data.fetch("IN_TIME_REAL"), out_time_real: data.fetch("OUT_TIME_REAL"),
       player_pts: data.fetch("PLAYER_PTS"), pt_diff: data.fetch("PT_DIFF"), usg_pct: data.fetch("USG_PCT")}
    end
    private_class_method :stint_attributes

    # Extracts game ID from a Game object or returns the string
    #
    # @api private
    # @param game [Game, String] the game or game ID
    # @return [String] the game ID
    def self.extract_game_id(game)
      case game
      when Game then game.id
      else game
      end
    end
    private_class_method :extract_game_id
  end
end
