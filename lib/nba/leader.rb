require "equalizer"
require "shale"
require_relative "players"
require_relative "teams"

module NBA
  # Represents a statistical leader entry
  class Leader < Shale::Mapper
    include Equalizer.new(:player_id, :category)

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     leader.player_id #=> 201939
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     leader.player_name #=> "Stephen Curry"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] team_id
    #   Returns the team ID
    #   @api public
    #   @example
    #     leader.team_id #=> 1610612744
    #   @return [Integer] the team ID
    attribute :team_id, Shale::Type::Integer

    # @!attribute [rw] team_abbreviation
    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     leader.team_abbreviation #=> "GSW"
    #   @return [String] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    # @!attribute [rw] category
    #   Returns the statistical category
    #   @api public
    #   @example
    #     leader.category #=> "PTS"
    #   @return [String] the statistical category
    attribute :category, Shale::Type::String

    # @!attribute [rw] rank
    #   Returns the rank in the category
    #   @api public
    #   @example
    #     leader.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # @!attribute [rw] value
    #   Returns the statistical value
    #   @api public
    #   @example
    #     leader.value #=> 32.4
    #   @return [Float] the statistical value
    attribute :value, Shale::Type::Float

    # Returns the player object for this leader
    #
    # @api public
    # @example
    #   leader.player #=> #<NBA::Player>
    #   leader.player.college #=> "Davidson"
    # @return [Player, nil] the hydrated player object
    def player
      Players.find(player_id) if player_id
    end

    # Returns the team object for this leader
    #
    # @api public
    # @example
    #   leader.team #=> #<NBA::Team>
    #   leader.team.name #=> "Golden State Warriors"
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
      map "category", to: :category
      map "rank", to: :rank
      map "value", to: :value
    end
  end
end
