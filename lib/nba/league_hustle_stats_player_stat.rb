require "equalizer"
require "shale"

module NBA
  # Represents league-wide hustle statistics for a player
  class LeagueHustleStatsPlayerStat < Shale::Mapper
    include Equalizer.new(:player_id)

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

    # @!attribute [rw] age
    #   Returns the player's age
    #   @api public
    #   @example
    #     stat.age #=> 36
    #   @return [Integer] the age
    attribute :age, Shale::Type::Integer

    # @!attribute [rw] g
    #   Returns games played
    #   @api public
    #   @example
    #     stat.g #=> 72
    #   @return [Integer] games played
    attribute :g, Shale::Type::Integer

    # @!attribute [rw] min
    #   Returns total minutes played
    #   @api public
    #   @example
    #     stat.min #=> 2484.5
    #   @return [Float] total minutes
    attribute :min, Shale::Type::Float

    # @!attribute [rw] contested_shots
    #   Returns contested shots
    #   @api public
    #   @example
    #     stat.contested_shots #=> 156
    #   @return [Integer] contested shots
    attribute :contested_shots, Shale::Type::Integer

    # @!attribute [rw] contested_shots_2pt
    #   Returns contested 2-point shots
    #   @api public
    #   @example
    #     stat.contested_shots_2pt #=> 98
    #   @return [Integer] contested 2-point shots
    attribute :contested_shots_2pt, Shale::Type::Integer

    # @!attribute [rw] contested_shots_3pt
    #   Returns contested 3-point shots
    #   @api public
    #   @example
    #     stat.contested_shots_3pt #=> 58
    #   @return [Integer] contested 3-point shots
    attribute :contested_shots_3pt, Shale::Type::Integer

    # @!attribute [rw] deflections
    #   Returns deflections
    #   @api public
    #   @example
    #     stat.deflections #=> 85
    #   @return [Integer] deflections
    attribute :deflections, Shale::Type::Integer

    # @!attribute [rw] charges_drawn
    #   Returns charges drawn
    #   @api public
    #   @example
    #     stat.charges_drawn #=> 5
    #   @return [Integer] charges drawn
    attribute :charges_drawn, Shale::Type::Integer

    # @!attribute [rw] screen_assists
    #   Returns screen assists
    #   @api public
    #   @example
    #     stat.screen_assists #=> 142
    #   @return [Integer] screen assists
    attribute :screen_assists, Shale::Type::Integer

    # @!attribute [rw] screen_ast_pts
    #   Returns points from screen assists
    #   @api public
    #   @example
    #     stat.screen_ast_pts #=> 284
    #   @return [Integer] screen assist points
    attribute :screen_ast_pts, Shale::Type::Integer

    # @!attribute [rw] off_loose_balls_recovered
    #   Returns offensive loose balls recovered
    #   @api public
    #   @example
    #     stat.off_loose_balls_recovered #=> 25
    #   @return [Integer] offensive loose balls recovered
    attribute :off_loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] def_loose_balls_recovered
    #   Returns defensive loose balls recovered
    #   @api public
    #   @example
    #     stat.def_loose_balls_recovered #=> 35
    #   @return [Integer] defensive loose balls recovered
    attribute :def_loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] loose_balls_recovered
    #   Returns total loose balls recovered
    #   @api public
    #   @example
    #     stat.loose_balls_recovered #=> 60
    #   @return [Integer] loose balls recovered
    attribute :loose_balls_recovered, Shale::Type::Integer

    # @!attribute [rw] pct_loose_balls_recovered_off
    #   Returns percentage of offensive loose balls recovered
    #   @api public
    #   @example
    #     stat.pct_loose_balls_recovered_off #=> 0.417
    #   @return [Float] percentage of offensive loose balls recovered
    attribute :pct_loose_balls_recovered_off, Shale::Type::Float

    # @!attribute [rw] pct_loose_balls_recovered_def
    #   Returns percentage of defensive loose balls recovered
    #   @api public
    #   @example
    #     stat.pct_loose_balls_recovered_def #=> 0.583
    #   @return [Float] percentage of defensive loose balls recovered
    attribute :pct_loose_balls_recovered_def, Shale::Type::Float

    # @!attribute [rw] off_boxouts
    #   Returns offensive box outs
    #   @api public
    #   @example
    #     stat.off_boxouts #=> 12
    #   @return [Integer] offensive box outs
    attribute :off_boxouts, Shale::Type::Integer

    # @!attribute [rw] def_boxouts
    #   Returns defensive box outs
    #   @api public
    #   @example
    #     stat.def_boxouts #=> 45
    #   @return [Integer] defensive box outs
    attribute :def_boxouts, Shale::Type::Integer

    # @!attribute [rw] box_out_player_team_rebs
    #   Returns team rebounds from player box outs
    #   @api public
    #   @example
    #     stat.box_out_player_team_rebs #=> 38
    #   @return [Integer] team rebounds from box outs
    attribute :box_out_player_team_rebs, Shale::Type::Integer

    # @!attribute [rw] box_out_player_rebs
    #   Returns player rebounds from box outs
    #   @api public
    #   @example
    #     stat.box_out_player_rebs #=> 22
    #   @return [Integer] player rebounds from box outs
    attribute :box_out_player_rebs, Shale::Type::Integer

    # @!attribute [rw] box_outs
    #   Returns total box outs
    #   @api public
    #   @example
    #     stat.box_outs #=> 57
    #   @return [Integer] total box outs
    attribute :box_outs, Shale::Type::Integer

    # @!attribute [rw] pct_box_outs_off
    #   Returns percentage of offensive box outs
    #   @api public
    #   @example
    #     stat.pct_box_outs_off #=> 0.211
    #   @return [Float] percentage of offensive box outs
    attribute :pct_box_outs_off, Shale::Type::Float

    # @!attribute [rw] pct_box_outs_def
    #   Returns percentage of defensive box outs
    #   @api public
    #   @example
    #     stat.pct_box_outs_def #=> 0.789
    #   @return [Float] percentage of defensive box outs
    attribute :pct_box_outs_def, Shale::Type::Float

    # @!attribute [rw] pct_box_outs_team_reb
    #   Returns percentage of box outs resulting in team rebounds
    #   @api public
    #   @example
    #     stat.pct_box_outs_team_reb #=> 0.667
    #   @return [Float] percentage of box outs resulting in team rebounds
    attribute :pct_box_outs_team_reb, Shale::Type::Float

    # @!attribute [rw] pct_box_outs_reb
    #   Returns percentage of box outs resulting in player rebounds
    #   @api public
    #   @example
    #     stat.pct_box_outs_reb #=> 0.386
    #   @return [Float] percentage of box outs resulting in player rebounds
    attribute :pct_box_outs_reb, Shale::Type::Float

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
