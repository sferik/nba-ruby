require "equalizer"
require "shale"

module NBA
  # Represents a player's usage box score statistics for a game
  class BoxScoreUsagePlayerStat < Shale::Mapper
    include Equalizer.new(:game_id, :player_id)

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

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] start_position
    #   Returns the starting position
    #   @api public
    #   @example
    #     stat.start_position #=> "G"
    #   @return [String] the starting position
    attribute :start_position, Shale::Type::String

    # @!attribute [rw] comment
    #   Returns any comment (e.g., "DNP - Rest")
    #   @api public
    #   @example
    #     stat.comment #=> "DNP - Rest"
    #   @return [String] the comment
    attribute :comment, Shale::Type::String

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> "35:24"
    #   @return [String] the minutes played
    attribute :min, Shale::Type::String

    # @!attribute [rw] usg_pct
    #   Returns usage percentage
    #   @api public
    #   @example
    #     stat.usg_pct #=> 0.285
    #   @return [Float] usage percentage
    attribute :usg_pct, Shale::Type::Float

    # @!attribute [rw] pct_fgm
    #   Returns percentage of team field goals made
    #   @api public
    #   @example
    #     stat.pct_fgm #=> 0.24
    #   @return [Float] the percentage
    attribute :pct_fgm, Shale::Type::Float

    # @!attribute [rw] pct_fga
    #   Returns percentage of team field goals attempted
    #   @api public
    #   @example
    #     stat.pct_fga #=> 0.27
    #   @return [Float] the percentage
    attribute :pct_fga, Shale::Type::Float

    # @!attribute [rw] pct_fg3m
    #   Returns percentage of team 3-pointers made
    #   @api public
    #   @example
    #     stat.pct_fg3m #=> 0.35
    #   @return [Float] the percentage
    attribute :pct_fg3m, Shale::Type::Float

    # @!attribute [rw] pct_fg3a
    #   Returns percentage of team 3-pointers attempted
    #   @api public
    #   @example
    #     stat.pct_fg3a #=> 0.38
    #   @return [Float] the percentage
    attribute :pct_fg3a, Shale::Type::Float

    # @!attribute [rw] pct_ftm
    #   Returns percentage of team free throws made
    #   @api public
    #   @example
    #     stat.pct_ftm #=> 0.28
    #   @return [Float] the percentage
    attribute :pct_ftm, Shale::Type::Float

    # @!attribute [rw] pct_fta
    #   Returns percentage of team free throws attempted
    #   @api public
    #   @example
    #     stat.pct_fta #=> 0.30
    #   @return [Float] the percentage
    attribute :pct_fta, Shale::Type::Float

    # @!attribute [rw] pct_oreb
    #   Returns percentage of team offensive rebounds
    #   @api public
    #   @example
    #     stat.pct_oreb #=> 0.15
    #   @return [Float] the percentage
    attribute :pct_oreb, Shale::Type::Float

    # @!attribute [rw] pct_dreb
    #   Returns percentage of team defensive rebounds
    #   @api public
    #   @example
    #     stat.pct_dreb #=> 0.22
    #   @return [Float] the percentage
    attribute :pct_dreb, Shale::Type::Float

    # @!attribute [rw] pct_reb
    #   Returns percentage of team total rebounds
    #   @api public
    #   @example
    #     stat.pct_reb #=> 0.19
    #   @return [Float] the percentage
    attribute :pct_reb, Shale::Type::Float

    # @!attribute [rw] pct_ast
    #   Returns percentage of team assists
    #   @api public
    #   @example
    #     stat.pct_ast #=> 0.32
    #   @return [Float] the percentage
    attribute :pct_ast, Shale::Type::Float

    # @!attribute [rw] pct_tov
    #   Returns percentage of team turnovers
    #   @api public
    #   @example
    #     stat.pct_tov #=> 0.18
    #   @return [Float] the percentage
    attribute :pct_tov, Shale::Type::Float

    # @!attribute [rw] pct_stl
    #   Returns percentage of team steals
    #   @api public
    #   @example
    #     stat.pct_stl #=> 0.25
    #   @return [Float] the percentage
    attribute :pct_stl, Shale::Type::Float

    # @!attribute [rw] pct_blk
    #   Returns percentage of team blocks
    #   @api public
    #   @example
    #     stat.pct_blk #=> 0.20
    #   @return [Float] the percentage
    attribute :pct_blk, Shale::Type::Float

    # @!attribute [rw] pct_blka
    #   Returns percentage of team blocked attempts
    #   @api public
    #   @example
    #     stat.pct_blka #=> 0.12
    #   @return [Float] the percentage
    attribute :pct_blka, Shale::Type::Float

    # @!attribute [rw] pct_pf
    #   Returns percentage of team personal fouls
    #   @api public
    #   @example
    #     stat.pct_pf #=> 0.16
    #   @return [Float] the percentage
    attribute :pct_pf, Shale::Type::Float

    # @!attribute [rw] pct_pfd
    #   Returns percentage of team personal fouls drawn
    #   @api public
    #   @example
    #     stat.pct_pfd #=> 0.21
    #   @return [Float] the percentage
    attribute :pct_pfd, Shale::Type::Float

    # @!attribute [rw] pct_pts
    #   Returns percentage of team points
    #   @api public
    #   @example
    #     stat.pct_pts #=> 0.26
    #   @return [Float] the percentage
    attribute :pct_pts, Shale::Type::Float

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

    # Returns whether the player started the game
    #
    # @api public
    # @example
    #   stat.starter? #=> true
    # @return [Boolean] true if the player started
    def starter?
      !start_position.nil? && !start_position.empty?
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
