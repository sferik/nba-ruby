require "shale"
require "equalizer"

module NBA
  # Represents a team's miscellaneous box score statistics for a game
  class BoxScoreMiscTeamStat < Shale::Mapper
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

    # @!attribute [rw] pts_off_tov
    #   Returns points off turnovers
    #   @api public
    #   @example
    #     stat.pts_off_tov #=> 18
    #   @return [Integer] points off turnovers
    attribute :pts_off_tov, Shale::Type::Integer

    # @!attribute [rw] pts_2nd_chance
    #   Returns second chance points
    #   @api public
    #   @example
    #     stat.pts_2nd_chance #=> 14
    #   @return [Integer] second chance points
    attribute :pts_2nd_chance, Shale::Type::Integer

    # @!attribute [rw] pts_fb
    #   Returns fast break points
    #   @api public
    #   @example
    #     stat.pts_fb #=> 22
    #   @return [Integer] fast break points
    attribute :pts_fb, Shale::Type::Integer

    # @!attribute [rw] pts_paint
    #   Returns points in the paint
    #   @api public
    #   @example
    #     stat.pts_paint #=> 54
    #   @return [Integer] points in the paint
    attribute :pts_paint, Shale::Type::Integer

    # @!attribute [rw] opp_pts_off_tov
    #   Returns opponent points off turnovers
    #   @api public
    #   @example
    #     stat.opp_pts_off_tov #=> 15
    #   @return [Integer] opponent points off turnovers
    attribute :opp_pts_off_tov, Shale::Type::Integer

    # @!attribute [rw] opp_pts_2nd_chance
    #   Returns opponent second chance points
    #   @api public
    #   @example
    #     stat.opp_pts_2nd_chance #=> 11
    #   @return [Integer] opponent second chance points
    attribute :opp_pts_2nd_chance, Shale::Type::Integer

    # @!attribute [rw] opp_pts_fb
    #   Returns opponent fast break points
    #   @api public
    #   @example
    #     stat.opp_pts_fb #=> 16
    #   @return [Integer] opponent fast break points
    attribute :opp_pts_fb, Shale::Type::Integer

    # @!attribute [rw] opp_pts_paint
    #   Returns opponent points in the paint
    #   @api public
    #   @example
    #     stat.opp_pts_paint #=> 48
    #   @return [Integer] opponent points in the paint
    attribute :opp_pts_paint, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 7
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] blka
    #   Returns blocked attempts
    #   @api public
    #   @example
    #     stat.blka #=> 5
    #   @return [Integer] blocked attempts
    attribute :blka, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 21
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn
    #   @api public
    #   @example
    #     stat.pfd #=> 19
    #   @return [Integer] personal fouls drawn
    attribute :pfd, Shale::Type::Integer

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
