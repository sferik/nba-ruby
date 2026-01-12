module NBA
  # Represents a team's year-by-year statistics
  class TeamYearStat < Shale::Mapper
    include Equalizer.new(:team_id, :year)

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

    # @!attribute [rw] year
    #   Returns the year
    #   @api public
    #   @example
    #     stat.year #=> "2024-25"
    #   @return [String] the year
    attribute :year, Shale::Type::String

    # @!attribute [rw] gp
    #   Returns games played
    #   @api public
    #   @example
    #     stat.gp #=> 82
    #   @return [Integer] games played
    attribute :gp, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns wins
    #   @api public
    #   @example
    #     stat.wins #=> 46
    #   @return [Integer] wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns losses
    #   @api public
    #   @example
    #     stat.losses #=> 36
    #   @return [Integer] losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] win_pct
    #   Returns win percentage
    #   @api public
    #   @example
    #     stat.win_pct #=> 0.561
    #   @return [Float] win percentage
    attribute :win_pct, Shale::Type::Float

    # @!attribute [rw] conf_rank
    #   Returns conference rank
    #   @api public
    #   @example
    #     stat.conf_rank #=> 10
    #   @return [Integer] conference rank
    attribute :conf_rank, Shale::Type::Integer

    # @!attribute [rw] div_rank
    #   Returns division rank
    #   @api public
    #   @example
    #     stat.div_rank #=> 3
    #   @return [Integer] division rank
    attribute :div_rank, Shale::Type::Integer

    # @!attribute [rw] po_wins
    #   Returns playoff wins
    #   @api public
    #   @example
    #     stat.po_wins #=> 0
    #   @return [Integer] playoff wins
    attribute :po_wins, Shale::Type::Integer

    # @!attribute [rw] po_losses
    #   Returns playoff losses
    #   @api public
    #   @example
    #     stat.po_losses #=> 0
    #   @return [Integer] playoff losses
    attribute :po_losses, Shale::Type::Integer

    # @!attribute [rw] nba_finals_appearance
    #   Returns NBA Finals appearance
    #   @api public
    #   @example
    #     stat.nba_finals_appearance #=> "N/A"
    #   @return [String] Finals appearance
    attribute :nba_finals_appearance, Shale::Type::String

    # @!attribute [rw] fgm
    #   Returns field goals made per game
    #   @api public
    #   @example
    #     stat.fgm #=> 43.2
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted per game
    #   @api public
    #   @example
    #     stat.fga #=> 91.5
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.472
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made per game
    #   @api public
    #   @example
    #     stat.fg3m #=> 14.8
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted per game
    #   @api public
    #   @example
    #     stat.fg3a #=> 40.2
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.368
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # @!attribute [rw] ftm
    #   Returns free throws made per game
    #   @api public
    #   @example
    #     stat.ftm #=> 17.5
    #   @return [Float] free throws made
    attribute :ftm, Shale::Type::Float

    # @!attribute [rw] fta
    #   Returns free throws attempted per game
    #   @api public
    #   @example
    #     stat.fta #=> 22.1
    #   @return [Float] free throws attempted
    attribute :fta, Shale::Type::Float

    # @!attribute [rw] ft_pct
    #   Returns free throw percentage
    #   @api public
    #   @example
    #     stat.ft_pct #=> 0.792
    #   @return [Float] free throw percentage
    attribute :ft_pct, Shale::Type::Float

    # @!attribute [rw] oreb
    #   Returns offensive rebounds per game
    #   @api public
    #   @example
    #     stat.oreb #=> 10.5
    #   @return [Float] offensive rebounds
    attribute :oreb, Shale::Type::Float

    # @!attribute [rw] dreb
    #   Returns defensive rebounds per game
    #   @api public
    #   @example
    #     stat.dreb #=> 33.8
    #   @return [Float] defensive rebounds
    attribute :dreb, Shale::Type::Float

    # @!attribute [rw] reb
    #   Returns total rebounds per game
    #   @api public
    #   @example
    #     stat.reb #=> 44.3
    #   @return [Float] total rebounds
    attribute :reb, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 28.1
    #   @return [Float] assists
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] pf
    #   Returns personal fouls per game
    #   @api public
    #   @example
    #     stat.pf #=> 19.5
    #   @return [Float] personal fouls
    attribute :pf, Shale::Type::Float

    # @!attribute [rw] stl
    #   Returns steals per game
    #   @api public
    #   @example
    #     stat.stl #=> 7.8
    #   @return [Float] steals
    attribute :stl, Shale::Type::Float

    # @!attribute [rw] tov
    #   Returns turnovers per game
    #   @api public
    #   @example
    #     stat.tov #=> 14.2
    #   @return [Float] turnovers
    attribute :tov, Shale::Type::Float

    # @!attribute [rw] blk
    #   Returns blocks per game
    #   @api public
    #   @example
    #     stat.blk #=> 5.2
    #   @return [Float] blocks
    attribute :blk, Shale::Type::Float

    # @!attribute [rw] pts
    #   Returns points per game
    #   @api public
    #   @example
    #     stat.pts #=> 118.7
    #   @return [Float] points
    attribute :pts, Shale::Type::Float

    # @!attribute [rw] pts_rank
    #   Returns points rank
    #   @api public
    #   @example
    #     stat.pts_rank #=> 5
    #   @return [Integer] points rank
    attribute :pts_rank, Shale::Type::Integer

    # Returns the team object
    #
    # @api public
    # @example
    #   stat.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    # Returns the full team name
    #
    # @api public
    # @example
    #   stat.full_name #=> "Golden State Warriors"
    # @return [String] the full name
    def full_name
      "#{team_city} #{team_name}".strip
    end
  end
end
