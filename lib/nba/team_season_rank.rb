require "equalizer"
require "shale"
require_relative "teams"

module NBA
  # Represents team season rankings from the TeamInfoCommon endpoint
  #
  # @api public
  class TeamSeasonRank < Shale::Mapper
    include Equalizer.new(:team_id, :season_id)

    # @!attribute [rw] league_id
    #   Returns the league ID
    #   @api public
    #   @example
    #     rank.league_id #=> "00"
    #   @return [String, nil] the league ID
    attribute :league_id, Shale::Type::String

    # @!attribute [rw] season_id
    #   Returns the season ID
    #   @api public
    #   @example
    #     rank.season_id #=> "2024-25"
    #   @return [String, nil] the season ID
    attribute :season_id, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     rank.team_id #=> 1610612744
    #   @return [Integer, nil] the team's ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] pts_rank
    #   Returns the points per game rank
    #   @api public
    #   @example
    #     rank.pts_rank #=> 5
    #   @return [Integer, nil] the points rank
    attribute :pts_rank, Shale::Type::Integer

    # @!attribute [rw] pts_pg
    #   Returns the points per game
    #   @api public
    #   @example
    #     rank.pts_pg #=> 118.9
    #   @return [Float, nil] the points per game
    attribute :pts_pg, Shale::Type::Float

    # @!attribute [rw] reb_rank
    #   Returns the rebounds per game rank
    #   @api public
    #   @example
    #     rank.reb_rank #=> 12
    #   @return [Integer, nil] the rebounds rank
    attribute :reb_rank, Shale::Type::Integer

    # @!attribute [rw] reb_pg
    #   Returns the rebounds per game
    #   @api public
    #   @example
    #     rank.reb_pg #=> 44.2
    #   @return [Float, nil] the rebounds per game
    attribute :reb_pg, Shale::Type::Float

    # @!attribute [rw] ast_rank
    #   Returns the assists per game rank
    #   @api public
    #   @example
    #     rank.ast_rank #=> 3
    #   @return [Integer, nil] the assists rank
    attribute :ast_rank, Shale::Type::Integer

    # @!attribute [rw] ast_pg
    #   Returns the assists per game
    #   @api public
    #   @example
    #     rank.ast_pg #=> 28.7
    #   @return [Float, nil] the assists per game
    attribute :ast_pg, Shale::Type::Float

    # @!attribute [rw] opp_pts_rank
    #   Returns the opponent points per game rank
    #   @api public
    #   @example
    #     rank.opp_pts_rank #=> 15
    #   @return [Integer, nil] the opponent points rank
    attribute :opp_pts_rank, Shale::Type::Integer

    # @!attribute [rw] opp_pts_pg
    #   Returns the opponent points per game
    #   @api public
    #   @example
    #     rank.opp_pts_pg #=> 115.2
    #   @return [Float, nil] the opponent points per game
    attribute :opp_pts_pg, Shale::Type::Float

    # Returns the team associated with this rank
    #
    # @api public
    # @example
    #   rank.team #=> #<NBA::Team ...>
    # @return [Team, nil] the Team object
    def team
      Teams.find(team_id)
    end
  end
end
