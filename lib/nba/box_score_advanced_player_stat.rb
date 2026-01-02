require "equalizer"
require "shale"

module NBA
  # Represents a player's advanced box score statistics for a game
  class BoxScoreAdvancedPlayerStat < Shale::Mapper
    include Equalizer.new(:game_id, :player_id)

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
    #     stat.min #=> "32:45"
    #   @return [String] the minutes played
    attribute :min, Shale::Type::String

    # @!attribute [rw] e_off_rating
    #   Returns estimated offensive rating
    #   @api public
    #   @example
    #     stat.e_off_rating #=> 118.5
    #   @return [Float] the estimated offensive rating
    attribute :e_off_rating, Shale::Type::Float

    # @!attribute [rw] off_rating
    #   Returns offensive rating
    #   @api public
    #   @example
    #     stat.off_rating #=> 120.3
    #   @return [Float] the offensive rating
    attribute :off_rating, Shale::Type::Float

    # @!attribute [rw] e_def_rating
    #   Returns estimated defensive rating
    #   @api public
    #   @example
    #     stat.e_def_rating #=> 108.2
    #   @return [Float] the estimated defensive rating
    attribute :e_def_rating, Shale::Type::Float

    # @!attribute [rw] def_rating
    #   Returns defensive rating
    #   @api public
    #   @example
    #     stat.def_rating #=> 106.8
    #   @return [Float] the defensive rating
    attribute :def_rating, Shale::Type::Float

    # @!attribute [rw] e_net_rating
    #   Returns estimated net rating
    #   @api public
    #   @example
    #     stat.e_net_rating #=> 10.3
    #   @return [Float] the estimated net rating
    attribute :e_net_rating, Shale::Type::Float

    # @!attribute [rw] net_rating
    #   Returns net rating
    #   @api public
    #   @example
    #     stat.net_rating #=> 13.5
    #   @return [Float] the net rating
    attribute :net_rating, Shale::Type::Float

    # @!attribute [rw] ast_pct
    #   Returns assist percentage
    #   @api public
    #   @example
    #     stat.ast_pct #=> 45.2
    #   @return [Float] the assist percentage
    attribute :ast_pct, Shale::Type::Float

    # @!attribute [rw] ast_tov
    #   Returns assist to turnover ratio
    #   @api public
    #   @example
    #     stat.ast_tov #=> 2.75
    #   @return [Float] the assist to turnover ratio
    attribute :ast_tov, Shale::Type::Float

    # @!attribute [rw] ast_ratio
    #   Returns assist ratio
    #   @api public
    #   @example
    #     stat.ast_ratio #=> 28.5
    #   @return [Float] the assist ratio
    attribute :ast_ratio, Shale::Type::Float

    # @!attribute [rw] oreb_pct
    #   Returns offensive rebound percentage
    #   @api public
    #   @example
    #     stat.oreb_pct #=> 3.2
    #   @return [Float] the offensive rebound percentage
    attribute :oreb_pct, Shale::Type::Float

    # @!attribute [rw] dreb_pct
    #   Returns defensive rebound percentage
    #   @api public
    #   @example
    #     stat.dreb_pct #=> 18.6
    #   @return [Float] the defensive rebound percentage
    attribute :dreb_pct, Shale::Type::Float

    # @!attribute [rw] reb_pct
    #   Returns total rebound percentage
    #   @api public
    #   @example
    #     stat.reb_pct #=> 10.9
    #   @return [Float] the total rebound percentage
    attribute :reb_pct, Shale::Type::Float

    # @!attribute [rw] tov_pct
    #   Returns turnover percentage
    #   @api public
    #   @example
    #     stat.tov_pct #=> 12.3
    #   @return [Float] the turnover percentage
    attribute :tov_pct, Shale::Type::Float

    # @!attribute [rw] efg_pct
    #   Returns effective field goal percentage
    #   @api public
    #   @example
    #     stat.efg_pct #=> 0.625
    #   @return [Float] the effective field goal percentage
    attribute :efg_pct, Shale::Type::Float

    # @!attribute [rw] ts_pct
    #   Returns true shooting percentage
    #   @api public
    #   @example
    #     stat.ts_pct #=> 0.658
    #   @return [Float] the true shooting percentage
    attribute :ts_pct, Shale::Type::Float

    # @!attribute [rw] usg_pct
    #   Returns usage percentage
    #   @api public
    #   @example
    #     stat.usg_pct #=> 32.4
    #   @return [Float] the usage percentage
    attribute :usg_pct, Shale::Type::Float

    # @!attribute [rw] e_usg_pct
    #   Returns estimated usage percentage
    #   @api public
    #   @example
    #     stat.e_usg_pct #=> 31.8
    #   @return [Float] the estimated usage percentage
    attribute :e_usg_pct, Shale::Type::Float

    # @!attribute [rw] e_pace
    #   Returns estimated pace
    #   @api public
    #   @example
    #     stat.e_pace #=> 100.5
    #   @return [Float] the estimated pace
    attribute :e_pace, Shale::Type::Float

    # @!attribute [rw] pace
    #   Returns pace
    #   @api public
    #   @example
    #     stat.pace #=> 102.3
    #   @return [Float] the pace
    attribute :pace, Shale::Type::Float

    # @!attribute [rw] pace_per40
    #   Returns pace per 40 minutes
    #   @api public
    #   @example
    #     stat.pace_per40 #=> 101.8
    #   @return [Float] the pace per 40 minutes
    attribute :pace_per40, Shale::Type::Float

    # @!attribute [rw] poss
    #   Returns possessions
    #   @api public
    #   @example
    #     stat.poss #=> 65
    #   @return [Integer] the possessions
    attribute :poss, Shale::Type::Integer

    # @!attribute [rw] pie
    #   Returns player impact estimate
    #   @api public
    #   @example
    #     stat.pie #=> 18.4
    #   @return [Float] the player impact estimate
    attribute :pie, Shale::Type::Float

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
