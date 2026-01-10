require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents a dunk score leader from the draft combine
  class DunkScoreLeader < Shale::Mapper
    include Equalizer.new(:player_id, :rank)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     leader.player_id #=> 1631094
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     leader.player_name #=> "Paolo Banchero"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     leader.team_id #=> 1610612753
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     leader.team_abbreviation #=> "ORL"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] rank
    #   Returns the rank in dunk score
    #   @api public
    #   @example
    #     leader.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # @!attribute [rw] dunk_score
    #   Returns the dunk score
    #   @api public
    #   @example
    #     leader.dunk_score #=> 85.5
    #   @return [Float] the dunk score
    attribute :dunk_score, Shale::Type::Float

    # Returns the player object for this leader
    #
    # @api public
    # @example
    #   leader.player #=> #<NBA::Player>
    # @return [Player, nil] the hydrated player object
    def player
      Players.find(player_id)
    end

    # Returns the team object for this leader
    #
    # @api public
    # @example
    #   leader.team #=> #<NBA::Team>
    # @return [Team, nil] the team object
    def team
      Teams.find(team_id)
    end

    json do
      map "player_id", to: :player_id
      map "playerId", to: :player_id
      map "player_name", to: :player_name
      map "playerName", to: :player_name
      map "team_id", to: :team_id
      map "teamId", to: :team_id
      map "team_abbreviation", to: :team_abbreviation
      map "teamAbbreviation", to: :team_abbreviation
      map "rank", to: :rank
      map "dunk_score", to: :dunk_score
      map "dunkScore", to: :dunk_score
    end
  end
end
