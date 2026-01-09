module NBA
  # Represents a player's franchise statistics
  class FranchisePlayer < Shale::Mapper
    include Equalizer.new(:person_id)

    # @!attribute [rw] league_id
    #   Returns the league ID
    #   @api public
    #   @example
    #     player.league_id #=> "00"
    #   @return [String] the league ID
    attribute :league_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     player.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team
    #   Returns the team name
    #   @api public
    #   @example
    #     player.team #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team, Shale::Type::String

    # @!attribute [rw] person_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     player.person_id #=> 201939
    #   @return [Integer] the player ID
    attribute :person_id, Shale::Type::Integer

    # @!attribute [rw] player
    #   Returns the player name
    #   @api public
    #   @example
    #     player.player #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player, Shale::Type::String

    # @!attribute [rw] season_type
    #   Returns the season type
    #   @api public
    #   @example
    #     player.season_type #=> "Regular Season"
    #   @return [String] the season type
    attribute :season_type, Shale::Type::String

    # @!attribute [rw] active_with_team
    #   Returns whether the player is active with the team
    #   @api public
    #   @example
    #     player.active_with_team #=> "Y"
    #   @return [String] the active status
    attribute :active_with_team, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns the games played
    #   @api public
    #   @example
    #     player.gp #=> 745
    #   @return [Integer] the games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns the field goals made
    #   @api public
    #   @example
    #     player.fgm #=> 9.2
    #   @return [Float] the field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns the field goals attempted
    #   @api public
    #   @example
    #     player.fga #=> 19.3
    #   @return [Float] the field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns the field goal percentage
    #   @api public
    #   @example
    #     player.fg_pct #=> 0.476
    #   @return [Float] the field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns the three-point field goals made
    #   @api public
    #   @example
    #     player.fg3m #=> 4.5
    #   @return [Float] the three-point field goals made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns the three-point field goals attempted
    #   @api public
    #   @example
    #     player.fg3a #=> 11.2
    #   @return [Float] the three-point field goals attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns the three-point field goal percentage
    #   @api public
    #   @example
    #     player.fg3_pct #=> 0.426
    #   @return [Float] the three-point field goal percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns the free throws made
    #   @api public
    #   @example
    #     player.ftm #=> 4.8
    #   @return [Float] the free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns the free throws attempted
    #   @api public
    #   @example
    #     player.fta #=> 5.3
    #   @return [Float] the free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns the free throw percentage
    #   @api public
    #   @example
    #     player.ft_pct #=> 0.908
    #   @return [Float] the free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns the offensive rebounds
    #   @api public
    #   @example
    #     player.oreb #=> 0.5
    #   @return [Float] the offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns the defensive rebounds
    #   @api public
    #   @example
    #     player.dreb #=> 4.5
    #   @return [Float] the defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns the total rebounds
    #   @api public
    #   @example
    #     player.reb #=> 5.0
    #   @return [Float] the total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns the assists
    #   @api public
    #   @example
    #     player.ast #=> 6.5
    #   @return [Float] the assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns the personal fouls
    #   @api public
    #   @example
    #     player.pf #=> 2.1
    #   @return [Float] the personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns the steals
    #   @api public
    #   @example
    #     player.stl #=> 1.6
    #   @return [Float] the steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns the turnovers
    #   @api public
    #   @example
    #     player.tov #=> 3.1
    #   @return [Float] the turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns the blocks
    #   @api public
    #   @example
    #     player.blk #=> 0.2
    #   @return [Float] the blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns the points
    #   @api public
    #   @example
    #     player.pts #=> 24.8
    #   @return [Float] the points
    attribute :pts, Shale::Type::Float

    # Returns the player information
    #
    # @api public
    # @example
    #   franchise_player.player_info #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player_info
      Players.find(person_id)
    end
  end
end
