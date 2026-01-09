require "equalizer"
require "shale"

module NBA
  # Represents defensive statistics for a team in a game
  class BoxScoreDefensiveTeamStat < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     stat.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_tricode
    #   Returns the team tricode
    #   @api public
    #   @example
    #     stat.team_tricode #=> "GSW"
    #   @return [String] the team tricode
    attribute :team_tricode, Shale::Type::String

    # @!attribute [rw] team_slug
    #   Returns the team slug
    #   @api public
    #   @example
    #     stat.team_slug #=> "warriors"
    #   @return [String] the team slug
    attribute :team_slug, Shale::Type::String

    # @!attribute [rw] minutes
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.minutes #=> "240:00"
    #   @return [String] the minutes
    attribute :minutes, Shale::Type::String

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object
    #
    # @api public
    # @example
    #   stat.game #=> #<NBA::Game>
    # @return [Game, nil] the game object
    def game
      Games.find(game_id)
    end
  end
end
