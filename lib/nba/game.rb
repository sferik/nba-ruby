require "equalizer"
require "shale"
require_relative "team"

module NBA
  # Represents an NBA game
  class Game < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the unique identifier for the game
    #   @api public
    #   @example
    #     game.id #=> "0022400001"
    #   @return [String] the unique identifier for the game
    attribute :id, Shale::Type::String

    # @!attribute [rw] date
    #   Returns the date of the game
    #   @api public
    #   @example
    #     game.date #=> "2024-10-22"
    #   @return [String] the date of the game
    attribute :date, Shale::Type::String

    # @!attribute [rw] status
    #   Returns the game status
    #   @api public
    #   @example
    #     game.status #=> "Final"
    #   @return [String] the game status
    attribute :status, Shale::Type::String

    # @!attribute [rw] home_team
    #   Returns the home team
    #   @api public
    #   @example
    #     game.home_team #=> #<NBA::Team>
    #   @return [Team] the home team
    attribute :home_team, Team

    # @!attribute [rw] away_team
    #   Returns the away team
    #   @api public
    #   @example
    #     game.away_team #=> #<NBA::Team>
    #   @return [Team] the away team
    attribute :away_team, Team

    # @!attribute [rw] home_score
    #   Returns the home team score
    #   @api public
    #   @example
    #     game.home_score #=> 112
    #   @return [Integer] the home team score
    attribute :home_score, Shale::Type::Integer

    # @!attribute [rw] away_score
    #   Returns the away team score
    #   @api public
    #   @example
    #     game.away_score #=> 108
    #   @return [Integer] the away team score
    attribute :away_score, Shale::Type::Integer

    # @!attribute [rw] arena
    #   Returns the arena where the game is played
    #   @api public
    #   @example
    #     game.arena #=> "Chase Center"
    #   @return [String] the arena name
    attribute :arena, Shale::Type::String

    json do
      map "id", to: :id
      map "gameId", to: :id
      map "date", to: :date
      map "gameDate", to: :date
      map "status", to: :status
      map "gameStatus", to: :status
      map "home_team", to: :home_team
      map "homeTeam", to: :home_team
      map "away_team", to: :away_team
      map "awayTeam", to: :away_team
      map "home_score", to: :home_score
      map "homeScore", to: :home_score
      map "away_score", to: :away_score
      map "awayScore", to: :away_score
      map "arena", to: :arena
    end
  end
end
