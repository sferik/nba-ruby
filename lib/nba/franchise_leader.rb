require "equalizer"
require "shale"

module NBA
  # Represents franchise leaders in various statistical categories
  class FranchiseLeader < Shale::Mapper
    include Equalizer.new(:team_id)

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     leader.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] pts_person_id
    #   Returns the person ID of the points leader
    #   @api public
    #   @example
    #     leader.pts_person_id #=> 201939
    #   @return [Integer] the points leader's person ID
    attribute :pts_person_id, Shale::Type::Integer

    # @!attribute [rw] pts_player_name
    #   Returns the name of the points leader
    #   @api public
    #   @example
    #     leader.pts_player_name #=> "Stephen Curry"
    #   @return [String] the points leader's name
    attribute :pts_player_name, Shale::Type::String

    # @!attribute [rw] pts
    #   Returns the total points scored by the leader
    #   @api public
    #   @example
    #     leader.pts #=> 23668
    #   @return [Integer] the total points
    attribute :pts, Shale::Type::Integer

    # @!attribute [rw] ast_person_id
    #   Returns the person ID of the assists leader
    #   @api public
    #   @example
    #     leader.ast_person_id #=> 201939
    #   @return [Integer] the assists leader's person ID
    attribute :ast_person_id, Shale::Type::Integer

    # @!attribute [rw] ast_player_name
    #   Returns the name of the assists leader
    #   @api public
    #   @example
    #     leader.ast_player_name #=> "Stephen Curry"
    #   @return [String] the assists leader's name
    attribute :ast_player_name, Shale::Type::String

    # @!attribute [rw] ast
    #   Returns the total assists by the leader
    #   @api public
    #   @example
    #     leader.ast #=> 5845
    #   @return [Integer] the total assists
    attribute :ast, Shale::Type::Integer

    # @!attribute [rw] reb_person_id
    #   Returns the person ID of the rebounds leader
    #   @api public
    #   @example
    #     leader.reb_person_id #=> 600015
    #   @return [Integer] the rebounds leader's person ID
    attribute :reb_person_id, Shale::Type::Integer

    # @!attribute [rw] reb_player_name
    #   Returns the name of the rebounds leader
    #   @api public
    #   @example
    #     leader.reb_player_name #=> "Nate Thurmond"
    #   @return [String] the rebounds leader's name
    attribute :reb_player_name, Shale::Type::String

    # @!attribute [rw] reb
    #   Returns the total rebounds by the leader
    #   @api public
    #   @example
    #     leader.reb #=> 12771
    #   @return [Integer] the total rebounds
    attribute :reb, Shale::Type::Integer

    # @!attribute [rw] blk_person_id
    #   Returns the person ID of the blocks leader
    #   @api public
    #   @example
    #     leader.blk_person_id #=> 2442
    #   @return [Integer] the blocks leader's person ID
    attribute :blk_person_id, Shale::Type::Integer

    # @!attribute [rw] blk_player_name
    #   Returns the name of the blocks leader
    #   @api public
    #   @example
    #     leader.blk_player_name #=> "Manute Bol"
    #   @return [String] the blocks leader's name
    attribute :blk_player_name, Shale::Type::String

    # @!attribute [rw] blk
    #   Returns the total blocks by the leader
    #   @api public
    #   @example
    #     leader.blk #=> 2086
    #   @return [Integer] the total blocks
    attribute :blk, Shale::Type::Integer

    # @!attribute [rw] stl_person_id
    #   Returns the person ID of the steals leader
    #   @api public
    #   @example
    #     leader.stl_person_id #=> 959
    #   @return [Integer] the steals leader's person ID
    attribute :stl_person_id, Shale::Type::Integer

    # @!attribute [rw] stl_player_name
    #   Returns the name of the steals leader
    #   @api public
    #   @example
    #     leader.stl_player_name #=> "Chris Mullin"
    #   @return [String] the steals leader's name
    attribute :stl_player_name, Shale::Type::String

    # @!attribute [rw] stl
    #   Returns the total steals by the leader
    #   @api public
    #   @example
    #     leader.stl #=> 1360
    #   @return [Integer] the total steals
    attribute :stl, Shale::Type::Integer

    # Returns the team object for this franchise
    #
    # @api public
    # @example
    #   leader.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end
  end
end
