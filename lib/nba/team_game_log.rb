require "json"
require_relative "client"
require_relative "collection"
require_relative "utils"

module NBA
  # Provides methods to retrieve team game logs
  module TeamGameLog
    # Regular season type
    # @return [String] the season type
    REGULAR_SEASON = "Regular Season".freeze

    # Playoffs season type
    # @return [String] the season type
    PLAYOFFS = "Playoffs".freeze

    # Retrieves game logs for a team
    #
    # @api public
    # @example
    #   logs = NBA::TeamGameLog.find(team: Team::GSW)
    #   logs.each { |log| puts "#{log.game_date}: #{log.pts} points" }
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer] the season year (defaults to current season)
    # @param season_type [String] the season type (Regular Season, Playoffs)
    # @param client [Client] the API client to use
    # @return [Collection] a collection of team game logs
    def self.find(team:, season: Utils.current_season, season_type: REGULAR_SEASON, client: CLIENT)
      team_id = extract_team_id(team)
      season_str = "#{season}-#{(season + 1).to_s[-2..]}"
      path = build_path(team_id, season_str, season_type)
      response = client.get(path)
      parse_response(response)
    end

    # Builds the API path for team game log
    #
    # @api private
    # @param team_id [Integer] the team ID
    # @param season_str [String] the season string
    # @param season_type [String] the season type
    # @return [String] the API path
    def self.build_path(team_id, season_str, season_type)
      encoded_type = season_type
      "teamgamelog?TeamID=#{team_id}&Season=#{season_str}&SeasonType=#{encoded_type}"
    end
    private_class_method :build_path

    # Parses the API response
    #
    # @api private
    # @param response [String] the JSON response body
    # @return [Collection] a collection of team game logs
    def self.parse_response(response)
      return Collection.new unless response

      data = JSON.parse(response)
      result_set = data.dig("resultSets", 0)
      return Collection.new unless result_set

      headers = result_set.fetch("headers", nil)
      rows = result_set.fetch("rowSet", nil)
      return Collection.new unless headers && rows

      logs = rows.map { |row| build_team_game_log(headers, row) }
      Collection.new(logs)
    end
    private_class_method :parse_response

    # Builds a team game log from a row
    #
    # @api private
    # @param headers [Array<String>] the column headers
    # @param row [Array] the row data
    # @return [TeamGameLogEntry] the team game log object
    def self.build_team_game_log(headers, row)
      data = headers.zip(row).to_h
      TeamGameLogEntry.new(**team_game_log_attributes(data))
    end
    private_class_method :build_team_game_log

    # Combines all team game log attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the combined attributes
    def self.team_game_log_attributes(data)
      game_info_attributes(data).merge(shooting_attributes(data), counting_attributes(data))
    end
    private_class_method :team_game_log_attributes

    # Extracts game info attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the game info attributes
    def self.game_info_attributes(data)
      {team_id: data.fetch("Team_ID", nil), game_id: data.fetch("Game_ID", nil), game_date: data.fetch("GAME_DATE", nil),
       matchup: data.fetch("MATCHUP", nil), wl: data.fetch("WL", nil), min: data.fetch("MIN", nil)}
    end
    private_class_method :game_info_attributes

    # Extracts shooting attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the shooting attributes
    def self.shooting_attributes(data)
      {fgm: data.fetch("FGM", nil), fga: data.fetch("FGA", nil), fg_pct: data.fetch("FG_PCT", nil),
       fg3m: data.fetch("FG3M", nil), fg3a: data.fetch("FG3A", nil), fg3_pct: data.fetch("FG3_PCT", nil),
       ftm: data.fetch("FTM", nil), fta: data.fetch("FTA", nil), ft_pct: data.fetch("FT_PCT", nil)}
    end
    private_class_method :shooting_attributes

    # Extracts counting stats attributes
    #
    # @api private
    # @param data [Hash] the game log data
    # @return [Hash] the counting stats attributes
    def self.counting_attributes(data)
      {oreb: data.fetch("OREB", nil), dreb: data.fetch("DREB", nil), reb: data.fetch("REB", nil),
       ast: data.fetch("AST", nil), stl: data.fetch("STL", nil), blk: data.fetch("BLK", nil),
       tov: data.fetch("TOV", nil), pf: data.fetch("PF", nil), pts: data.fetch("PTS", nil),
       plus_minus: data.fetch("PLUS_MINUS", nil)}
    end
    private_class_method :counting_attributes

    # Extracts team ID from a Team object or returns the integer
    #
    # @api private
    # @param team [Team, Integer] the team or team ID
    # @return [Integer] the team ID
    def self.extract_team_id(team)
      case team
      when Team then team.id
      else team
      end
    end
    private_class_method :extract_team_id
  end

  # Represents a single team game log entry
  class TeamGameLogEntry < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     log.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     log.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     log.game_date #=> "OCT 22, 2024"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the matchup description
    #   @api public
    #   @example
    #     log.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup
    attribute :matchup, Shale::Type::String

    # @!attribute [rw] wl
    #   Returns the win/loss result
    #   @api public
    #   @example
    #     log.wl #=> "W"
    #   @return [String] the win/loss indicator
    attribute :wl, Shale::Type::String

    # @!attribute [rw] min
    #   Returns the minutes played
    #   @api public
    #   @example
    #     log.min #=> 240
    #   @return [Integer] the minutes played
    attribute :min, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     log.fgm #=> 42
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     log.fga #=> 88
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     log.fg_pct #=> 0.477
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made
    #   @api public
    #   @example
    #     log.fg3m #=> 15
    #   @return [Integer] three-pointers made
    attribute :fg3m, Shale::Type::Integer

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted
    #   @api public
    #   @example
    #     log.fg3a #=> 40
    #   @return [Integer] three-pointers attempted
    attribute :fg3a, Shale::Type::Integer

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     log.fg3_pct #=> 0.375
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     log.ftm #=> 20
    #   @return [Integer] free throws made
    attribute :ftm, Shale::Type::Integer

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     log.fta #=> 25
    #   @return [Integer] free throws attempted
    attribute :fta, Shale::Type::Integer

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     log.ft_pct #=> 0.800
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     log.oreb #=> 10
    #   @return [Integer] offensive rebounds
    attribute :oreb, Shale::Type::Integer

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     log.dreb #=> 35
    #   @return [Integer] defensive rebounds
    attribute :dreb, Shale::Type::Integer

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     log.reb #=> 45
    #   @return [Integer] total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     log.ast #=> 28
    #   @return [Integer] assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     log.stl #=> 8
    #   @return [Integer] steals
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     log.blk #=> 5
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     log.tov #=> 12
    #   @return [Integer] turnovers
    attribute :tov, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     log.pf #=> 18
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     log.pts #=> 119
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     log.plus_minus #=> 12
    #   @return [Integer] plus/minus
    attribute :plus_minus, Shale::Type::Integer

    # Returns whether the game was a win
    #
    # @api public
    # @example
    #   log.win? #=> true
    # @return [Boolean] whether the game was a win
    def win?
      wl.eql?("W")
    end

    # Returns whether the game was a loss
    #
    # @api public
    # @example
    #   log.loss? #=> false
    # @return [Boolean] whether the game was a loss
    def loss?
      wl.eql?("L")
    end

    # Returns the team object for this game log
    #
    # @api public
    # @example
    #   log.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object for this log entry
    #
    # @api public
    # @example
    #   log.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end
end
