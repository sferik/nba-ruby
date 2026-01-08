require "equalizer"
require "shale"

module NBA
  # Represents clutch-time player statistics
  #
  # @api public
  class LeagueDashPlayerClutchStat < Shale::Mapper
    include Equalizer.new(:player_id, :season_id)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.player_id #=> 201939
    #   @return [Integer, nil] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.player_name #=> "Stephen Curry"
    #   @return [String, nil] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "GSW"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     stat.season_id #=> "2024-25"
    #   @return [String, nil] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] age
    #   Returns the player age
    #   @api public
    #   @example
    #     stat.age #=> 36
    #   @return [Integer, nil] the player age
    attribute :age, Shale::Type::Integer

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer, nil] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer, nil] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 28
    #   @return [Integer, nil] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.622
    #   @return [Float, nil] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes played
    #   @api public
    #   @example
    #     stat.min #=> 5.2
    #   @return [Float, nil] minutes played
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 1.2
    #   @return [Float, nil] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 2.8
    #   @return [Float, nil] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.429
    #   @return [Float, nil] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three pointers made
    #   @api public
    #   @example
    #     stat.fg3m #=> 0.5
    #   @return [Float, nil] three pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three pointers attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 1.4
    #   @return [Float, nil] three pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.357
    #   @return [Float, nil] three point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.ftm #=> 0.8
    #   @return [Float, nil] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.fta #=> 0.9
    #   @return [Float, nil] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.889
    #   @return [Float, nil] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.oreb #=> 0.1
    #   @return [Float, nil] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.dreb #=> 0.5
    #   @return [Float, nil] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 0.6
    #   @return [Float, nil] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 1.0
    #   @return [Float, nil] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 0.4
    #   @return [Float, nil] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     stat.stl #=> 0.2
    #   @return [Float, nil] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 0.1
    #   @return [Float, nil] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 0.3
    #   @return [Float, nil] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 3.7
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 1.2
    #   @return [Float, nil] plus/minus
    attribute :plus_minus, Shale::Type::Float

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
end
