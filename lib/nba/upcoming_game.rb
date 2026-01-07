require "equalizer"
require "shale"

module NBA
  # Represents an upcoming game
  #
  # @api public
  class UpcomingGame < Shale::Mapper
    include Equalizer.new(:game_id)

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
    #     game.game_date #=> "2024-10-22T00:00:00"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] game_time
    #   Returns the game time
    #   @api public
    #   @example
    #     game.game_time #=> "7:30 PM"
    #   @return [String] the game time
    attribute :game_time, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     game.home_team_id #=> 1610612744
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] visitor_team_id
    #   Returns the visitor team ID
    #   @api public
    #   @example
    #     game.visitor_team_id #=> 1610612747
    #   @return [Integer] the visitor team ID
    attribute :visitor_team_id, Shale::Type::Integer

    # @!attribute [rw] home_team_name
    #   Returns the home team full name
    #   @api public
    #   @example
    #     game.home_team_name #=> "Golden State Warriors"
    #   @return [String] the home team name
    attribute :home_team_name, Shale::Type::String

    # @!attribute [rw] visitor_team_name
    #   Returns the visitor team full name
    #   @api public
    #   @example
    #     game.visitor_team_name #=> "Los Angeles Lakers"
    #   @return [String] the visitor team name
    attribute :visitor_team_name, Shale::Type::String

    # @!attribute [rw] home_team_abbreviation
    #   Returns the home team abbreviation
    #   @api public
    #   @example
    #     game.home_team_abbreviation #=> "GSW"
    #   @return [String] the home team abbreviation
    attribute :home_team_abbreviation, Shale::Type::String

    # @!attribute [rw] visitor_team_abbreviation
    #   Returns the visitor team abbreviation
    #   @api public
    #   @example
    #     game.visitor_team_abbreviation #=> "LAL"
    #   @return [String] the visitor team abbreviation
    attribute :visitor_team_abbreviation, Shale::Type::String

    # @!attribute [rw] home_team_nickname
    #   Returns the home team nickname
    #   @api public
    #   @example
    #     game.home_team_nickname #=> "Warriors"
    #   @return [String] the home team nickname
    attribute :home_team_nickname, Shale::Type::String

    # @!attribute [rw] visitor_team_nickname
    #   Returns the visitor team nickname
    #   @api public
    #   @example
    #     game.visitor_team_nickname #=> "Lakers"
    #   @return [String] the visitor team nickname
    attribute :visitor_team_nickname, Shale::Type::String

    # Returns the home team object
    #
    # @api public
    # @example
    #   game.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team
    def home_team = Teams.find(home_team_id)

    # Returns the visitor team object
    #
    # @api public
    # @example
    #   game.visitor_team #=> #<NBA::Team>
    # @return [Team, nil] the visitor team
    def visitor_team = Teams.find(visitor_team_id)
  end
end
