require "equalizer"
require "shale"

module NBA
  # Represents a cumulative stats team games entry
  class CumeStatsTeamGamesEntry < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     entry.game_id #=> 22300001
    #   @return [Integer] the game ID
    attribute :game_id, Shale::Type::Integer

    # @!attribute [rw] matchup
    #   Returns the game matchup
    #   @api public
    #   @example
    #     entry.matchup #=> "LAL @ DEN"
    #   @return [String] the matchup
    attribute :matchup, Shale::Type::String
  end
end
