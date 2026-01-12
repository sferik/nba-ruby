module NBA
  # Represents league-wide shot data
  class LeagueWideShotStat < Shale::Mapper
    include Equalizer.new(:shot_zone_basic, :shot_zone_area, :shot_zone_range)

    # @!attribute [rw] grid_type
    #   Returns the grid type
    #   @api public
    #   @example
    #     stat.grid_type #=> "Shot Zone Basic"
    #   @return [String] the grid type
    attribute :grid_type, Shale::Type::String

    # @!attribute [rw] shot_zone_basic
    #   Returns the basic shot zone
    #   @api public
    #   @example
    #     stat.shot_zone_basic #=> "Mid-Range"
    #   @return [String] the basic zone
    attribute :shot_zone_basic, Shale::Type::String

    # @!attribute [rw] shot_zone_area
    #   Returns the shot zone area
    #   @api public
    #   @example
    #     stat.shot_zone_area #=> "Left Side"
    #   @return [String] the zone area
    attribute :shot_zone_area, Shale::Type::String

    # @!attribute [rw] shot_zone_range
    #   Returns the shot zone range
    #   @api public
    #   @example
    #     stat.shot_zone_range #=> "16-24 ft."
    #   @return [String] the zone range
    attribute :shot_zone_range, Shale::Type::String

    # @!attribute [rw] fga
    #   Returns field goals attempted
    #   @api public
    #   @example
    #     stat.fga #=> 1500
    #   @return [Integer] field goals attempted
    attribute :fga, Shale::Type::Integer

    # @!attribute [rw] fgm
    #   Returns field goals made
    #   @api public
    #   @example
    #     stat.fgm #=> 650
    #   @return [Integer] field goals made
    attribute :fgm, Shale::Type::Integer

    # @!attribute [rw] fg_pct
    #   Returns field goal percentage
    #   @api public
    #   @example
    #     stat.fg_pct #=> 0.433
    #   @return [Float] field goal percentage
    attribute :fg_pct, Shale::Type::Float
  end
end
