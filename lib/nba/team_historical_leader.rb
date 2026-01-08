require "equalizer"
require "shale"

module NBA
  # Represents a team's all-time statistical leaders
  #
  # @api public
  class TeamHistoricalLeader < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     leader.team_id #=> 1610612744
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] season_year
    #   Returns the season year
    #   @api public
    #   @example
    #     leader.season_year #=> 2024
    #   @return [Integer, nil] the season year
    attribute :season_year, Shale::Type::Integer

    # @!attribute [rw] pts
    #   Returns the all-time points total
    #   @api public
    #   @example
    #     leader.pts #=> 25000
    #   @return [Integer, nil] all-time points total
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] pts_person_id
    #   Returns the points leader player ID
    #   @api public
    #   @example
    #     leader.pts_person_id #=> 201939
    #   @return [Integer, nil] points leader player ID
    attribute :pts_person_id, Shale::Type::Integer

    # @!attribute [rw] pts_player
    #   Returns the points leader player name
    #   @api public
    #   @example
    #     leader.pts_player #=> "Stephen Curry"
    #   @return [String, nil] points leader player name
    attribute :pts_player, Shale::Type::String

    # @!attribute [rw] ast
    #   Returns the all-time assists total
    #   @api public
    #   @example
    #     leader.ast #=> 5000
    #   @return [Integer, nil] all-time assists total
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] ast_person_id
    #   Returns the assists leader player ID
    #   @api public
    #   @example
    #     leader.ast_person_id #=> 201939
    #   @return [Integer, nil] assists leader player ID
    attribute :ast_person_id, Shale::Type::Integer

    # @!attribute [rw] ast_player
    #   Returns the assists leader player name
    #   @api public
    #   @example
    #     leader.ast_player #=> "Stephen Curry"
    #   @return [String, nil] assists leader player name
    attribute :ast_player, Shale::Type::String

    # @!attribute [rw] reb
    #   Returns the all-time rebounds total
    #   @api public
    #   @example
    #     leader.reb #=> 8000
    #   @return [Integer, nil] all-time rebounds total
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] reb_person_id
    #   Returns the rebounds leader player ID
    #   @api public
    #   @example
    #     leader.reb_person_id #=> 201142
    #   @return [Integer, nil] rebounds leader player ID
    attribute :reb_person_id, Shale::Type::Integer

    # @!attribute [rw] reb_player
    #   Returns the rebounds leader player name
    #   @api public
    #   @example
    #     leader.reb_player #=> "Wilt Chamberlain"
    #   @return [String, nil] rebounds leader player name
    attribute :reb_player, Shale::Type::String

    # @!attribute [rw] blk
    #   Returns the all-time blocks total
    #   @api public
    #   @example
    #     leader.blk #=> 1500
    #   @return [Integer, nil] all-time blocks total
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] blk_person_id
    #   Returns the blocks leader player ID
    #   @api public
    #   @example
    #     leader.blk_person_id #=> 201142
    #   @return [Integer, nil] blocks leader player ID
    attribute :blk_person_id, Shale::Type::Integer

    # @!attribute [rw] blk_player
    #   Returns the blocks leader player name
    #   @api public
    #   @example
    #     leader.blk_player #=> "Nate Thurmond"
    #   @return [String, nil] blocks leader player name
    attribute :blk_player, Shale::Type::String

    # @!attribute [rw] stl
    #   Returns the all-time steals total
    #   @api public
    #   @example
    #     leader.stl #=> 1200
    #   @return [Integer, nil] all-time steals total
    attribute :stl, Shale::Type::Integer

    # @!attribute [rw] stl_person_id
    #   Returns the steals leader player ID
    #   @api public
    #   @example
    #     leader.stl_person_id #=> 201939
    #   @return [Integer, nil] steals leader player ID
    attribute :stl_person_id, Shale::Type::Integer

    # @!attribute [rw] stl_player
    #   Returns the steals leader player name
    #   @api public
    #   @example
    #     leader.stl_player #=> "Chris Mullin"
    #   @return [String, nil] steals leader player name
    attribute :stl_player, Shale::Type::String

    # Returns the team for this leader record
    #
    # @api public
    # @example
    #   leader.team #=> #<NBA::Team ...>
    # @return [Team, nil] the team
    def team
      Teams.find(team_id)
    end

    # Returns the points leader player
    #
    # @api public
    # @example
    #   leader.pts_leader #=> #<NBA::Player ...>
    # @return [Player, nil] the points leader
    def pts_leader
      Players.find(pts_person_id)
    end

    # Returns the assists leader player
    #
    # @api public
    # @example
    #   leader.ast_leader #=> #<NBA::Player ...>
    # @return [Player, nil] the assists leader
    def ast_leader
      Players.find(ast_person_id)
    end

    # Returns the rebounds leader player
    #
    # @api public
    # @example
    #   leader.reb_leader #=> #<NBA::Player ...>
    # @return [Player, nil] the rebounds leader
    def reb_leader
      Players.find(reb_person_id)
    end

    # Returns the blocks leader player
    #
    # @api public
    # @example
    #   leader.blk_leader #=> #<NBA::Player ...>
    # @return [Player, nil] the blocks leader
    def blk_leader
      Players.find(blk_person_id)
    end

    # Returns the steals leader player
    #
    # @api public
    # @example
    #   leader.stl_leader #=> #<NBA::Player ...>
    # @return [Player, nil] the steals leader
    def stl_leader
      Players.find(stl_person_id)
    end
  end
end
