require "equalizer"
require "shale"

module NBA
  # Represents a home page statistic entry
  #
  # @api public
  # @example
  #   stat.rank #=> 1
  #   stat.team_abbreviation #=> "BOS"
  #   stat.value #=> 120.5
  class HomePageStat < Shale::Mapper
    include Equalizer.new(:rank, :team_id)

    #   Returns the rank
    #   @api public
    #   @example
    #     stat.rank #=> 1
    #   @return [Integer, nil] the rank
    attribute :rank, Shale::Type::Integer

    #   Returns the team ID
    #   @api public
    #   @example
    #     stat.team_id #=> 1610612738
    #   @return [Integer, nil] the team ID
    attribute :team_id, Shale::Type::Integer

    #   Returns the team abbreviation
    #   @api public
    #   @example
    #     stat.team_abbreviation #=> "BOS"
    #   @return [String, nil] the team abbreviation
    attribute :team_abbreviation, Shale::Type::String

    #   Returns the team name
    #   @api public
    #   @example
    #     stat.team_name #=> "Boston Celtics"
    #   @return [String, nil] the team name
    attribute :team_name, Shale::Type::String

    #   Returns the statistic value
    #   @api public
    #   @example
    #     stat.value #=> 120.5
    #   @return [Float, nil] the statistic value
    attribute :value, Shale::Type::Float

    #   Returns the statistic name
    #   @api public
    #   @example
    #     stat.stat_name #=> "pts"
    #   @return [String, nil] the statistic name
    attribute :stat_name, Shale::Type::String
  end
end
