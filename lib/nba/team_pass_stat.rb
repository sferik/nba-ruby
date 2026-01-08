require "equalizer"
require "shale"

module NBA
  # Represents team tracking pass statistics
  #
  # @api public
  class TeamPassStat < Shale::Mapper
    include Equalizer.new(:team_id, :pass_teammate_player_id)

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
    #     stat.team_name #=> "Golden State Warriors"
    #   @return [String] the team name
    attribute :team_name, Shale::Type::String

    # @!attribute [rw] pass_type
    #   Returns the type of pass
    #   @api public
    #   @example
    #     stat.pass_type #=> "Made"
    #   @return [String] the pass type
    attribute :pass_type, Shale::Type::String

    # @!attribute [rw] g
    #   Returns games
    #   @api public
    #   @example
    #     stat.g #=> 74
    #   @return [Integer] games
    attribute :g, Shale::Type::Integer

    # @!attribute [rw] pass_from
    #   Returns the passer name (for passes made)
    #   @api public
    #   @example
    #     stat.pass_from #=> "Stephen Curry"
    #   @return [String] the passer name
    attribute :pass_from, Shale::Type::String

    # @!attribute [rw] pass_to
    #   Returns the pass recipient name (for passes received)
    #   @api public
    #   @example
    #     stat.pass_to #=> "Klay Thompson"
    #   @return [String] the recipient name
    attribute :pass_to, Shale::Type::String

    # @!attribute [rw] pass_teammate_player_id
    #   Returns the pass partner player ID
    #   @api public
    #   @example
    #     stat.pass_teammate_player_id #=> 202691
    #   @return [Integer] the teammate player ID
    attribute :pass_teammate_player_id, Shale::Type::Integer

    # @!attribute [rw] frequency
    #   Returns the frequency percentage
    #   @api public
    #   @example
    #     stat.frequency #=> 0.25
    #   @return [Float] the frequency
    attribute :frequency, Shale::Type::Float

    # @!attribute [rw] pass
    #   Returns passes per game
    #   @api public
    #   @example
    #     stat.pass #=> 5.2
    #   @return [Float] passes per game
    attribute :pass, Shale::Type::Float

    # @!attribute [rw] ast
    #   Returns assists per game
    #   @api public
    #   @example
    #     stat.ast #=> 2.1
    #   @return [Float] assists per game
    attribute :ast, Shale::Type::Float

    # @!attribute [rw] fgm
    #   Returns field goals made following pass
    #   @api public
    #   @example
    #     stat.fgm #=> 3.5
    #   @return [Float] field goals made
    attribute :fgm, Shale::Type::Float

    # @!attribute [rw] fga
    #   Returns field goals attempted following pass
    #   @api public
    #   @example
    #     stat.fga #=> 7.2
    #   @return [Float] field goals attempted
    attribute :fga, Shale::Type::Float

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage following pass
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.486
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float

    # @!attribute [rw] fg2m
    #   Returns two-pointers made following pass
    #   @api public
    #   @example
    #     stat.fg2m #=> 1.5
    #   @return [Float] two-pointers made
    attribute :fg2m, Shale::Type::Float

    # @!attribute [rw] fg2a
    #   Returns two-pointers attempted following pass
    #   @api public
    #   @example
    #     stat.fg2a #=> 3.0
    #   @return [Float] two-pointers attempted
    attribute :fg2a, Shale::Type::Float

    # @!attribute [rw] fg2_pct
    #   Returns two-point percentage following pass
    #   @api public
    #   @example
    #     stat.fg2_pct #=> 0.500
    #   @return [Float] two-point percentage
    attribute :fg2_pct, Shale::Type::Float

    # @!attribute [rw] fg3m
    #   Returns three-pointers made following pass
    #   @api public
    #   @example
    #     stat.fg3m #=> 2.0
    #   @return [Float] three-pointers made
    attribute :fg3m, Shale::Type::Float

    # @!attribute [rw] fg3a
    #   Returns three-pointers attempted following pass
    #   @api public
    #   @example
    #     stat.fg3a #=> 4.2
    #   @return [Float] three-pointers attempted
    attribute :fg3a, Shale::Type::Float

    # @!attribute [rw] fg3_pct
    #   Returns three-point percentage following pass
    #   @api public
    #   @example
    #     stat.fg3_pct #=> 0.476
    #   @return [Float] three-point percentage
    attribute :fg3_pct, Shale::Type::Float

    # Returns the teammate player object
    #
    # @api public
    # @example
    #   stat.teammate #=> #<NBA::Player>
    # @return [Player, nil] the teammate player object
    def teammate
      Players.find(pass_teammate_player_id)
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
