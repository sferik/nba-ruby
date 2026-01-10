require "equalizer"
require "shale"

module NBA
  # Represents a leaders tile entry
  #
  # @api public
  # @example
  #   tile.rank #=> 1
  #   tile.team_abbreviation #=> "BOS"
  #   tile.pts #=> 120.5
  class LeadersTile < Shale::Mapper
    include Equalizer.new(:rank, :team_id)

    #   Returns the rank
    #   @api public
    #   @example
    #     tile.rank #=> 1
    #   @return [Integer, nil] the rank
    attribute :rank, Shale::Type::Integer

    #   Returns the team ID
    #   @api public
    #   @example
    #     tile.team_id #=> 1610612738
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     tile.team_abbreviation #=> "BOS"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    #   Returns the team name
    #   @api public
    #   @example
    #     tile.team_name #=> "Boston Celtics"
    #   @return [String, nil] the team name
    attribute :team_name, Shale::Type::String

    #   Returns points
    #   @api public
    #   @example
    #     tile.pts #=> 120.5
    #   @return [Float, nil] points
    attribute :pts, Shale::Type::Float

    #   Returns season year (for all-time/low records)
    #   @api public
    #   @example
    #     tile.season_year #=> "2023-24"
    #   @return [String, nil] season year (for all-time/low records)
    attribute :season_year, Shale::Type::String
  end
end
