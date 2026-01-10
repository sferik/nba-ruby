require "shale"
require "equalizer"

module NBA
  # Represents a playoff matchup in the playoff picture
  #
  # @api public
  # @example
  #   matchup.conference #=> "East"
  #   matchup.high_seed_team #=> "Boston Celtics"
  class PlayoffMatchup < Shale::Mapper
    include Equalizer.new(:conference, :high_seed_team_id, :low_seed_team_id)

    #   Returns the conference name
    #   @api public
    #   @example
    #     matchup.conference #=> "East"
    #   @return [String, nil] the conference name
    attribute :conference, Shale::Type::String

    #   Returns the high seed ranking
    #   @api public
    #   @example
    #     matchup.high_seed_rank #=> 1
    #   @return [Integer, nil] the high seed ranking
    attribute :high_seed_rank, Shale::Type::Integer

    #   Returns the high seed team name
    #   @api public
    #   @example
    #     matchup.high_seed_team #=> "Boston Celtics"
    #   @return [String, nil] the high seed team name
    attribute :high_seed_team, Shale::Type::String

    #   Returns the high seed team ID
    #   @api public
    #   @example
    #     matchup.high_seed_team_id #=> 1610612738
    #   @return [Integer, nil] the high seed team ID
    attribute :high_seed_team_id, Shale::Type::Integer

    #   Returns the low seed ranking
    #   @api public
    #   @example
    #     matchup.low_seed_rank #=> 8
    #   @return [Integer, nil] the low seed ranking
    attribute :low_seed_rank, Shale::Type::Integer

    #   Returns the low seed team name
    #   @api public
    #   @example
    #     matchup.low_seed_team #=> "Miami Heat"
    #   @return [String, nil] the low seed team name
    attribute :low_seed_team, Shale::Type::String

    #   Returns the low seed team ID
    #   @api public
    #   @example
    #     matchup.low_seed_team_id #=> 1610612748
    #   @return [Integer, nil] the low seed team ID
    attribute :low_seed_team_id, Shale::Type::Integer

    #   Returns the high seed series wins
    #   @api public
    #   @example
    #     matchup.high_seed_series_wins #=> 4
    #   @return [Integer, nil] the high seed series wins
    attribute :high_seed_series_wins, Shale::Type::Integer

    #   Returns the low seed series wins
    #   @api public
    #   @example
    #     matchup.low_seed_series_wins #=> 1
    #   @return [Integer, nil] the low seed series wins
    attribute :low_seed_series_wins, Shale::Type::Integer

    #   Returns the series status description
    #   @api public
    #   @example
    #     matchup.series_status #=> "BOS wins 4-1"
    #   @return [String, nil] the series status description
    attribute :series_status, Shale::Type::String
  end
end
