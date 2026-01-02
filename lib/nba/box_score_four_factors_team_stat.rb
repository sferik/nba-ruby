require "shale"
require "equalizer"

module NBA
  # Represents a team's four factors box score statistics for a game
  class BoxScoreFourFactorsTeamStat < Shale::Mapper
    include Equalizer.new(:game_id, :team_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     stat.game_id #=> "0022400350"
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

    # @!attribute [rw] efg_pct
    #   Returns effective field goal percentage
    #   @api public
    #   @example
    #     stat.efg_pct #=> 0.562
    #   @return [Float] the effective field goal percentage
    attribute :efg_pct, Shale::Type::Float

    # @!attribute [rw] fta_rate
    #   Returns free throw attempt rate
    #   @api public
    #   @example
    #     stat.fta_rate #=> 0.284
    #   @return [Float] the free throw attempt rate
    attribute :fta_rate, Shale::Type::Float

    # @!attribute [rw] tov_pct
    #   Returns turnover percentage
    #   @api public
    #   @example
    #     stat.tov_pct #=> 14.5
    #   @return [Float] the turnover percentage
    attribute :tov_pct, Shale::Type::Float

    # @!attribute [rw] oreb_pct
    #   Returns offensive rebound percentage
    #   @api public
    #   @example
    #     stat.oreb_pct #=> 22.2
    #   @return [Float] the offensive rebound percentage
    attribute :oreb_pct, Shale::Type::Float

    # @!attribute [rw] opp_efg_pct
    #   Returns opponent effective field goal percentage
    #   @api public
    #   @example
    #     stat.opp_efg_pct #=> 0.485
    #   @return [Float] the opponent effective field goal percentage
    attribute :opp_efg_pct, Shale::Type::Float

    # @!attribute [rw] opp_fta_rate
    #   Returns opponent free throw attempt rate
    #   @api public
    #   @example
    #     stat.opp_fta_rate #=> 0.310
    #   @return [Float] the opponent free throw attempt rate
    attribute :opp_fta_rate, Shale::Type::Float

    # @!attribute [rw] opp_tov_pct
    #   Returns opponent turnover percentage
    #   @api public
    #   @example
    #     stat.opp_tov_pct #=> 17.8
    #   @return [Float] the opponent turnover percentage
    attribute :opp_tov_pct, Shale::Type::Float

    # @!attribute [rw] opp_oreb_pct
    #   Returns opponent offensive rebound percentage
    #   @api public
    #   @example
    #     stat.opp_oreb_pct #=> 20.5
    #   @return [Float] the opponent offensive rebound percentage
    attribute :opp_oreb_pct, Shale::Type::Float

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
