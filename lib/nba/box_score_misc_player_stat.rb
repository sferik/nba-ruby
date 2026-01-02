require "shale"
require "equalizer"

module NBA
  # Represents a player's miscellaneous box score statistics for a game
  class BoxScoreMiscPlayerStat < Shale::Mapper
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

    # @!attribute [rw] pts_off_tov
    #   Returns points off turnovers
    #   @api public
    #   @example
    #     stat.pts_off_tov #=> 12
    #   @return [Integer] points off turnovers
    attribute :pts_off_tov, Shale::Type::Integer

    # @!attribute [rw] pts_2nd_chance
    #   Returns second chance points
    #   @api public
    #   @example
    #     stat.pts_2nd_chance #=> 8
    #   @return [Integer] second chance points
    attribute :pts_2nd_chance, Shale::Type::Integer

    # @!attribute [rw] pts_fb
    #   Returns fast break points
    #   @api public
    #   @example
    #     stat.pts_fb #=> 15
    #   @return [Integer] fast break points
    attribute :pts_fb, Shale::Type::Integer

    # @!attribute [rw] pts_paint
    #   Returns points in the paint
    #   @api public
    #   @example
    #     stat.pts_paint #=> 42
    #   @return [Integer] points in the paint
    attribute :pts_paint, Shale::Type::Integer

    # @!attribute [rw] opp_pts_off_tov
    #   Returns opponent points off turnovers
    #   @api public
    #   @example
    #     stat.opp_pts_off_tov #=> 10
    #   @return [Integer] opponent points off turnovers
    attribute :opp_pts_off_tov, Shale::Type::Integer

    # @!attribute [rw] opp_pts_2nd_chance
    #   Returns opponent second chance points
    #   @api public
    #   @example
    #     stat.opp_pts_2nd_chance #=> 6
    #   @return [Integer] opponent second chance points
    attribute :opp_pts_2nd_chance, Shale::Type::Integer

    # @!attribute [rw] opp_pts_fb
    #   Returns opponent fast break points
    #   @api public
    #   @example
    #     stat.opp_pts_fb #=> 9
    #   @return [Integer] opponent fast break points
    attribute :opp_pts_fb, Shale::Type::Integer

    # @!attribute [rw] opp_pts_paint
    #   Returns opponent points in the paint
    #   @api public
    #   @example
    #     stat.opp_pts_paint #=> 38
    #   @return [Integer] opponent points in the paint
    attribute :opp_pts_paint, Shale::Type::Integer

    # @!attribute [rw] blk
    #   Returns blocks
    #   @api public
    #   @example
    #     stat.blk #=> 2
    #   @return [Integer] blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] blka
    #   Returns blocked attempts
    #   @api public
    #   @example
    #     stat.blka #=> 1
    #   @return [Integer] blocked attempts
    attribute :blka, Shale::Type::Integer

    # @!attribute [rw] pf
    #   Returns personal fouls
    #   @api public
    #   @example
    #     stat.pf #=> 3
    #   @return [Integer] personal fouls
    attribute :pf, Shale::Type::Integer

    # @!attribute [rw] pfd
    #   Returns personal fouls drawn
    #   @api public
    #   @example
    #     stat.pfd #=> 4
    #   @return [Integer] personal fouls drawn
    attribute :pfd, Shale::Type::Integer

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
