require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Represents a found game from the league game finder
  class FoundGame < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     game.season_id #=> "22024"
    #   @return [String] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     game.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     game.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     game.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     game.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     game.game_date #=> "2024-10-22"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the matchup string
    #   @api public
    #   @example
    #     game.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup
    attribute :matchup, Shale::Type::String

    # @!attribute [rw] wl
    #   Returns win/loss result
    #   @api public
    #   @example
    #     game.wl #=> "W"
    #   @return [String] W or L
    attribute :wl, Shale::Type::String

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     game.min #=> 240
    #   @return [Integer] minutes
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points scored
    #   @api public
    #   @example
    #     game.pts #=> 110
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     game.fgm #=> 42
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     game.fga #=> 85
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     game.fg_pct #=> 0.494
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     game.fg3m #=> 14
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     game.fg3a #=> 35
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     game.fg3_pct #=> 0.4
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     game.ftm #=> 12
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     game.fta #=> 15
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     game.ft_pct #=> 0.8
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     game.oreb #=> 10
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     game.dreb #=> 32
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     game.reb #=> 42
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     game.ast #=> 28
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     game.stl #=> 8
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     game.blk #=> 5
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     game.tov #=> 12
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     game.pf #=> 18
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     game.plus_minus #=> 10
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns the team object
    #
    # @api public
    # @example
    #   game.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   game.win? #=> true
    # @return [Boolean] true if win
    def win?
      wl.eql?("W")
    end

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   game.loss? #=> true
    # @return [Boolean] true if loss
    def loss?
      wl.eql?("L")
    end
  end

  # Provides methods to find games based on criteria
  module LeagueGameFinder
    # Result set name for team games
    # @return [String] the result set name
    TEAM_GAMES = "TeamGameFinderResults".freeze

    # Result set name for player games
    # @return [String] the result set name
    PLAYER_GAMES = "PlayerGameFinderResults".freeze

    # Season type constant for regular season
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Season type constant for playoffs
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Finds games for a team
    #
    # @api public
    # @example
    #   games = NBA::LeagueGameFinder.by_team(team: NBA::Team::GSW)
    #   games.each { |g| puts "#{g.game_date}: #{g.matchup} - #{g.wl}" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (nil for all seasons)
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of found games
    def self.by_team(team:, season: nil, season_type: REGULAR_SEASON, client: CLIENT)
      team_id = Utils.extract_id(team)
      path = build_team_path(team_id, season, season_type)
      response = client.get(path)
      parse_response(response, TEAM_GAMES)
    end

    # Finds games for a player
    #
    # @api public
    # @example
    #   games = NBA::LeagueGameFinder.by_player(player: 201939)
    #   games.each { |g| puts "#{g.game_date}: #{g.matchup} - #{g.pts} pts" }
    # @param player [Integer, Player] the player ID or Player object
    # @param season [Integer, nil] the season year (nil for all seasons)
    # @param season_type [String] the season type
    # @param client [Client] the API client to use
    # @return [Collection] a collection of found games
    def self.by_player(player:, season: nil, season_type: REGULAR_SEASON, client: CLIENT)
      player_id = Utils.extract_id(player)
      path = build_player_path(player_id, season, season_type)
      response = client.get(path)
      parse_response(response, PLAYER_GAMES)
    end

    # Builds the API path for team game finder
    #
    # @api private
    # @return [String] the request path
    def self.build_team_path(team_id, season, season_type)
      path = "leaguegamefinder?TeamID=#{team_id}&SeasonType=#{season_type}&LeagueID=00"
      path += "&Season=#{Utils.format_season(season)}" if season
      path
    end
    private_class_method :build_team_path

    # Builds the API path for player game finder
    #
    # @api private
    # @return [String] the request path
    def self.build_player_path(player_id, season, season_type)
      path = "leaguegamefinder?PlayerID=#{player_id}&SeasonType=#{season_type}&LeagueID=00"
      path += "&Season=#{Utils.format_season(season)}" if season
      path
    end
    private_class_method :build_player_path

    # Parses the API response into found game objects
    #
    # @api private
    # @return [Collection] collection of found games
    def self.parse_response(response, result_set_name)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = find_result_set(data, result_set_name)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      games = rows.map { |row| build_found_game(headers, row) }
      Collection.new(games)
    end
    private_class_method :parse_response

    # Finds the result set in the response
    #
    # @api private
    # @return [Hash, nil] the result set hash
    def self.find_result_set(data, name)
      result_sets = data.fetch("resultSets", nil)
      return unless result_sets

      result_sets.find { |rs| rs.fetch("name", nil).eql?(name) }
    end
    private_class_method :find_result_set

    # Builds a FoundGame object from raw data
    #
    # @api private
    # @return [FoundGame] the found game object
    def self.build_found_game(headers, row)
      data = headers.zip(row).to_h
      FoundGame.new(**found_game_attributes(data))
    end
    private_class_method :build_found_game

    # Combines all found game attributes
    #
    # @api private
    # @return [Hash] the combined attributes
    def self.found_game_attributes(data)
      identity_attributes(data).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :found_game_attributes

    # Extracts identity attributes from data
    #
    # @api private
    # @return [Hash] identity attributes
    def self.identity_attributes(data)
      {season_id: data.fetch("SEASON_ID", nil), team_id: data.fetch("TEAM_ID", nil),
       team_abbreviation: data.fetch("TEAM_ABBREVIATION", nil), team_name: data.fetch("TEAM_NAME", nil),
       game_id: data.fetch("GAME_ID", nil), game_date: data.fetch("GAME_DATE", nil),
       matchup: data.fetch("MATCHUP", nil), wl: data.fetch("WL", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :identity_attributes

    # Extracts shooting attributes from data
    #
    # @api private
    # @return [Hash] shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes from data
    #
    # @api private
    # @return [Hash] counting attributes
    def self.counting_attributes(data)
      {pts: data.fetch("PTS", nil), oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_attributes
  end
end
