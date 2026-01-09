require "equalizer"
require "shale"

module NBA
  # Represents a single game entry from cumulative stats player games
  class CumeStatsPlayerGamesEntry < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     entry.game_id #=> "0022400001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] matchup
    #   Returns the game matchup description
    #   @api public
    #   @example
    #     entry.matchup #=> "GSW vs. LAL"
    #   @return [String] the matchup description
    attribute :matchup, Shale::Type::String
  end
end
