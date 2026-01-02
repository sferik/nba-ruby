require "equalizer"
require "shale"

module NBA
  # Represents hustle statistics for a team in a game
  class BoxScoreHustleTeamStat < Shale::Mapper
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

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] team_city
    #   Returns the team city
    #   @api public
    #   @example
    #     stat.team_city #=> "Golden State"
    #   @return [String] the team city
    attribute :team_city, Shale::Type::String

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> "240:00"
    #   @return [String] the minutes
    attribute :min, Shale::Type::String

    # @!attribute [rw] pts
    #   Returns points scored
    #   @api public
    #   @example
    #     stat.pts #=> 118
    #   @return [Integer] points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] contested_shots
    #   Returns contested shots
    #   @api public
    #   @example
    #     stat.contested_shots #=> 45
    #   @return [Integer] contested shots
    attribute :contested_shots, Shale::Type::Integer

    # @!attribute [rw] contested_shots_2pt
    #   Returns contested 2-point shots
    #   @api public
    #   @example
    #     stat.contested_shots_2pt #=> 30
    #   @return [Integer] contested 2-point shots
    attribute :contested_shots_2pt, Shale::Type::Integer

    # @!attribute [rw] contested_shots_3pt
    #   Returns contested 3-point shots
    #   @api public
    #   @example
    #     stat.contested_shots_3pt #=> 15
    #   @return [Integer] contested 3-point shots
    attribute :contested_shots_3pt, Shale::Type::Integer

    # @!attribute [rw] deflections
    #   Returns deflections
    #   @api public
    #   @example
    #     stat.deflections #=> 12
    #   @return [Integer] deflections
    attribute :deflections, Shale::Type::Integer

    # @!attribute [rw] charges_drawn
    #   Returns charges drawn
    #   @api public
    #   @example
    #     stat.charges_drawn #=> 2
    #   @return [Integer] charges drawn
    attribute :charges_drawn, Shale::Type::Integer

    # @!attribute [rw] screen_assists
    #   Returns screen assists
    #   @api public
    #   @example
    #     stat.screen_assists #=> 18
    #   @return [Integer] screen assists
    attribute :screen_assists, Shale::Type::Integer

    # @!attribute [rw] screen_ast_pts
    #   Returns points from screen assists
    #   @api public
    #   @example
    #     stat.screen_ast_pts #=> 36
    #   @return [Integer] screen assist points
    attribute :screen_ast_pts, Shale::Type::Integer

    # @!attribute [rw] loose_balls_recovered
    #   Returns loose balls recovered
    #   @api public
    #   @example
    #     stat.loose_balls_recovered #=> 8
    #   @return [Integer] loose balls recovered
    attribute :loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] off_loose_balls_recovered
    #   Returns offensive loose balls recovered
    #   @api public
    #   @example
    #     stat.off_loose_balls_recovered #=> 3
    #   @return [Integer] offensive loose balls recovered
    attribute :off_loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] def_loose_balls_recovered
    #   Returns defensive loose balls recovered
    #   @api public
    #   @example
    #     stat.def_loose_balls_recovered #=> 5
    #   @return [Integer] defensive loose balls recovered
    attribute :def_loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] box_outs
    #   Returns box outs
    #   @api public
    #   @example
    #     stat.box_outs #=> 25
    #   @return [Integer] box outs
    attribute :box_outs, Shale::Type::Integer

    # @!attribute [rw] off_box_outs
    #   Returns offensive box outs
    #   @api public
    #   @example
    #     stat.off_box_outs #=> 8
    #   @return [Integer] offensive box outs
    attribute :off_box_outs, Shale::Type::Integer

    # @!attribute [rw] def_box_outs
    #   Returns defensive box outs
    #   @api public
    #   @example
    #     stat.def_box_outs #=> 17
    #   @return [Integer] defensive box outs
    attribute :def_box_outs, Shale::Type::Integer

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
