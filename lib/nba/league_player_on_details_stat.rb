require "equalizer"
require "shale"

module NBA
  # Represents league-wide player on/off court statistics
  class LeaguePlayerOnDetailsStat < Shale::Mapper
    include Equalizer.new(:team_id, :vs_player_id)

    # @!attribute [rw] group_set
    #   Returns the group set
    #   @api public
    #   @example
    #     stat.group_set #=> "Overall"
    #   @return [String] the group set
    attribute :group_set, Shale::Type::String

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

    # @!attribute [rw] team_name
    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] vs_player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     stat.vs_player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :vs_player_id, Shale::Type::Integer

    # @!attribute [rw] vs_player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     stat.vs_player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :vs_player_name, Shale::Type::String

    # @!attribute [rw] court_status
    #   Returns the court status (On or Off)
    #   @api public
    #   @example
    #     stat.court_status #=> "On"
    #   @return [String] the court status
    attribute :court_status, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 74
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] w
    #   Returns wins
    #   @api public
    #   @example
    #     stat.w #=> 46
    #   @return [Integer] wins
    attribute :w, Shale::Type::Integer

    # @!attribute [rw] l
    #   Returns losses
    #   @api public
    #   @example
    #     stat.l #=> 28
    #   @return [Integer] losses
    attribute :l, Shale::Type::Integer

    # @!attribute [rw] w_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.w_pct #=> 0.622
    #   @return [Float] win percentage
    attribute :w_pct, Shale::Type::Float

    # @!attribute [rw] min
    #   Returns minutes
    #   @api public
    #   @example
    #     stat.min #=> 32.5
    #   @return [Float] minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 9.8
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 20.2
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.485
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three pointers made
    #   @api public
    #   @example
    #     stat.fg3m #=> 4.8
    #   @return [Float] three pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three pointers attempted
    #   @api public
    #   @example
    #     stat.fg3a #=> 11.7
    #   @return [Float] three pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.411
    #   @return [Float] three point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made
    #   @api public
    #   @example
    #     stat.ftm #=> 4.2
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted
    #   @api public
    #   @example
    #     stat.fta #=> 4.6
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.913
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds
    #   @api public
    #   @example
    #     stat.oreb #=> 0.7
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds
    #   @api public
    #   @example
    #     stat.dreb #=> 5.4
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds
    #   @api public
    #   @example
    #     stat.reb #=> 6.1
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists
    #   @api public
    #   @example
    #     stat.ast #=> 6.3
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers
    #   @api public
    #   @example
    #     stat.tov #=> 3.2
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals
    #   @api public
    #   @example
    #     stat.stl #=> 0.9
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 0.4
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] blka
    #   Returns blocked attempts
    #   @api public
    #   @example
    #     stat.blka #=> 0.3
    #   @return [Float] blocked attempts
    attribute :blka, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 2.0
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn
    #   @api public
    #   @example
    #     stat.pfd #=> 3.8
    #   @return [Float] personal fouls drawn
    attribute :pfd, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points
    #   @api public
    #   @example
    #     stat.pts #=> 28.6
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] plus_minus
    #   Returns plus/minus
    #   @api public
    #   @example
    #     stat.plus_minus #=> 7.4
    #   @return [Float] plus/minus
    attribute :plus_minus, Shale::Type::Float

    # Returns the player object
    #
    # @api public
    # @example
    #   stat.player #=> #<NBA::Player>
    # @return [Player, nil] the player object
    def player
      Players.find(vs_player_id)
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
