require "equalizer"
require "shale"

module NBA
  # Represents a team's usage box score statistics for a game
  class BoxScoreUsageTeamStat < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400565"
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
    #   Returns total minutes played
    #   @api public
    #   @example
    #     stat.min #=> "240:00"
    #   @return [String] the minutes
    attribute :min, Shale::Type::String

    # @!attribute [rw] usg_pct
    #   Returns usage percentage
    #   @api public
    #   @example
    #     stat.usg_pct #=> 1.0
    #   @return [Float] usage percentage
    attribute :usg_pct, Shale::Type::Float

    # @!attribute [rw] pct_fgm
    #   Returns percentage of field goals made
    #   @api public
    #   @example
    #     stat.pct_fgm #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_fgm, Shale::Type::Float

    # @!attribute [rw] pct_fga
    #   Returns percentage of field goals attempted
    #   @api public
    #   @example
    #     stat.pct_fga #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_fga, Shale::Type::Float

    # @!attribute [rw] pct_fg3m
    #   Returns percentage of 3-pointers made
    #   @api public
    #   @example
    #     stat.pct_fg3m #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_fg3m, Shale::Type::Float

    # @!attribute [rw] pct_fg3a
    #   Returns percentage of 3-pointers attempted
    #   @api public
    #   @example
    #     stat.pct_fg3a #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_fg3a, Shale::Type::Float

    # @!attribute [rw] pct_ftm
    #   Returns percentage of free throws made
    #   @api public
    #   @example
    #     stat.pct_ftm #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_ftm, Shale::Type::Float

    # @!attribute [rw] pct_fta
    #   Returns percentage of free throws attempted
    #   @api public
    #   @example
    #     stat.pct_fta #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_fta, Shale::Type::Float

    # @!attribute [rw] pct_oreb
    #   Returns percentage of offensive rebounds
    #   @api public
    #   @example
    #     stat.pct_oreb #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_oreb, Shale::Type::Float

    # @!attribute [rw] pct_dreb
    #   Returns percentage of defensive rebounds
    #   @api public
    #   @example
    #     stat.pct_dreb #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_dreb, Shale::Type::Float

    # @!attribute [rw] pct_reb
    #   Returns percentage of total rebounds
    #   @api public
    #   @example
    #     stat.pct_reb #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_reb, Shale::Type::Float

    # @!attribute [rw] pct_ast
    #   Returns percentage of assists
    #   @api public
    #   @example
    #     stat.pct_ast #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_ast, Shale::Type::Float

    # @!attribute [rw] pct_tov
    #   Returns percentage of turnovers
    #   @api public
    #   @example
    #     stat.pct_tov #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_tov, Shale::Type::Float

    # @!attribute [rw] pct_stl
    #   Returns percentage of steals
    #   @api public
    #   @example
    #     stat.pct_stl #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_stl, Shale::Type::Float

    # @!attribute [rw] pct_blk
    #   Returns percentage of blocks
    #   @api public
    #   @example
    #     stat.pct_blk #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_blk, Shale::Type::Float

    # @!attribute [rw] pct_blka
    #   Returns percentage of blocked attempts
    #   @api public
    #   @example
    #     stat.pct_blka #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_blka, Shale::Type::Float

    # @!attribute [rw] pct_pf
    #   Returns percentage of personal fouls
    #   @api public
    #   @example
    #     stat.pct_pf #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_pf, Shale::Type::Float

    # @!attribute [rw] pct_pfd
    #   Returns percentage of personal fouls drawn
    #   @api public
    #   @example
    #     stat.pct_pfd #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_pfd, Shale::Type::Float

    # @!attribute [rw] pct_pts
    #   Returns percentage of points
    #   @api public
    #   @example
    #     stat.pct_pts #=> 1.0
    #   @return [Float] the percentage
    attribute :pct_pts, Shale::Type::Float

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the game object for this box score
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
